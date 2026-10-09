-- OTT Content Trend Analysis | table: titles (netflix.db)

-- Q1: top 10 genres
SELECT main_genre, COUNT(*) AS total
FROM titles
GROUP BY main_genre
ORDER BY total DESC
LIMIT 10;

-- Q2: har saal kitne Movies / TV Shows add hue
SELECT year_added, type, COUNT(*) AS added
FROM titles
WHERE year_added IS NOT NULL
GROUP BY year_added, type
ORDER BY year_added;

-- Q3: countries jinke 50 se zyada titles hain
SELECT main_country, COUNT(*) AS total
FROM titles
WHERE main_country != 'Unknown'
GROUP BY main_country
HAVING COUNT(*) > 50
ORDER BY total DESC;

-- Q4: movie ki average length release year ke hisaab se
SELECT release_year, ROUND(AVG(duration_num), 1) AS avg_minutes
FROM titles
WHERE type = 'Movie' AND release_year >= 2000
GROUP BY release_year
ORDER BY release_year;

-- Q5: JOIN - country ko region table se jodke region-wise count
-- (regions table notebook mein banayi: main_country, region)
SELECT COALESCE(r.region, 'Other') AS region, t.type, COUNT(*) AS total
FROM titles t
LEFT JOIN regions r ON t.main_country = r.main_country
WHERE t.main_country != 'Unknown'
GROUP BY COALESCE(r.region, 'Other'), t.type
ORDER BY region, total DESC;

-- Q6: har country mein mature content (TV-MA / R / NC-17) ka percentage
SELECT main_country,
       COUNT(*) AS total,
       ROUND(100.0 * SUM(CASE WHEN rating IN ('TV-MA','R','NC-17') THEN 1 ELSE 0 END) / COUNT(*), 1) AS mature_pct
FROM titles
WHERE main_country != 'Unknown'
GROUP BY main_country
HAVING COUNT(*) > 100
ORDER BY mature_pct DESC;

-- Netflix vs Prime (all_titles = dono platforms ki combined table, platform column ke saath)

-- Q7: har platform mein Movies / TV Shows ka share
SELECT platform, type, COUNT(*) AS total,
       ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY platform), 1) AS pct_of_platform
FROM all_titles
GROUP BY platform, type;

-- Q8: Comedy, Action aur Horror ka share platform-wise
SELECT platform,
       ROUND(100.0 * SUM(CASE WHEN listed_in LIKE '%Comed%' THEN 1 ELSE 0 END) / COUNT(*), 1) AS comedy_pct,
       ROUND(100.0 * SUM(CASE WHEN listed_in LIKE '%Action%' THEN 1 ELSE 0 END) / COUNT(*), 1) AS action_pct,
       ROUND(100.0 * SUM(CASE WHEN listed_in LIKE '%Horror%' THEN 1 ELSE 0 END) / COUNT(*), 1) AS horror_pct
FROM all_titles
GROUP BY platform;

-- Q9: average movie length aur 2000 se pehle ke titles
SELECT platform, ROUND(AVG(duration_num), 1) AS avg_movie_minutes,
       SUM(CASE WHEN release_year < 2000 THEN 1 ELSE 0 END) AS pre_2000_titles
FROM all_titles
WHERE type = 'Movie'
GROUP BY platform;
