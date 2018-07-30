SELECT
  tag,
  SUM(CAST(reputation AS int64)) AS reputation
FROM (
  SELECT
    tag AS tag,
    COUNT(tag) AS count,
    vote_type_id,
    IF(vote_type_id=1, COUNT(tag)*15, IF(vote_type_id=2, COUNT(tag)*10 ,0)) AS reputation
  FROM
  (
    SELECT
      SPLIT(q.tags, '|') AS tag,
      v.vote_type_id
    FROM `bigquery-public-data.stackoverflow.votes` v
      LEFT JOIN `bigquery-public-data.stackoverflow.posts_answers` a
        ON v.post_id = a.id
      LEFT JOIN `bigquery-public-data.stackoverflow.posts_questions` q
        ON a.parent_id = q.id
    WHERE a.owner_user_id = 1908967
      AND v.vote_type_id in (1, 2)
      AND DATE(v.creation_date) < DATE('2015-06-29')
  ), UNNEST(tag) AS tag
  GROUP BY tag, vote_type_id
) AS tagreputation
GROUP BY tag
ORDER BY reputation DESC