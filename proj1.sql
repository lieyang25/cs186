-- Before running drop any existing views
DROP VIEW IF EXISTS q0;
DROP VIEW IF EXISTS q1i;
DROP VIEW IF EXISTS q1ii;
DROP VIEW IF EXISTS q1iii;
DROP VIEW IF EXISTS q1iv;
DROP VIEW IF EXISTS q2i;
DROP VIEW IF EXISTS q2ii;
DROP VIEW IF EXISTS q2iii;
DROP VIEW IF EXISTS q3i;
DROP VIEW IF EXISTS q3ii;
DROP VIEW IF EXISTS q3iii;
DROP VIEW IF EXISTS q4i;
DROP VIEW IF EXISTS q4ii;
DROP VIEW IF EXISTS q4iii;
DROP VIEW IF EXISTS q4iv;
DROP VIEW IF EXISTS q4v;

-- Question 0
CREATE VIEW q0(era)
AS
  SELECT MAX(era)
  FROM pitching
;

-- Question 1i
CREATE VIEW q1i(namefirst, namelast, birthyear)
AS
  SELECT namefirst,namelast,birthyear
  FROM people
  WHERE weight > 300
;

-- Question 1ii
CREATE VIEW q1ii(namefirst, namelast, birthyear)
AS
  SELECT namefirst, namelast, birthyear
  FROM people
  WHERE namefirst LIKE '% %'
  ORDER BY nameFirst,namelast DESC
;

-- Question 1iii
CREATE VIEW q1iii(birthyear, avgheight, count)
AS
  SELECT birthyear,AVG(height),COUNT(*)
  FROM people
  GROUP BY birthyear
  ORDER BY birthyear
;

-- Question 1iv
CREATE VIEW q1iv(birthyear, avgheight, count)
AS
  SELECT birthyear,AVG(height),COUNT(*)
  FROM people
  GROUP BY birthyear
  HAVING AVG(height) > 70
  ORDER BY birthyear
;

-- Question 2i
CREATE VIEW q2i(namefirst, namelast, playerid, yearid)
AS
  SELECT p.namefirst,p.namelast,h.playerid,h.yearid
  FROM halloffame as h INNER JOIN people AS p
  ON  h.playerid = p.playerid
  WHERE h.inducted = 'Y'
  ORDER BY h.yearid DESC,h.playerid
;

-- Question 2ii
CREATE VIEW q2ii(namefirst, namelast, playerid, schoolid, yearid)
AS
  SELECT p.namefirst,p.namelast,p.playerid,s.schoolid,p.yearid
  FROM schools AS s ,q2i AS p,collegeplaying AS c
  ON s.schoolid = c.schoolid AND p.playerid = c.playerid
  WHERE s.schoolState = 'CA'
  ORDER BY p.yearid DESC ,s.schoolid,p.playerid
;

-- Question 2iii
CREATE VIEW q2iii(playerid, namefirst, namelast, schoolid)
AS
  SELECT p.playerid,p.namefirst,p.namelast,c.schoolid
  FROM q2i AS p LEFT OUTER JOIN collegeplaying AS c
  ON p.playerid = c.playerid
  ORDER BY p.playerid DESC ,c.schoolid
;

-- Question 3i
CREATE VIEW q3i(playerid, namefirst, namelast, yearid, slg)
AS
  SELECT p.playerid, p.namefirst, p.namelast, b.yearid,(b.h+b.h2b+b.h3b*2+b.hr*3 + 0.0)/(b.ab+0.0) AS slg
  FROM people AS p, batting AS b ON p.playerid = b.playerid
  WHERE b.ab > 50
  ORDER BY slg DESC ,b.yearid,b. playerid
  LIMIT 10
;

-- Question 3ii
CREATE VIEW q3ii(playerid, namefirst, namelast, lslg)
AS
  SELECT p.playerid, p.namefirst, p.namelast,(SUM(b.h)+SUM(b.h2b)+SUM(b.h3b*2)+SUM(b.hr*3)+0.0)/(SUM(b.ab)+0.0) AS lslg
  FROM people AS p,batting AS b ON p.playerid = b.playerid
  GROUP BY p.playerid
  HAVING SUM(b.ab) > 50
  ORDER BY lslg DESC,p.playerid
  LIMIT 10
;

-- Question 3iii
CREATE VIEW q3iii(namefirst, namelast, lslg)
AS
  SELECT p.namefirst, p.namelast,p.lslg
  FROM (SELECT p.playerid, p.namefirst, p.namelast,(SUM(b.h)+SUM(b.h2b)+SUM(b.h3b*2)+SUM(b.hr*3)+0.0)/(SUM(b.ab)+0.0) AS lslg
          FROM people AS p,batting AS b ON p.playerid = b.playerid
          GROUP BY p.playerid
          HAVING SUM(b.ab) > 50) AS p
  WHERE p.lslg > (
    SELECT (SUM(b.h)+SUM(b.h2b)+SUM(b.h3b*2)+SUM(b.hr*3)+0.0)/(SUM(b.ab)+0.0) AS lslg
              FROM people AS p,batting AS b ON p.playerid = b.playerid
              WHERE p.playerid = 'mayswi01'
              GROUP BY p.playerid
  )
;

-- Question 4i
CREATE VIEW q4i(yearid, min, max, avg)
AS
  SELECT yearid,MIN(salary),MAX(salary),AVG(salary)
  FROM salaries
  GROUP BY yearid
  ORDER BY yearid
;

-- Question 4ii
CREATE VIEW q4ii(binid, low, high, count)
AS
  SELECT 1, 1, 1, 1 -- replace this line
;

-- Question 4iii
CREATE VIEW q4iii(yearid, mindiff, maxdiff, avgdiff)
AS
  SELECT 1, 1, 1, 1 -- replace this line
;

-- Question 4iv
CREATE VIEW q4iv(playerid, namefirst, namelast, salary, yearid)
AS
  SELECT 1, 1, 1, 1, 1 -- replace this line
;
-- Question 4v
CREATE VIEW q4v(team, diffAvg) AS
  SELECT 1, 1 -- replace this line
;

