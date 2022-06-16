--Query Netflix Database from Kaggle to identify content focus added over the years and what rated content had the most impact
--Scan the data we are working with to identify columns that might be important to query
 
SELECT * FROM PortfolioProject..netflix_titles$
ORDER BY show_id
 
-- I dentify the number of movies VS tv shows 
 
 
SELECT Type, Count(*) AS "Total By Type" 
FROM PortfolioProject..netflix_titles$
WHERE Country = 'United States'
Group By Type;
 
--Filter data needed to show only some columns along with the date added in proper DATE format and organized

SELECT Type, Title, Country, CAST(date_added AS DATE) AS "Date Added"
FROM PortfolioProject..netflix_titles$
WHERE Country = 'United States'
ORDER BY "Date Added"
 
 
--filter by united states only

SELECT Type, Title, Country, CAST(date_added AS DATE) AS "Date Added"
FROM PortfolioProject..netflix_titles$
WHERE country = 'United States'
ORDER BY "Date Added"
 
--Further filter between movies and tv shows with dates to show change type of entertainment
 --Number of tv shows added by date //Make VIEW
 
SELECT TYPE, title, country, CAST(date_added AS DATE) AS "Date Added"
FROM PortfolioProject..netflix_titles$
WHERE country = 'United States'
and Type = 'TV Show'
ORDER BY "Date Added"
 
--Number of Movies added by date 
 
SELECT type, title, country, CAST(date_added AS DATE) AS "Date Added"
FROM PortfolioProject..netflix_titles$
WHERE country = 'United States'
and Type = 'Movie'
ORDER BY "Date Added"
 
--Count of content grouped by rating 
 
SELECT  rating, count(rating) AS "Total Content"
FROM PortfolioProject..netflix_titles$
WHERE Country LIKE '%States%'
AND Rating IS NOT NULL
GROUP BY rating
ORDER BY 2 DESC
 
---Amount of TV shows or Movies added by dates to see the difference in years what Netflix is focusing on
 
SELECT CAST(date_added AS DATE) AS "Date Added", Count(type) AS "TV Shows Added by Date"
FROM PortfolioProject..netflix_titles$
WHERE type = 'TV Show'
and Country = 'United States'
GROUP BY Date_added
ORDER BY 1
 
SELECT CAST(date_added AS DATE) AS "Date Added", Count(type) AS "Movies Added by Date"
FROM PortfolioProject..netflix_titles$
WHERE type = 'Movie'
and Country = 'United States'
GROUP BY Date_added
ORDER BY 1
