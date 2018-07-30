#standardSQL
-- Query Vote Tags By Answerer
SELECT
  tag,
  COUNT(tag) AS count
FROM
(
  SELECT SPLIT(q.tags, '|') AS tag
  FROM `bigquery-public-data.stackoverflow.votes` v
    LEFT JOIN `bigquery-public-data.stackoverflow.posts_answers` a
      ON v.post_id = a.id
    LEFT JOIN `bigquery-public-data.stackoverflow.posts_questions` q
      ON a.parent_id = q.id
  WHERE a.owner_user_id = 1908967
    AND v.vote_type_id IN (1, 2)
    AND DATE(v.creation_date) < DATE('2015-06-29')
), UNNEST(tag) AS tag
GROUP BY tag
ORDER BY count DESC
LIMIT 10