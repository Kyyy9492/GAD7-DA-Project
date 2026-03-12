-- ============================================================================
-- Demographic vs Model_Result.Score
-- ============================================================================

-- ============================================================================
-- Gender vs Anxiety Score
SELECT
gender,
COUNT(*) AS sample_size,
AVG(score) AS mean_score,
AVG(CASE 
        WHEN rn IN (FLOOR((cnt + 1) / 2), FLOOR((cnt + 2) / 2))
        THEN score
    END) AS median_score,
STDDEV(score) AS std_score,
MIN(score) AS min_score,
MAX(score) AS max_score
FROM (
    SELECT
        gender,
        score,
        ROW_NUMBER() OVER (PARTITION BY gender ORDER BY score) AS rn,
        COUNT(*) OVER (PARTITION BY gender) AS cnt
    FROM gad7_responses
) t
GROUP BY gender
ORDER BY mean_score DESC;
-- Result:
-- Mean score: 8.79 (female) vs 7.69 (male).
-- Median score: 8 (female) vs 7 (male).

-- Interpretation:
-- Anxiety symptoms appear more prevalent among female participants in this dataset.
-- Further statistical testing (e.g., t-test) could be conducted to determine
-- whether this difference is statistically significant.

-- ============================================================================
-- Age_Group vs Anxiety Score
SELECT
age_group,
COUNT(*) AS sample_size,
AVG(score) AS mean_score,
AVG(CASE 
        WHEN rn IN (FLOOR((cnt + 1) / 2), FLOOR((cnt + 2) / 2))
        THEN score
    END) AS median_score,
STDDEV(score) AS std_score,
MIN(score) AS min_score,
MAX(score) AS max_score
FROM (
    SELECT
        age_group,
        score,
        ROW_NUMBER() OVER (PARTITION BY age_group ORDER BY score) AS rn,
        COUNT(*) OVER (PARTITION BY age_group) AS cnt
    FROM gad7_responses
) t
GROUP BY age_group
ORDER BY mean_score DESC;
-- Result:
-- Younger respondents, especially those under 15, report the highest average GAD-7 score
-- (mean = 10.47, median = 10), while older respondents aged 45+ report lower anxiety levels
-- (mean = 5.61, median = 5). Respondents with unknown age show the lowest scores overall
-- (mean = 4.98, median = 3).

-- Interpretation:
-- This pattern suggests that younger individuals in the dataset tend to experience
-- higher levels of anxiety symptoms, while anxiety levels generally decrease with age.
-- Age therefore appears to be an important factor associated with anxiety scores in this dataset.
-- ============================================================================
-- Marriage Status vs Anxiety Score
SELECT
marriage,
COUNT(*) AS sample_size,
AVG(score) AS mean_score,
AVG(CASE 
        WHEN rn IN (FLOOR((cnt + 1) / 2), FLOOR((cnt + 2) / 2))
        THEN score
    END) AS median_score,
STDDEV(score) AS std_score,
MIN(score) AS min_score,
MAX(score) AS max_score
FROM (
    SELECT
        marriage,
        score,
        ROW_NUMBER() OVER (PARTITION BY marriage ORDER BY score) AS rn,
        COUNT(*) OVER (PARTITION BY marriage) AS cnt
    FROM gad7_responses
) t
GROUP BY marriage
ORDER BY mean_score DESC;
-- Result:
-- Cohabiting respondents report the highest anxiety levels (mean = 9.75, median = 9),
-- followed by unmarried respondents (mean = 9.27, median = 8).
-- Married respondents show the lowest anxiety levels among the major groups (mean = 7.21, median = 6).

-- Interpretation:
-- This suggests that relationship/marital status is associated with different anxiety levels in this sample.
-- However, some categories (e.g., widowed, n=148) have small sample sizes,
-- so conclusions for those groups should be interpreted cautiously.

-- ============================================================================
-- Education vs Anxiety Score
SELECT
education,
COUNT(*) AS sample_size,
AVG(score) AS mean_score,
AVG(CASE 
        WHEN rn IN (FLOOR((cnt + 1) / 2), FLOOR((cnt + 2) / 2))
        THEN score
    END) AS median_score,
STDDEV(score) AS std_score,
MIN(score) AS min_score,
MAX(score) AS max_score
FROM (
    SELECT
        education,
        score,
        ROW_NUMBER() OVER (PARTITION BY education ORDER BY score) AS rn,
        COUNT(*) OVER (PARTITION BY education) AS cnt
    FROM gad7_responses
) t
GROUP BY education
ORDER BY mean_score DESC;
-- Result:
-- Anxiety scores generally decrease as education level increases.
-- Respondents with lower education levels (elementary or middle school)
-- report the highest anxiety scores (mean ≈ 9.6), while respondents with
-- higher education levels such as master's degrees report lower scores
-- (mean ≈ 6.7).

-- Interpretation:
-- This pattern suggests that higher educational attainment is associated
-- with lower reported anxiety levels in this dataset. However, some groups
-- (e.g., PhD holders with n=150) have small sample sizes, so results for
-- those groups should be interpreted cautiously.

-- ============================================================================
-- Income vs Anxiety Score
SELECT
income,
COUNT(*) AS sample_size,
AVG(score) AS mean_score,
AVG(CASE 
        WHEN rn IN (FLOOR((cnt + 1) / 2), FLOOR((cnt + 2) / 2))
        THEN score
    END) AS median_score,
STDDEV(score) AS std_score,
MIN(score) AS min_score,
MAX(score) AS max_score
FROM (
    SELECT
        income,
        score,
        ROW_NUMBER() OVER (PARTITION BY income ORDER BY score) AS rn,
        COUNT(*) OVER (PARTITION BY income) AS cnt
    FROM gad7_responses
) t
GROUP BY income
ORDER BY mean_score DESC;
-- Result:
-- Anxiety scores generally decrease as income increases.
-- The lowest income group (0–50k/yr) reports the highest anxiety level
-- (mean = 9.27, median = 8), while middle-to-high income groups show lower
-- average scores (means mostly around 6.8–7.9, medians around 6–7).

-- Interpretation:
-- This suggests a negative association between income level and reported anxiety
-- in this sample. However, the highest income group (800k+/yr) has a very small
-- sample size (n = 219) and shows a higher mean than expected, so this category
-- may be unstable or influenced by sampling noise and should be interpreted cautiously.

-- ============================================================================
-- Occupation vs Anxiety Score (Top 3 + Bottom 3 by mean_score)
WITH base AS (
    SELECT
        occupation,
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
        score,
        ROW_NUMBER() OVER (PARTITION BY occupation ORDER BY score) AS rn,
        COUNT(*) OVER (PARTITION BY occupation) AS cnt
    FROM gad7_responses
    WHERE score IS NOT NULL
),
stats AS (
    SELECT
        occupation,
        occupation_label,
        COUNT(*) AS sample_size,
        AVG(score) AS mean_score,
        AVG(CASE
                WHEN rn IN (FLOOR((cnt + 1) / 2), FLOOR((cnt + 2) / 2))
                THEN score
            END) AS median_score,
        STDDEV(score) AS std_score,
        MIN(score) AS min_score,
        MAX(score) AS max_score
    FROM base
    GROUP BY occupation, occupation_label
),
ranked AS (
    SELECT
        *,
        DENSE_RANK() OVER (ORDER BY mean_score DESC) AS rnk_top,
        DENSE_RANK() OVER (ORDER BY mean_score ASC)  AS rnk_bottom
    FROM stats
)
SELECT
    occupation,
    occupation_label,
    sample_size,
    ROUND(mean_score, 4) AS mean_score,
    ROUND(median_score, 4) AS median_score,
    ROUND(std_score, 4) AS std_score,
    min_score,
    max_score,
    CASE
        WHEN rnk_top <= 3 THEN 'Top 3 (highest mean)'
        WHEN rnk_bottom <= 3 THEN 'Bottom 3 (lowest mean)'
        ELSE 'Other'
    END AS group_flag
FROM ranked
WHERE rnk_top <= 3 OR rnk_bottom <= 3
ORDER BY mean_score DESC, sample_size DESC;
-- Result:
-- Anxiety scores vary noticeably across occupational groups.
-- The highest anxiety levels are observed among Advertisement workers
-- (mean = 9.68, median = 9), Students (mean = 9.40, median = 9),
-- and Homemakers (mean = 9.19, median = 8).
-- In contrast, Media, Government, and Healthcare occupations show the
-- lowest anxiety levels, with mean scores around 6.6–7.1.

-- Interpretation:
-- These results suggest that occupation may be associated with different
-- levels of reported anxiety in this dataset. Students and occupations
-- related to unstable or high-pressure environments may experience
-- higher anxiety levels, while more stable professions such as
-- government or healthcare show relatively lower scores.
-- However, some occupational groups have smaller sample sizes,
-- so their estimates should be interpreted with caution.
