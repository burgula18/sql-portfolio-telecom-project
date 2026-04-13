
-- Total devices per site
SELECT site_id, COUNT(*) AS total_devices
FROM devices
GROUP BY site_id;

-- Top 5 devices with highest circuits
SELECT device_id, COUNT(*) AS circuit_count
FROM circuits
GROUP BY device_id
ORDER BY circuit_count DESC
LIMIT 5;

-- Devices recommended for decommission
SELECT *
FROM decommission_recommendations
WHERE recommendation = 'Decommission';
