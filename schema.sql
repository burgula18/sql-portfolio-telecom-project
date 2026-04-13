
CREATE TABLE sites (
    site_id INT PRIMARY KEY,
    site_name VARCHAR(50),
    region VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE devices (
    device_id INT PRIMARY KEY,
    site_id INT,
    device_type VARCHAR(50),
    status VARCHAR(20)
);

CREATE TABLE circuits (
    circuit_id INT PRIMARY KEY,
    device_id INT,
    bandwidth INT,
    status VARCHAR(20)
);

CREATE TABLE decommission_recommendations (
    device_id INT,
    recommendation VARCHAR(50),
    reason VARCHAR(100)
);
