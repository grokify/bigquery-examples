-- Query Popular Stack Overflow Tags
SELECT
  tag,
  COUNT(tag) AS count
FROM
(
  SELECT SPLIT(tags, '|') AS tag
  FROM `bigquery-public-data.stackoverflow.posts_questions`
  WHERE DATE(creation_date) > '2018-01-01'
), UNNEST(tag) AS tag
GROUP BY tag
ORDER BY count DESC
LIMIT 10