# EHS Warehouse Safety Analysis

## Overview

This project analyzes warehouse safety performance across two warehouse operations in New Jersey (NJ) and Pennsylvania (PA).

The analysis starts with overall incident counts and then uses exposure-based metrics to provide a more meaningful comparison. It also investigates monthly trends, overtime, training completion, new-hire incidents, root causes, task exposure, and lost work hours.

The goal is to demonstrate how SQL and Power BI can be used to turn operational safety data into practical EHS insights.

**Tools:** SQL Server, SQL, Power BI



## Business Problem

Incident counts alone do not always provide a meaningful comparison between warehouse operations. A warehouse with more employees or more labor hours may naturally have more incidents.

The analysis therefore asks:

1. **Which warehouse has worse safety performance?**
2. **What are the peak incident-rate months for each warehouse?**
3. **How does incident rate change over time?**
4. **Is higher overtime associated with a higher incident rate?**
5. **What can new-hire data tell us about incident patterns?**
6. **Does training completion help explain the observed incident patterns?**
7. **Which root causes are most common among new-hire incidents?**
8. **Are the most common new-hire incident root causes concentrated in one warehouse?**
9. **Which tasks have the highest incident rate relative to task exposure hours, and how much lost work time is associated with those incidents?**



## Data

The project uses three related tables.

| Table                 | Grain               | Purpose                                                                   |
| --------------------- | ------------------- | ------------------------------------------------------------------------- |
| `warehouse_safety`    | Warehouse-month     | Overall safety performance and monthly trends                             |
| `warehouse_workforce` | Warehouse-month     | Overtime, new hires, and training completion                              |
| `new_hire_incidents`  | Individual incident | New-hire incident details, root cause, task exposure, and lost work hours |

### Data Scope

* `warehouse_safety`: January–December 2026
* `warehouse_workforce`: June–August 2026
* `new_hire_incidents`: June–August 2026

The workforce and new-hire data cover only June through August and are therefore used for a focused investigation rather than a full-year workforce analysis.



# Analysis & Findings

## Q1 — Which warehouse has worse safety performance?

The first step was to compare:

* Total incident count
* Incident rate per 100 employees
* Incident rate per 100,000 labor hours

Raw incident counts showed:

* NJ: **48 incidents**
* PA: **77 incidents**

Because the warehouses may differ in workforce size and labor exposure, exposure-based rates were also calculated.

### Annual Incident Rates

| Warehouse | Incidents / 100 Employees | Incidents / 100K Labor Hours |
| --------- | ------------------------: | ---------------------------: |
| NJ        |                     ~7.13 |                       ~39.62 |
| PA        |                     ~7.91 |                       ~43.96 |

PA had the higher observed annual incident rate using both employee-normalized and labor-hour-normalized measures.

For this project, the labor-hour rate is used as the primary safety performance metric because it accounts for differences in labor exposure.



## Q2 — What are the peak incident-rate months for each warehouse?

Monthly incident rates were calculated using labor hours.

* **NJ peak:** July — **58.48 incidents per 100K labor hours**
* **PA peak:** December — **54.95 incidents per 100K labor hours**

This shows that the warehouse with the higher annual rate does not necessarily have the highest monthly rate in every period.

Peak months can be used as starting points for deeper investigation into workload, staffing, task mix, environmental conditions, and operational changes.



## Q3 — How does incident rate change over time?

Monthly incident rates varied throughout the year in both warehouses.

The trend analysis helps identify periods where incident rates increased or decreased and provides a basis for asking additional operational questions.

The monthly trend should not be interpreted as proof of a specific cause. Instead, higher-rate periods can be used to identify where additional investigation may be useful.



## Q4 — Is higher overtime associated with a higher incident rate?

Overtime hours were compared with incident rates for June through August.

The observed pattern was different between NJ and PA.

NJ showed a period where higher overtime and higher incident rate moved in the same direction, while PA did not show the same pattern consistently.

This means overtime alone does not provide a consistent explanation for the observed incident rates.

The analysis identifies an **observed association**, not a causal relationship.

Additional data such as workload, staffing levels, shift information, production volume, and task exposure would be needed for a stronger investigation.



## Q5 — What can new-hire data tell us about incident patterns?

New-hire information was compared with:

* Monthly incidents
* Number of new hires
* Training completion
* Warehouse
* Month

This provides additional workforce context around the observed incident patterns.

However, the available workforce table does **not** prove that the recorded warehouse incidents were caused by or directly involved new hires.

For that reason, detailed new-hire incident analysis was performed separately using the `new_hire_incidents` table.



## Q6 — Does training completion help explain the observed incident patterns?

Training completion remained high during the available period:

* NJ: approximately **95–97%**
* PA: approximately **95–97%**

Incident rates still varied during the same period.

The available data therefore do not show a simple pattern in which training completion explains changes in incident rates.

A stronger analysis would require a longer time period and more detailed information such as:

* Training completion by employee
* Training type
* Training date
* Employee experience
* Incident date
* Time between training and incident



## Q7 — Which root causes are most common among new-hire incidents?

The project contains five new-hire incidents.

Observed root causes were:

| Root Cause         | Incident Count |
| ------------------ | -------------: |
| Housekeeping       |              2 |
| Improper lifting   |              1 |
| Improper operation |              1 |
| Wet floor          |              1 |

Housekeeping was the most common root cause in this small sample.

Because only five incidents are available, this finding should be treated as an observed pattern rather than a general conclusion about warehouse safety.



## Q8 — Are the most common new-hire incident root causes concentrated in one warehouse?

Housekeeping incidents appeared in both NJ and PA.

This suggests that housekeeping may be a shared investigation area rather than an issue isolated to a single warehouse.

However, the sample size is too small to determine whether housekeeping is a significant warehouse-level driver.

A larger incident dataset would be needed to establish a stronger pattern.



## Q9 — Which tasks have the highest incident rate relative to task exposure hours?

Task exposure hours were added to compare incidents relative to the amount of time spent performing each task.

The analysis also includes lost work hours to show the operational impact associated with incidents.

The highest observed task rate was associated with forklift operation:

* **250 incidents per 100K task hours**
* **24 lost work hours**

However, each task in this sample has only one incident.

Therefore, the analysis does **not** establish that forklift operation is inherently the most dangerous task.

Instead, the metric shows how incident frequency looks relative to the available task exposure and highlights where incident impact may deserve further investigation.



# Looking Beyond Worker Behavior

Incident analysis should not stop at worker behavior or individual actions.

The current dataset does not contain enough information to evaluate several important EHS investigation dimensions.

### Management

Potential factors include:

* Staffing levels
* Workload and production pressure
* Available resources
* Management decisions
* Safety prioritization

### Process & Procedure

Potential factors include:

* SOP availability
* SOP clarity
* Procedure compliance
* Process design
* Standardization
* Workflow changes

### Supervisor

Potential factors include:

* Level of supervision
* Task assignment
* New-hire supervision
* Coaching and communication
* Pre-task verification
* Follow-up after incidents

These factors are not presented as causes in this project because they are not included in the available data.



# Business Insights

The analysis demonstrates several important points:

* Raw incident counts alone are not enough for comparing warehouse safety performance.
* Exposure-based rates provide a more useful comparison.
* Monthly trends can identify periods that deserve closer investigation.
* Overtime and incident-rate patterns can differ between warehouses.
* High training completion does not automatically explain changes in incident rates.
* Root-cause analysis adds context to incident counts.
* Task exposure allows incidents to be evaluated relative to operational exposure.
* Lost work hours provide an additional measure of operational impact.
* A deeper EHS investigation should consider worker behavior together with task, process, procedure, management, and supervisor factors.



# Recommendations

Based on the observed patterns, future EHS analysis should:

1. Track both incident counts and exposure-based rates such as incidents per 100,000 labor hours.
2. Review peak incident-rate months in more detail.
3. Collect longer periods of overtime, training, and incident data.
4. Track task exposure hours for higher-risk activities.
5. Include employee experience and tenure.
6. Add shift, workload, staffing, and operational volume data.
7. Capture management, process, procedure, and supervisor factors during incident investigations.
8. Review incidents with high lost work hours for additional corrective-action opportunities.
9. Combine safety KPIs with operational information instead of evaluating safety metrics in isolation.



# Power BI Dashboard

## Dashboard 1 — Safety Performance

The first dashboard provides an overall view of warehouse safety performance.

It includes:

* NJ vs PA incident rate
* Monthly incident-rate trends
* Total incidents
* Incident rate per 100K labor hours
* Incident rate per 100 employees
* Warehouse slicer

The dashboard is designed to answer the first three business questions and provide an overall performance view.



## Dashboard 2 — Safety Investigation

The second dashboard focuses on the June–August workforce and new-hire investigation.

It includes:

* Overtime vs incident rate
* Training completion vs incident rate
* New-hire root causes
* Root causes by warehouse
* Task incident rate
* Lost work hours

**Data scope:** Workforce and new-hire incident data available June–August 2026.

The second dashboard is intended to support deeper investigation rather than provide a causal explanation.



# Project Structure


EHS_Warehouse_Safety_Analysis/
│
├── SQL/
│   └── EHS_Warehouse_Safety_Analysis.sql
│
├── Power BI/
│   └── EHS_Warehouse_Safety_Analysis.pbix
│
├── README.md
│
└── Screenshot/
    ├── Dashboard_1_Safety_Performance.png
    └── Dashboard_2_Safety_Investigation.png


# Limitations

This project is based on a small learning dataset and has several limitations.

* Workforce and new-hire data cover only June–August.
* Only five new-hire incidents are available.
* The new-hire incident sample is too small for broad conclusions.
* Task-level incident rates are based on very limited observations.
* The data does not establish causality between overtime and incidents.
* The data does not establish causality between training completion and incidents.
* Shift information is not available.
* Task volume and production volume are not available.
* Employee experience and tenure are limited.
* Workload and staffing information are not available.
* Management, process, procedure, and supervisor factors are not included.

The findings should therefore be interpreted as **observed patterns in the available data**, not as proof of root causes.



# Conclusion

This project started with a basic warehouse comparison and moved toward a more structured EHS investigation.

The analysis first compared incident counts, then normalized them using employee and labor-hour exposure. It continued with monthly trends, overtime, training, new-hire incidents, root causes, task exposure, and lost work hours.

The main lesson is that safety analysis becomes more useful when individual numbers are connected to operational context.

In a real EHS investigation, the next step would be to combine incident data with task conditions, process and procedure information, staffing and workload, supervision, and management factors to support stronger root-cause analysis and CAPA decisions.
