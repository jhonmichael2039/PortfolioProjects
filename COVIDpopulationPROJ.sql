Select *
From PortfolioProject..CovidDeaths
Where continent is not null
Order By 3, 4;


-- Select Data that we are goiing to be using

Select Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths
Where continent is not null
Order by 1, 2;

-- Lookin at total cases VS total deaths
-- Likelihood of fatality after contracting Covid

Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as "Death Percentage"
From PortfolioProject..CovidDeaths
Where continent is not null
Order by 1, 2 DESC;

-- Looking at total cases VS population
-- Shows perccentage of population contracted Covid

Select Location, date, total_cases, population, (total_cases/population)*100 as "Percentage of Population with Covid"
From PortfolioProject..CovidDeaths
Where continent is not null
Order by 5 DESC;

--Looking at Countries with highest infection rate  compared to population

Select Location, Population, MAX(total_cases) As "Highest Infection Count", MAX((total_cases/population))*100 as "Percentage of Population with Covid"
From PortfolioProject..CovidDeaths
Where continent is not null
Group By Location, population
Order By "Percentage of Population with Covid" DESC;

-- Showing Countries with highest death count per population

Select Location, MAX(CAST(total_deaths as int)) As "Highest Death Count", MAX((total_deaths/population))*100 as "Percentage of Population Fatalities"
From PortfolioProject..CovidDeaths
Where continent is not null
Group By Location
Order By 2 DESC;

-- Show deaths by continent

Select Continent, MAX(CAST(total_deaths as int)) As "Highest Death Count"
From PortfolioProject..CovidDeaths
Where continent is not null
Group By continent
Order By 2 DESC;

--Global Numbers

Select Date, SUM(new_cases) as "Total Cases", SUM(CAST(new_deaths as int)) as "Total Deaths", SUM(CAST(new_deaths as int))/SUM(new_cases)*100 as "Death Percentage"
From PortfolioProject..CovidDeaths
Where continent is not null
Group By Date
Order by 1, 2;

-- Total population VS vaccinations

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations 
From PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
ON dea.location = vac.location
and dea.date = vac.date
Where dea.continent is not null
Order by 2, 3 DESC;


-- Total population VS vaccinations + Rolling Count

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(int, vac.new_vaccinations)) OVER (partition by dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
ON dea.location = vac.location
and dea.date = vac.date
Where dea.continent is not null
Order by 2, 3 DESC;

--USE CTE

with PopvsVac (continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(int, vac.new_vaccinations)) OVER (partition by dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
ON dea.location = vac.location
and dea.date = vac.date
Where dea.continent is not null
)

Select *, (RollingPeopleVaccinated/population)*100
from PopvsVac

--Create View for Deaths by Continents for Tableau or other visuals

CREATE VIEW DeathsbyContinent AS

Select Continent, MAX(CAST(total_deaths as int)) As "Highest Death Count"
From PortfolioProject..CovidDeaths
Where continent is not null
Group By continent
