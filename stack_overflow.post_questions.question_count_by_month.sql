#standardSQL
-- Question table columns
SELECT
  FORMAT_DATETIME('%Y%m', DATETIME(creation_date)) AS month,
  COUNT(*) AS count
FROM
  `bigquery-public-data`.stackoverflow.posts_questions
WHERE
  tags LIKE '%python%'
GROUP BY
  FORMAT_DATETIME('%Y%m', DATETIME(creation_date))