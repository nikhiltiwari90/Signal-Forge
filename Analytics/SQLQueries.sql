-- ============================================================
-- SignalForge — Maintenance Log Analysis Queries
-- Author: Nikhil Tiwari, Product Manager
-- Octacorps Industrial Automation Consultancy — Confidential
-- Illustrative queries based on engagement analysis approach.
-- No production data included; schema reconstructed from memory.
-- ============================================================

-- QUERY 1: First-Time-Fix Rate baseline calculation
SELECT
    equipment_category,
    COUNT(repair_id)                                        AS total_repairs,
    SUM(CASE WHEN repeat_visit_flag = FALSE THEN 1 ELSE 0 END) AS first_time_fixes,
    ROUND(
        SUM(CASE WHEN repeat_visit_flag = FALSE THEN 1 ELSE 0 END) * 100.0
        / NULLIF(COUNT(repair_id), 0), 1
    )                                                        AS ftfr_pct
FROM maintenance_dispatch_log
WHERE dispatch_date BETWEEN '2024-01-01' AND '2024-06-30'
GROUP BY equipment_category
ORDER BY ftfr_pct ASC;


-- QUERY 2: MTTR by equipment category
SELECT
    equipment_category,
    COUNT(repair_id)                                       AS total_repairs,
    ROUND(AVG(repair_duration_minutes), 1)                 AS avg_mttr_minutes
FROM maintenance_dispatch_log
WHERE dispatch_date BETWEEN '2024-01-01' AND '2024-06-30'
GROUP BY equipment_category
ORDER BY avg_mttr_minutes DESC;


-- QUERY 3: Technician skill-mismatch proxy
-- (repairs requiring a second technician with different skill code)
SELECT
    d1.technician_skill_code   AS first_dispatch_skill,
    d2.technician_skill_code   AS second_dispatch_skill,
    COUNT(*)                   AS mismatch_count
FROM maintenance_dispatch_log d1
JOIN maintenance_dispatch_log d2
    ON d1.breakdown_id = d2.breakdown_id
    AND d2.dispatch_sequence = d1.dispatch_sequence + 1
WHERE d1.technician_skill_code <> d2.technician_skill_code
GROUP BY first_dispatch_skill, second_dispatch_skill
ORDER BY mismatch_count DESC;


-- QUERY 4: Downtime hours by equipment category and month
SELECT
    DATE_FORMAT(breakdown_start, '%Y-%m')   AS month,
    equipment_category,
    SUM(downtime_minutes) / 60.0            AS downtime_hours
FROM equipment_breakdown_log
WHERE breakdown_start >= '2024-01-01'
GROUP BY month, equipment_category
ORDER BY month, downtime_hours DESC;


-- QUERY 5: Associate strain exposure index (proxy calculation)
-- ASEI = sum(workaround_duration_min * load_factor) per work area per shift
SELECT
    work_area,
    shift,
    SUM(workaround_duration_minutes * load_factor) / 60.0   AS asei_score,
    COUNT(workaround_id)                                    AS workaround_incident_count
FROM associate_workaround_log
WHERE observed_date BETWEEN '2024-07-01' AND '2024-09-30'
GROUP BY work_area, shift
ORDER BY asei_score DESC;


-- QUERY 6: Pilot validation — FTFR trend by week (post-rollout)
SELECT
    YEARWEEK(dispatch_date)                                AS pilot_week,
    COUNT(repair_id)                                        AS total_repairs,
    ROUND(
        SUM(CASE WHEN repeat_visit_flag = FALSE THEN 1 ELSE 0 END) * 100.0
        / NULLIF(COUNT(repair_id), 0), 1
    )                                                        AS ftfr_pct
FROM maintenance_dispatch_log
WHERE dispatch_date >= '2024-10-01'   -- pilot rollout date
  AND equipment_category IN ('conveyor', 'loom_feeder', 'dyeing_pump')
GROUP BY pilot_week
ORDER BY pilot_week;

-- QUERY 7: Signal Anomaly Agent precision validation
-- (what % of flagged anomalies preceded a confirmed repair within 7 days)
SELECT
    sa.machine_id,
    sa.signal_type,
    COUNT(sa.anomaly_id)                                    AS total_anomalies_flagged,
    SUM(CASE WHEN m.repair_id IS NOT NULL THEN 1 ELSE 0 END) AS confirmed_true_positives,
    ROUND(
        SUM(CASE WHEN m.repair_id IS NOT NULL THEN 1 ELSE 0 END) * 100.0
        / NULLIF(COUNT(sa.anomaly_id), 0), 1
    )                                                        AS precision_pct
FROM signal_anomaly_log sa
LEFT JOIN maintenance_dispatch_log m
    ON sa.machine_id = m.machine_id
    AND m.dispatch_date BETWEEN sa.flagged_at AND DATE_ADD(sa.flagged_at, INTERVAL 7 DAY)
GROUP BY sa.machine_id, sa.signal_type
ORDER BY precision_pct ASC;


-- QUERY 8: Failure Prediction Agent — mode match rate
SELECT
    fp.predicted_failure_mode,
    m.actual_failure_mode,
    COUNT(*)                                                AS prediction_count,
    SUM(CASE WHEN fp.predicted_failure_mode = m.actual_failure_mode
             THEN 1 ELSE 0 END)                              AS correct_matches,
    ROUND(
        SUM(CASE WHEN fp.predicted_failure_mode = m.actual_failure_mode
                 THEN 1 ELSE 0 END) * 100.0 / NULLIF(COUNT(*), 0), 1
    )                                                        AS mode_match_pct,
    ROUND(AVG(TIMESTAMPDIFF(MINUTE, fp.predicted_at, m.breakdown_confirmed_at)), 0)
                                                             AS avg_lead_time_minutes
FROM failure_prediction_log fp
JOIN maintenance_dispatch_log m
    ON fp.machine_id = m.machine_id
    AND m.dispatch_date BETWEEN fp.predicted_at AND DATE_ADD(fp.predicted_at, INTERVAL 48 HOUR)
GROUP BY fp.predicted_failure_mode, m.actual_failure_mode
ORDER BY prediction_count DESC;


-- QUERY 9: Dispatch Optimization Agent — recommendation acceptance rate
SELECT
    COUNT(*)                                                AS total_recommendations,
    SUM(CASE WHEN actual_technician_id = recommended_technician_id
             THEN 1 ELSE 0 END)                              AS recommendation_accepted,
    ROUND(
        SUM(CASE WHEN actual_technician_id = recommended_technician_id
                 THEN 1 ELSE 0 END) * 100.0 / NULLIF(COUNT(*), 0), 1
    )                                                        AS acceptance_rate_pct
FROM dispatch_recommendation_log
WHERE recommended_at >= '2024-10-01';

-- ============================================================
-- Tables referenced (schema reconstructed for illustration):
--   maintenance_dispatch_log   — Per-repair dispatch records
--   equipment_breakdown_log    — Breakdown start/end timestamps
--   associate_workaround_log   — Observed manual workaround incidents
--   signal_anomaly_log         — Agent 1 output: flagged anomalies
--   failure_prediction_log     — Agent 2 output: predicted failure modes
--   dispatch_recommendation_log — Agent 3 output: technician recommendations
-- ============================================================
