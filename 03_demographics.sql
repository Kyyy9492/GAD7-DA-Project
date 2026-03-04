USE gad7_project;

SELECT * FROM gad7_responses;

-- BASIC DATA STATISTICS
SELECT COUNT(*) FROM gad7_responses;

SELECT 
gender,
COUNT(*) as count,
COUNT(*) * 1.0 / SUM(COUNT(*)) OVER() as percentage
FROM gad7_responses
GROUP BY gender;

SELECT
marriage,
COUNT(*) as count,
COUNT(*) * 1.0 / SUM(COUNT(*)) OVER() as percentage
FROM gad7_responses
GROUP BY marriage
ORDER BY marriage asc;

SELECT
education,
COUNT(*) as count,
COUNT(*) * 1.0 / SUM(COUNT(*)) OVER() as percentage
FROM gad7_responses
GROUP BY education
ORDER BY education asc;

SELECT
income,
COUNT(*) as count,
COUNT(*) * 1.0 / SUM(COUNT(*)) OVER() as percentage
FROM gad7_responses
GROUP BY income
ORDER BY income asc;

SELECT 
occupation, 
COUNT(*) as count
FROM gad7_responses
GROUP BY occupation
ORDER BY count DESC;

SELECT
age_group,
COUNT(*) as count,
COUNT(*) * 1.0 / SUM(COUNT(*)) OVER() as percentage
FROM gad7_responses
GROUP BY age_group
ORDER BY age_group;

-- GAD7 QUESTIONAIRE STATISTICS
SELECT q40, COUNT(*) as count
FROM gad7_responses
GROUP BY q40
ORDER BY q40;

SELECT q50, COUNT(*) as count
FROM gad7_responses
GROUP BY q50
ORDER BY q50;

SELECT q60, COUNT(*) as count
FROM gad7_responses
GROUP BY q60
ORDER BY q60;

SELECT q70, COUNT(*) as count
FROM gad7_responses
GROUP BY q70
ORDER BY q70;

SELECT q80, COUNT(*) as count
FROM gad7_responses
GROUP BY q80
ORDER BY q80;

SELECT q90, COUNT(*) as count
FROM gad7_responses
GROUP BY q90
ORDER BY q90;

SELECT q100, COUNT(*) as count
FROM gad7_responses
GROUP BY q100
ORDER BY q100;

SELECT 'q40' as question, AVG(q40) as avg_score FROM gad7_responses
UNION ALL
SELECT 'q50', AVG(q50) FROM gad7_responses
UNION ALL
SELECT 'q60', AVG(q60) FROM gad7_responses
UNION ALL
SELECT 'q70', AVG(q70) FROM gad7_responses
UNION ALL
SELECT 'q80', AVG(q80) FROM gad7_responses
UNION ALL
SELECT 'q90', AVG(q90) FROM gad7_responses
UNION ALL
SELECT 'q100', AVG(q100) FROM gad7_responses
ORDER BY avg_score DESC;

SELECT score, COUNT(*) AS count
FROM gad7_responses
GROUP BY score
ORDER BY score;

SELECT
CASE
    WHEN score >= 0 AND score <= 4 THEN 'Minimal'
    WHEN score >= 5 AND score <= 9 THEN 'Mild'
    WHEN score >= 10 AND score <= 14 THEN 'Moderate'
    WHEN score >= 15 AND score <= 21 THEN 'Severe'
    ELSE 'Unknown'
END AS anxiety_level,
COUNT(*) as count
FROM gad7_responses
GROUP BY anxiety_level
ORDER BY count DESC;
