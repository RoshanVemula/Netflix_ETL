-- Create or replace view for year-on-year increase for TV Shows
CREATE OR REPLACE VIEW tv_show_year_on_year_increase AS
SELECT
  t1.Release_year AS year,
  t1.Count_TV_Shows AS tv_show_count,
  t2.Count_TV_Shows AS previous_year_tv_show_count,
  CASE
    WHEN t2.Count_TV_Shows = 0 THEN 100.0
    ELSE ROUND(((t1.Count_TV_Shows - t2.Count_TV_Shows) / t2.Count_TV_Shows) * 100, 2)
  END AS year_on_year_increase_percentage
FROM
  (
    SELECT
      Release_year,
      COUNT(*) AS Count_TV_Shows
    FROM
      Netflix_titles
    WHERE
      Type = 'TV Show'
    GROUP BY
      Release_year
  ) t1
LEFT JOIN
  (
    SELECT
      Release_year,
      COUNT(*) AS Count_TV_Shows
    FROM
      Netflix_titles
    WHERE
      Type = 'TV Show'
    GROUP BY
      Release_year
  ) t2
ON
  t1.Release_year = t2.Release_year + 1;