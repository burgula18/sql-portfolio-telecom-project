/* =========================================================
   Telecom SQL Portfolio Project - Oracle queries.sql
   ========================================================= */

/* 1) Total devices per site */
SELECT site_id, COUNT(*) AS total_devices
FROM devices
GROUP BY site_id
ORDER BY total_devices DESC;


/* 2) Top 5 sites with highest devices */
SELECT site_id, COUNT(*) AS total_devices
FROM devices
GROUP BY site_id
ORDER BY total_devices DESC
FETCH FIRST 5 ROWS ONLY;


/* 3) Devices with total circuits */
SELECT d.device_id, COUNT(c.circuit_id) AS total_circuits
FROM devices d
LEFT JOIN circuits c
    ON d.device_id = c.device_id
GROUP BY d.device_id
ORDER BY total_circuits DESC;


/* 4) Top 10 devices by circuit count */
SELECT d.device_id, COUNT(c.circuit_id) AS total_circuits
FROM devices d
LEFT JOIN circuits c
    ON d.device_id = c.device_id
GROUP BY d.device_id
ORDER BY total_circuits DESC
FETCH FIRST 10 ROWS ONLY;


/* 5) Devices with working circuit count */
SELECT d.device_id,
       COUNT(c.circuit_id) AS working_circuits
FROM devices d
LEFT JOIN circuits c
    ON d.device_id = c.device_id
   AND c.status = 'Working'
GROUP BY d.device_id
ORDER BY working_circuits DESC;


/* 6) Device utilization (Zero Fill / Low Fill / Working) */
SELECT
    d.device_id,
    COUNT(c.circuit_id) AS working_circuits,
    CASE
        WHEN COUNT(c.circuit_id) = 0 THEN 'Zero Fill'
        WHEN COUNT(c.circuit_id) <= 5 THEN 'Low Fill'
        ELSE 'Working'
    END AS utilization_status
FROM devices d
LEFT JOIN circuits c
    ON d.device_id = c.device_id
   AND c.status = 'Working'
GROUP BY d.device_id
ORDER BY d.device_id;


/* 7) Underutilized devices (<= 5 circuits) */
SELECT
    d.device_id,
    COUNT(c.circuit_id) AS working_circuits
FROM devices d
LEFT JOIN circuits c
    ON d.device_id = c.device_id
   AND c.status = 'Working'
GROUP BY d.device_id
HAVING COUNT(c.circuit_id) <= 5
ORDER BY working_circuits;


/* 8) Devices recommended for decommission */
SELECT *
FROM decommission_recommendations
WHERE recommendation = 'Decommission';


/* 9) Decommission devices with details */
SELECT d.device_id, d.site_id, dr.reason
FROM devices d
JOIN decommission_recommendations dr
    ON d.device_id = dr.device_id
WHERE dr.recommendation = 'Decommission';


/* 10) Devices per region */
SELECT s.region, COUNT(d.device_id) AS total_devices
FROM sites s
LEFT JOIN devices d
    ON s.site_id = d.site_id
GROUP BY s.region
ORDER BY total_devices DESC;


/* 11) Working circuits per region */
SELECT s.region,
       COUNT(c.circuit_id) AS working_circuits
FROM sites s
JOIN devices d
    ON s.site_id = d.site_id
LEFT JOIN circuits c
    ON d.device_id = c.device_id
   AND c.status = 'Working'
GROUP BY s.region
ORDER BY working_circuits DESC;


/* 12) Site-wise circuit breakdown */
SELECT s.site_id,
       COUNT(CASE WHEN c.status = 'Working' THEN 1 END) AS working,
       COUNT(CASE WHEN c.status = 'Idle' THEN 1 END) AS idle,
       COUNT(CASE WHEN c.status = 'Disconnected' THEN 1 END) AS disconnected
FROM sites s
JOIN devices d
    ON s.site_id = d.site_id
LEFT JOIN circuits c
    ON d.device_id = c.device_id
GROUP BY s.site_id
ORDER BY s.site_id;


/* 13) Devices with no circuits */
SELECT d.device_id
FROM devices d
LEFT JOIN circuits c
    ON d.device_id = c.device_id
WHERE c.device_id IS NULL;


/* 14) Average circuits per device */
SELECT ROUND(AVG(cnt), 2) AS avg_circuits
FROM (
    SELECT COUNT(c.circuit_id) AS cnt
    FROM devices d
    LEFT JOIN circuits c
        ON d.device_id = c.device_id
    GROUP BY d.device_id
);


/* 15) Active vs Inactive devices */
SELECT status, COUNT(*) AS device_count
FROM devices
GROUP BY status;


/* 16) Rank devices by circuits */
SELECT
    d.device_id,
    COUNT(c.circuit_id) AS total_circuits,
    DENSE_RANK() OVER (ORDER BY COUNT(c.circuit_id) DESC) AS rank_no
FROM devices d
LEFT JOIN circuits c
    ON d.device_id = c.device_id
GROUP BY d.device_id;


/* 17) Top device in each site */
SELECT *
FROM (
    SELECT
        d.site_id,
        d.device_id,
        COUNT(c.circuit_id) AS total_circuits,
        ROW_NUMBER() OVER (
            PARTITION BY d.site_id
            ORDER BY COUNT(c.circuit_id) DESC
        ) rn
    FROM devices d
    LEFT JOIN circuits c
        ON d.device_id = c.device_id
    GROUP BY d.site_id, d.device_id
)
WHERE rn = 1;


/* 18) Decommission count by reason */
SELECT reason, COUNT(*) AS total
FROM decommission_recommendations
WHERE recommendation = 'Decommission'
GROUP BY reason;


/* 19) Active but underutilized devices */
SELECT
    d.device_id,
    COUNT(c.circuit_id) AS working_circuits
FROM devices d
LEFT JOIN circuits c
    ON d.device_id = c.device_id
   AND c.status = 'Working'
WHERE d.status = 'Active'
GROUP BY d.device_id
HAVING COUNT(c.circuit_id) <= 5;


/* 20) Full device utilization report */
SELECT
    s.region,
    d.device_id,
    COUNT(c.circuit_id) AS working_circuits,
    CASE
        WHEN COUNT(c.circuit_id) = 0 THEN 'Zero Fill'
        WHEN COUNT(c.circuit_id) <= 5 THEN 'Low Fill'
        ELSE 'Working'
    END AS utilization_status
FROM sites s
JOIN devices d
    ON s.site_id = d.site_id
LEFT JOIN circuits c
    ON d.device_id = c.device_id
   AND c.status = 'Working'
GROUP BY s.region, d.device_id
ORDER BY s.region, d.device_id;
