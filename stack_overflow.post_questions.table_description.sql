#standardSQL
-- Question table columns
SELECT
  * EXCEPT(is_generated, generation_expression, is_stored, is_updatable)
FROM
  `bigquery-public-data`.`stackoverflow`.INFORMATION_SCHEMA.COLUMNS
WHERE
  table_name="posts_questions"