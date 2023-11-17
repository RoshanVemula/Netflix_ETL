CREATE OR REPLACE VIEW longest_timespan_view AS
SELECT
  t.show_id,
  t.Title,
  t.Release_year,
  m.Date_added,
  DATEDIFF(DAY, TO_DATE(t.Release_year::VARCHAR || '-01-01'), TO_DATE(m.Date_added::VARCHAR, 'Mon DD, YYYY')) AS timespan_days
FROM
  Netflix_titles t
JOIN
  Netflix_movie_added m ON t.show_id = m.time_id
WHERE
  t.Type = 'Movie'
ORDER BY
  timespan_days DESC
LIMIT 1;
