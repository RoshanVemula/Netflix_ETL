CREATE OR REPLACE VIEW netflix_actresses_with_woody AS
SELECT 
  TRIM(SPLIT_PART(CAST, ',', 1)) AS actress_name,
  COUNT(*) AS movie_count
FROM 
  Netflix_titles
WHERE 
  TYPE = 'Movie'
  AND 'Woody Harrelson' IN (TRIM(SPLIT_PART(Cast, ',', 1)), TRIM(SPLIT_PART(Cast, ',', 2)))
GROUP BY 
  actress_name
HAVING 
  COUNT(*) > 1;