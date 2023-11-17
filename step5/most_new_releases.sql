CREATE VIEW most_releases_by_month AS
SELECT
  DATE_TRUNC('MONTH', TO_DATE(Date_added)) AS release_month,
  COUNT(*) AS release_count
FROM
  Netflix_movie_added
WHERE
  Date_added IS NOT NULL
GROUP BY
  release_month
ORDER BY
  release_count DESC;

-- to retrive the most releases
  Select * 
  From most_releases_by_month
  Limit 1;