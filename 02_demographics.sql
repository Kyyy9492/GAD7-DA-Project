-- ============================================================================
-- 1. BASIC DATA STATISTICS
-- ============================================================================

-- Sample Size
SELECT COUNT(*) FROM gad7_responses;
-- Result:
-- The dataset contains approximately 30,000 responses.
-- Interpretation:
-- This sample size is large enough for stable descriptive statistics and subgroup comparisons.

-- ============================================================================
-- 2. DEMOGRAPHIC DISTRIBUTION
-- ============================================================================

-- Gender Distribution
SELECT
    CASE gender
        WHEN 0 THEN 'Male'
        WHEN 1 THEN 'Female'
        ELSE 'Unknown'
    END AS gender_label,
    COUNT(*) AS count,
    COUNT(*) * 1.0 / SUM(COUNT(*)) OVER () AS percentage
FROM gad7_responses
GROUP BY gender_label
ORDER BY count DESC;
-- Result:
-- The gender distribution is imbalanced: female respondents make up the majority of the sample.
-- Interpretation:
-- Downstream analyses involving gender should consider potential sampling bias; report both counts and percentages.


-- Marriage Status
SELECT
  CASE marriage
    WHEN 0 THEN 'Unmarried'
    WHEN 1 THEN 'Cohabiting'
    WHEN 2 THEN 'Married'
    WHEN 3 THEN 'Divorced'
    WHEN 4 THEN 'Widowed'
    ELSE 'Unknown'
  END AS marriage_label,
  COUNT(*) AS count,
  COUNT(*) * 1.0 / SUM(COUNT(*)) OVER() AS percentage
FROM gad7_responses
GROUP BY marriage_label
ORDER BY count DESC;
-- Result:
-- The sample is concentrated in the unmarried and married categories; other categories (cohabiting/divorced/widowed) are relatively small.
-- Interpretation:
-- When comparing anxiety levels across marriage groups, smaller groups may have higher variance; consider combining rare groups or using caution in interpretation.

-- Education Status
SELECT
    CASE education
        WHEN 0 THEN 'Elementary school'
        WHEN 1 THEN 'Middle school'
        WHEN 2 THEN 'High school'
        WHEN 3 THEN 'College'
        WHEN 4 THEN 'University (Bachelor)'
        WHEN 5 THEN 'Master'
        WHEN 6 THEN 'Ph.D'
        ELSE 'Unknown'
    END AS education_label,
    COUNT(*) AS count,
    COUNT(*) * 1.0 / SUM(COUNT(*)) OVER () AS percentage
FROM gad7_responses
GROUP BY education_label
ORDER BY count DESC;
-- Result:
-- The sample is skewed toward mid-to-high education levels (especially university/bachelor), while master/Ph.D is a small minority.
-- Interpretation:
-- Education-related conclusions may reflect sampling composition; use percentages and avoid over-interpreting small advanced-degree groups.

-- Income level Status
SELECT
    CASE income
        WHEN 0 THEN '0–50k/yr'
        WHEN 1 THEN '50–100k/yr'
        WHEN 2 THEN '100–200k/yr'
        WHEN 3 THEN '200–400k/yr'
        WHEN 4 THEN '400–800k/yr'
        WHEN 5 THEN '800k+/yr'
        ELSE 'Unknown'
    END AS income_label,
    COUNT(*) AS count,
    COUNT(*) * 1.0 / SUM(COUNT(*)) OVER () AS percentage
FROM gad7_responses
GROUP BY income_label
ORDER BY count DESC;
-- Result:
-- Lower income brackets represent the largest share of respondents, and sample share decreases as income increases.
-- Interpretation:
-- This distribution suggests the dataset may over-represent lower-income participants; control for income when analyzing anxiety score differences across other demographics.
 
-- Occupation Status
SELECT
    CASE occupation
        WHEN 0 THEN 'Tech industry'
        WHEN 1 THEN 'Finance'
        WHEN 2 THEN 'Healthcare'
        WHEN 3 THEN 'Media'
        WHEN 4 THEN 'Government'
        WHEN 5 THEN 'Teacher'
        WHEN 6 THEN 'Advertisement'
        WHEN 7 THEN 'Homemaker'
        WHEN 8 THEN 'Entrepreneur'
        WHEN 9 THEN 'Service'
        WHEN 10 THEN 'Worker'
        WHEN 11 THEN 'Farmer'
        WHEN 12 THEN 'Student'
        ELSE 'Unknown'
    END AS occupation_label,
    COUNT(*) AS count,
    COUNT(*) * 1.0 / SUM(COUNT(*)) OVER () AS percentage
FROM gad7_responses
GROUP BY occupation_label
ORDER BY count DESC;
-- Result:
-- A few occupation categories account for a large share of the sample (top categories by count appear at the top of the output).
-- Interpretation:
-- The occupational mix can influence overall anxiety patterns (e.g., student-heavy samples). Consider stratified analysis or weighting if generalization is needed.

-- Age Group Status
SELECT
age_group,
COUNT(*) as count,
COUNT(*) * 1.0 / SUM(COUNT(*)) OVER() as percentage
FROM gad7_responses
GROUP BY age_group
ORDER BY age_group;
-- Result:
-- The sample is younger-skewed: the youngest age group contributes the largest share, with decreasing sample sizes in older groups.
-- Interpretation:
-- Age is likely a key confounder; include age_group in bivariate and regression analyses to separate age effects from other demographic effects.

-- ============================================================================
-- 3. GAD7 QUESTIONAIRE STATISTICS
-- ============================================================================

SELECT 'q40' AS question, q40 AS response, COUNT(*) AS count
FROM gad7_responses
GROUP BY q40
UNION ALL
SELECT 'q50', q50, COUNT(*) FROM gad7_responses GROUP BY q50
UNION ALL
SELECT 'q60', q60, COUNT(*) FROM gad7_responses GROUP BY q60
UNION ALL
SELECT 'q70', q70, COUNT(*) FROM gad7_responses GROUP BY q70
UNION ALL
SELECT 'q80', q80, COUNT(*) FROM gad7_responses GROUP BY q80
UNION ALL
SELECT 'q90', q90, COUNT(*) FROM gad7_responses GROUP BY q90
UNION ALL
SELECT 'q100', q100, COUNT(*) FROM gad7_responses GROUP BY q100
ORDER BY question, response;
-- Result:
-- Frequency tables below show response distributions for each GAD-7 item (0–3).
-- Interpretation:
-- These distributions help identify which symptoms are most commonly reported and whether responses are skewed toward lower or higher severity.

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
-- Result:
-- Items are ranked by average score to highlight the most frequently endorsed symptoms.
-- Interpretation:
-- Higher average item scores indicate symptoms that are more prevalent or more severe in this sample.

SELECT score, COUNT(*) AS count
FROM gad7_responses
GROUP BY score
ORDER BY score;
-- Result:
-- The table shows the distribution of total GAD-7 scores (0–21).
-- Interpretation:
-- This provides an overview of overall anxiety severity in the sample and is useful for checking skewness and potential outliers.

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
-- Result:
-- Respondents are grouped into standard GAD-7 severity categories (Minimal/Mild/Moderate/Severe).
-- Interpretation:
-- Reporting severity categories makes results easier to interpret than raw scores and is useful for cross-tabulation in later steps.

SELECT
AVG(score) AS mean_score,
STDDEV(score) AS std_score,
MIN(score) AS min_score,
MAX(score) AS max_score
FROM gad7_responses;
-- Result:
-- Summary statistics (mean, standard deviation, min, max) describe central tendency and spread of total GAD-7 scores.
-- Interpretation:
-- Use these as baseline metrics; later analyses will examine how the mean score varies across demographic groups.

SELECT AVG(score) AS median_score
FROM (
    SELECT
        score,
        ROW_NUMBER() OVER (ORDER BY score) AS row_num,
        COUNT(*) OVER () AS total_rows
    FROM gad7_responses
) t
WHERE row_num IN (
    FLOOR((total_rows + 1) / 2),
    FLOOR((total_rows + 2) / 2)
);
-- Result:
-- Median score is computed using row numbers to handle the ordered distribution.
-- Interpretation:
-- Median is robust to skewness and complements the mean when the score distribution is not symmetric.