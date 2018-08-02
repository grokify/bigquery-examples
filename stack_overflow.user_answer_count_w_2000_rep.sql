#standardSQL
-- answer count for most recnet users with 2000 rep
SELECT
  owner_user_id,
  COUNT(id) AS answer_count,
  CONCAT("https://stackoverflow.com/users/", CAST(owner_user_id AS STRING)) AS user_url
FROM `bigquery-public-data.stackoverflow.posts_answers`
WHERE owner_user_id IN (
  SELECT id FROM `bigquery-public-data.stackoverflow.users`
  WHERE reputation=2000
  ORDER BY creation_date DESC
  LIMIT 100 )
GROUP BY owner_user_id
ORDER BY answer_count DESC