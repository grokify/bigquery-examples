#standardSQL
-- Count the number of days of user posts
SELECT
  COUNT(post_date) AS post_days_count
FROM (
  SELECT post_date
  FROM (
    (
      SELECT DATE(creation_date) AS post_date
      FROM `bigquery-public-data.stackoverflow.posts_questions`
      WHERE owner_user_id = 1908967
        AND DATE(creation_date) < DATE('2015-06-21')
      GROUP BY post_date
    )
    UNION ALL
    (
      SELECT DATE(creation_date) AS post_date
      FROM `bigquery-public-data.stackoverflow.posts_answers`
      WHERE owner_user_id = 1908967
        AND DATE(creation_date) < DATE('2015-06-21')
      GROUP BY post_date
    )
  )
  GROUP BY post_date
)

-- Count the number of days of user posts
WITH post_dates AS (
  SELECT post_date
  FROM (
    (
      SELECT DATE(creation_date) AS post_date
      FROM `bigquery-public-data.stackoverflow.posts_questions`
      WHERE owner_user_id = 1908967
        AND DATE(creation_date) < DATE('2015-06-21')
      GROUP BY post_date
    )
    UNION ALL
    (
      SELECT DATE(creation_date) AS post_date
      FROM `bigquery-public-data.stackoverflow.posts_answers`
      WHERE owner_user_id = 1908967
        AND DATE(creation_date) < DATE('2015-06-21')
      GROUP BY post_date
    )
  )
  GROUP BY post_date
)
SELECT COUNT(post_date) AS post_days_count
FROM post_dates