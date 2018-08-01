#standardSQL
-- Question Velocity for Popular Tags
SELECT
  tag,
  COUNT(tag) AS count_last_3_months,
  CAST(COUNT(tag) / 90 AS INT64) AS count_per_day,
  CAST(COUNT(tag) / 90 / 24 AS INT64) AS count_per_hour
FROM
(
  SELECT SPLIT(q.tags, '|') AS tag
  FROM `bigquery-public-data.stackoverflow.posts_questions` q
  CROSS JOIN
  (
    SELECT DATETIME_SUB(DATETIME(creation_date), INTERVAL 3 MONTH) AS start
    FROM `bigquery-public-data.stackoverflow.posts_questions`
    ORDER BY creation_date DESC
    LIMIT 1
  ) AS dates
  WHERE DATETIME(q.creation_date) >= dates.start
), UNNEST(tag) AS tag
GROUP BY tag
ORDER BY count_last_3_months DESC