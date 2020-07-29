-- number 2
SELECT namefirst, namelast, inducted
FROM people LEFT OUTER JOIN hof_inducted
ON people.playerid = hof_inducted.playerid;

-- number 3
SELECT namefirst, namelast, birthyear, deathyear, birthcountry
FROM people INNER JOIN hof_inducted
ON people.playerid = hof_inducted.playerid
WHERE yearid = '2006' AND votedby = 'Negro League';

-- number 4
SELECT salaries.yearid, salaries.playerid, teamid, salary, category
FROM salaries INNER JOIN hof_inducted
ON salaries.playerid = hof_inducted.playerid;

-- number 5
SELECT salaries.playerid, salaries.yearid, teamid, lgid, salary, inducted
FROM salaries FULL OUTER JOIN hof_inducted
ON salaries.playerid = hof_inducted.playerid;

-- number 6 part 1
SELECT * FROM hof_inducted
UNION ALL
SELECT * FROM hof_not_inducted

-- number 6 part 2
SELECT playerid FROM hof_inducted
UNION
SELECT playerid FROM hof_not_inducted

-- number 7
SELECT namelast, namefirst, SUM(salary) AS total_salary
FROM people JOIN salaries
ON people.playerid = salaries.playerid
GROUP BY people.playerid;

-- number 8
SELECT hof_inducted.playerid, hof_inducted.yearid, namefirst, namelast
	FROM hof_inducted LEFT OUTER JOIN people
		ON hof_inducted.playerid = people.playerid
UNION ALL
SELECT hof_not_inducted.playerid, hof_not_inducted.yearid, namefirst, namelast
	FROM hof_not_inducted LEFT OUTER JOIN people
		ON hof_not_inducted.playerid = people.playerid;

-- number 9
SELECT concat(namelast, ' ', namefirst) AS namefull, yearid, inducted
	FROM hof_inducted JOIN people
		ON hof_inducted.playerid = people.playerid
	WHERE yearid >= 1980
UNION ALL
SELECT concat(namelast, ' ', namefirst) AS namefull, yearid, inducted
	FROM hof_not_inducted LEFT OUTER JOIN people
		ON hof_not_inducted.playerid = people.playerid
	WHERE yearid >= 1980
ORDER BY yearid, inducted DESC, namefull;

-- number 10
SELECT MAX(salary) AS highest_salary, teamid, salaries.playerid, namelast, namefirst
FROM salaries JOIN people
	ON salaries.playerid = people.playerid
GROUP BY teamid, salaries.playerid, namelast, namefirst
ORDER BY MAX(salary) DESC;

--number 11
SELECT birthyear, deathyear, namefirst, namelast
FROM people
WHERE birthyear >= 
	(SELECT birthyear FROM people
	WHERE playerid = 'ruthba01')
ORDER BY birthyear;

--number 12
SELECT namefirst, namelast, 
	CASE
		WHEN birthcountry = 'USA' THEN 'USA'
		ELSE 'non-USA'
	END AS usaborn
FROM people
ORDER BY 3;

-- number 13
SELECT
AVG(CASE WHEN throws = 'R' THEN height END) AS right_height,
AVG(CASE WHEN throws = 'L' THEN height END) AS left_height
FROM people;

-- number 14 Get the average of each team's maximum player salary since 2010.
WITH annual_team_salary AS
	(
	SELECT teamid, MAX(salary) AS maximum_salary, yearid
	FROM salaries
	GROUP BY teamid, yearid
	)
SELECT teamid, AVG(maximum_salary) AS max_sal_2010
FROM annual_team_salary
WHERE yearid >= 2010
GROUP BY teamid;

