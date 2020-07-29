-- 1
SELECT
	table_name,
	column_name,
	data_type
FROM 
	information_schema.columns
WHERE 
	table_name = 'naep';

-- 2
SELECT *
FROM naep
LIMIT 50;

-- 3
SELECT
	state,
	COUNT(avg_math_4_score) AS score_count,
	ROUND(AVG(avg_math_4_score), 3) AS average_score,
	MIN(avg_math_4_score) AS min_score,
	MAX(avg_math_4_score) AS max_score
FROM naep
GROUP BY state
ORDER BY state;

-- 4
SELECT
	state,
	COUNT(avg_math_4_score) AS score_count,
	ROUND(AVG(avg_math_4_score), 3) AS average_score,
	MIN(avg_math_4_score) AS min_score,
	MAX(avg_math_4_score) AS max_score
FROM naep
GROUP BY state
HAVING 
	ABS(MAX(avg_math_4_score) - MIN(avg_math_4_score)) > 30
ORDER BY state;

-- 5
SELECT state AS bottem_10_states
FROM naep
WHERE year = '2000'
ORDER BY avg_math_4_score
LIMIT 10;

-- 6
SELECT
	ROUND(AVG(avg_math_4_score), 2) AS average_score_2000 
FROM naep
WHERE year = '2000';


-- 7
WITH tmp_avg2000 AS 
(
	SELECT
		ROUND(AVG(avg_math_4_score), 2) AS average_score_2000 
	FROM naep
	WHERE year = '2000'
	)
SELECT 
	state AS below_average_states_y2000
FROM naep
WHERE 
	avg_math_4_score < (SELECT average_score_2000 FROM tmp_avg2000) 
AND 
	year = '2000';
	
-- 8
SELECT state AS scores_missing_y2000
FROM naep
WHERE avg_math_4_score IS NULL AND year = '2000';

-- 9
SELECT 
	naep.state,
	ROUND(avg_math_4_score, 2) AS avg_math_4_score,
	total_expenditure
FROM naep LEFT OUTER JOIN finance
	ON naep.id = finance.id
WHERE naep.year = '2000' 
	  AND
	  avg_math_4_score IS NOT NULL
ORDER BY total_expenditure DESC;



