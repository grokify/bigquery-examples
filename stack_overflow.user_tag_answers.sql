#standardSQL
-- User Answer Counts by Tag
SELECT
  tag,
  COUNT(tag) AS answer_count
FROM (
  SELECT SPLIT(q.tags, '|') AS tag
  FROM `bigquery-public-data.stackoverflow.posts_answers` a
    LEFT JOIN `bigquery-public-data.stackoverflow.posts_questions` q
      ON a.parent_id = q.id
  WHERE a.owner_user_id = 1908967
    AND DATE(a.creation_date) < DATE('2015-06-29')
), UNNEST(tag) AS tag
GROUP BY tag
ORDER BY answer_count DESC
LIMIT 20
