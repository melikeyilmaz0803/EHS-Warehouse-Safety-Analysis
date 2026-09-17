USE EHS_Analytics1;
CREATE TABLE warehouse_safety (
    month DATE,
    warehouse VARCHAR(10),
    employees INT,
    labor_hours INT,
    incidents INT
);
INSERT INTO warehouse_safety
    (month, warehouse, employees, labor_hours, incidents)
VALUES
('2026-01-01', 'NJ', 48, 8640, 3),
('2026-01-01', 'PA', 72, 12960, 4),
('2026-02-01', 'NJ', 50, 9000, 2),
('2026-02-01', 'PA', 74, 13320, 5),
('2026-03-01', 'NJ', 51, 9180, 4),
('2026-03-01', 'PA', 75, 13500, 5),
('2026-04-01', 'NJ', 53, 9540, 3),
('2026-04-01', 'PA', 77, 13860, 6),
('2026-05-01', 'NJ', 54, 9720, 5),
('2026-05-01', 'PA', 78, 14040, 5),
('2026-06-01', 'NJ', 55, 9900, 4),
('2026-06-01', 'PA', 80, 14400, 7),
('2026-07-01', 'NJ', 57, 10260, 6),
('2026-07-01', 'PA', 82, 14760, 6),
('2026-08-01', 'NJ', 58, 10440, 4),
('2026-08-01', 'PA', 83, 14940, 8),
('2026-09-01', 'NJ', 60, 10800, 5),
('2026-09-01', 'PA', 85, 15300, 7),
('2026-10-01', 'NJ', 61, 10980, 3),
('2026-10-01', 'PA', 87, 15660, 8),
('2026-11-01', 'NJ', 62, 11160, 4),
('2026-11-01', 'PA', 89, 16020, 7),
('2026-12-01', 'NJ', 64, 11520, 5),
('2026-12-01', 'PA', 91, 16380, 9);



--warehouse_workloads table

CREATE TABLE warehouse_workforce (
    month DATE,
    warehouse VARCHAR(10),
    overtime_hours INT,
    new_hires INT,
    training_completion_pct INT
    );
  select * 
  from warehouse_workforce

  --data adding

  INSERT INTO warehouse_workforce
    (month, warehouse, overtime_hours, new_hires, training_completion_pct)
VALUES
    ('2026-06-01', 'NJ', 420, 1, 96),
    ('2026-07-01', 'NJ', 500, 4, 95),
    ('2026-08-01', 'NJ', 390, 1, 97);


  --PA data adding
    INSERT INTO warehouse_workforce
    (month, warehouse, overtime_hours, new_hires, training_completion_pct)
VALUES
    ('2026-06-01', 'PA', 500, 1, 96),
    ('2026-07-01', 'PA', 500, 4, 95),
    ('2026-08-01', 'PA', 345, 1, 97);


   


--newhire incidents
CREATE TABLE new_hire_incidents (
    incident_id VARCHAR(10),
    incident_date DATE,
    month DATE,
    warehouse VARCHAR(10),
    incident_type VARCHAR(50),
    root_cause VARCHAR(100)
);
INSERT INTO new_hire_incidents
    (incident_id, incident_date, month, warehouse, incident_type, root_cause)
VALUES
    ('NH001', '2026-06-20', '2026-06-01', 'PA', 'Slip/Trip', 'Housekeeping'),
    
    ('NH002', '2026-07-08', '2026-07-01', 'NJ', 'Manual Handling', 'Improper lifting'),
    ('NH003', '2026-07-18', '2026-07-01', 'NJ', 'Slip/Trip', 'Housekeeping'),
    
    ('NH004', '2026-07-12', '2026-07-01', 'PA', 'Equipment', 'Improper operation'),
    
    ('NH005', '2026-08-05', '2026-08-01', 'PA', 'Slip/Trip', 'Wet floor');




ALTER TABLE new_hire_incidents
ADD training_completed VARCHAR(5);

UPDATE new_hire_incidents
SET training_completed = 'Yes';


ALTER TABLE new_hire_incidents
ADD task_at_incident VARCHAR(100);

UPDATE new_hire_incidents
SET task_at_incident =
    CASE incident_id
        WHEN 'NH001' THEN 'Housekeeping'
        WHEN 'NH002' THEN 'Box handling'
        WHEN 'NH003' THEN 'Floor cleaning'
        WHEN 'NH004' THEN 'Forklift operation'
        WHEN 'NH005' THEN 'Walking'
    END;

    SELECT *
    FROM new_hire_incidents
    ORDER BY warehouse, month;

--clean version

--Q1 — Which warehouse has worse safety performance?
--1A.  raw incident count
SELECT 
    warehouse,
    SUM(incidents) AS total_incidents
FROM warehouse_safety
GROUP BY warehouse;

--1B. Incident rate / 100 employees
SELECT 
    warehouse,
    CAST(SUM(incidents) AS DECIMAL(10,2))
        / SUM(employees) * 100 AS incident_rate
FROM warehouse_safety
GROUP BY warehouse;

--1C. Incident rate / 100K labor hours
SELECT 
    warehouse,
    CAST(SUM(incidents) AS DECIMAL(10,2))
        / SUM(labor_hours) * 100000 AS incident_rate
FROM warehouse_safety
GROUP BY warehouse;

--Q2 — What are the peak incident-rate months for each warehouse?
SELECT 
    month,
    warehouse,
    CAST(SUM(incidents) AS DECIMAL(10,2))
        / SUM(labor_hours) * 100000 AS incident_rate
FROM warehouse_safety
GROUP BY month, warehouse
ORDER BY warehouse, incident_rate DESC;

--Q3 — How does incident rate change over time?
SELECT 
    month,
    warehouse,
    CAST(SUM(incidents) AS DECIMAL(10,2))
        / SUM(labor_hours) * 100000 AS incident_rate
FROM warehouse_safety
GROUP BY month, warehouse
ORDER BY month;

--Q4 — Is higher overtime associated with a higher incident rate?
SELECT 
    ws.month,
    ws.warehouse,
    ww.overtime_hours,
    CAST(ws.incidents AS DECIMAL(10,2)) 
        / ws.labor_hours * 100000 AS incident_rate
FROM warehouse_safety AS ws
JOIN warehouse_workforce AS ww
    ON ws.month = ww.month
    AND ws.warehouse = ww.warehouse
ORDER BY ws.month, ws.warehouse;

--Q5 — What can new-hire data tell us about incident patterns?
SELECT
    ws.month,
    ws.warehouse,
    ws.incidents,
    ww.new_hires,
    ww.training_completion_pct
FROM warehouse_safety AS ws
JOIN warehouse_workforce AS ww
    ON ws.month = ww.month
    AND ws.warehouse = ww.warehouse
ORDER BY ws.month, ws.warehouse;

--Q6 — Does training completion help explain the observed incident patterns?
SELECT
    ws.month,
    ws.warehouse,
    ws.incidents,
    CAST(ws.incidents AS DECIMAL(10,2))
        / ws.labor_hours * 100000 AS incident_rate,
    ww.new_hires,
    ww.training_completion_pct
FROM warehouse_safety AS ws
JOIN warehouse_workforce AS ww
    ON ws.month = ww.month
    AND ws.warehouse = ww.warehouse
ORDER BY ws.month, ws.warehouse;

--Q7 — Which root causes are most common among new-hire incidents?
SELECT
    root_cause,
    COUNT(*) AS incident_count
FROM new_hire_incidents
GROUP BY root_cause
ORDER BY incident_count DESC;

--Q8 — Are the most common new-hire incident root causes concentrated in one warehouse?
SELECT
    warehouse,
    root_cause,
    COUNT(*) AS incident_count
FROM new_hire_incidents
GROUP BY warehouse, root_cause
ORDER BY incident_count DESC;

--Q9 — Which tasks have the highest incident rate relative to task exposure hours, and how much lost work time is associated with those incidents?
SELECT
    warehouse,
    task_at_incident,
    COUNT(*) AS incident_count,
    SUM(task_hours) AS total_task_hours,
    CAST(COUNT(*) AS DECIMAL(10,2))
        / SUM(task_hours) * 100000 AS incident_rate_per_task_hours,
    SUM(lost_hours) AS total_lost_hours
FROM new_hire_incidents
GROUP BY warehouse, task_at_incident
ORDER BY incident_rate_per_task_hours DESC;

select * from new_hire_incidents