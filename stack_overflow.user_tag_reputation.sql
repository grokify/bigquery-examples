#standardSQL
-- Query Tag Reputation For User
SELECT
  votes.tag AS vote_tag,
  (votes.count * 10 + accepts.count * 15) AS reputation,
  votes.count AS vote_count,
  accepts.count AS accept_count
FROM (
  SELECT
    tag,
    COUNT(tag) AS count
  FROM (
    SELECT SPLIT(q.tags, '|') AS tag
    FROM `bigquery-public-data.stackoverflow.votes` v
      LEFT JOIN `bigquery-public-data.stackoverflow.posts_answers` a
        ON v.post_id = a.id
      LEFT JOIN `bigquery-public-data.stackoverflow.posts_questions` q
        ON a.parent_id = q.id
    WHERE a.owner_user_id = 1908967
      AND v.vote_type_id = 2
      AND DATE(v.creation_date) < DATE('2015-06-29')
  ), UNNEST(tag) AS tag
  GROUP BY tag
  ORDER BY count DESC
) AS votes
FULL OUTER JOIN (
  SELECT
    tag,
    COUNT(tag) AS count
  FROM (
    SELECT SPLIT(q.tags, '|') AS tag
    FROM `bigquery-public-data.stackoverflow.votes` v
      LEFT JOIN `bigquery-public-data.stackoverflow.posts_answers` a
        ON v.post_id = a.id
      LEFT JOIN `bigquery-public-data.stackoverflow.posts_questions` q
        ON a.parent_id = q.id
    WHERE a.owner_user_id = 1908967
      AND v.vote_type_id = 1
      AND DATE(v.creation_date) < DATE('2015-06-29')
  ), UNNEST(tag) AS tag
  GROUP BY tag
  ORDER BY count DESC
) AS accepts
ON votes.tag = accepts.tag
ORDER BY reputation DESC
