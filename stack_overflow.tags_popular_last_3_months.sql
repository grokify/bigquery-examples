#standardSQL
-- Query Popular Stack Overflow Tags Last 3 Months
SELECT
  tag,
  COUNT(tag) AS count_last_3_months,
  CAST(COUNT(tag) / 90 AS INT64) AS count_per_day,
  CAST(COUNT(tag) / 90 / 24 AS INT64) AS count_per_hour
FROM
(
  SELECT
    SPLIT(q.tags, '|') AS tag
  FROM `bigquery-public-data.stackoverflow.posts_questions` q
  CROSS JOIN
  (
    SELECT
      DATETIME_SUB(DATETIME(latest.creation_date), INTERVAL 3 MONTH) AS start,
      latest.creation_date AS `end`
    FROM
    (
      SELECT creation_date FROM `bigquery-public-data.stackoverflow.posts_questions`
      ORDER BY creation_date DESC
      LIMIT 1
    ) AS latest
  ) AS dates
  WHERE DATETIME(q.creation_date) >= dates.start
), UNNEST(tag) AS tag
GROUP BY tag
ORDER BY count_last_3_months DESC