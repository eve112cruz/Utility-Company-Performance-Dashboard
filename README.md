# Utility-Company-Performance-Dashboard
 OBJECTIVE-
This project showcases my ability to clean, transform, and visualize real-world style utility customer data.
As a beginner data analyst, I built this project to practice SQL cleaning techniques and then use Power BI to create a dashboard that highlights key insights about customer usage, revenue, and status distrubution.
Even though i'm still learning, my goal was to treat this like a real buisness problem and follow a complete analytics workflow.
---

### PROJECT OVERVIEW
This dashboard analyzes utility customer data (Gas, Water, Electric) to help understand:
 - Revenue distribution by service type
 - Which states use the most energy
 - Customer distribution across the U.S.
 - Customer account status (Active, Delinquent, Inactive)
 - Revenue trends over time
 - Overall KPIs like average usage & total customer count
I performed all data cleaning in MySQL, then used Power BI to design the final dashboard.
---

### SQL DATA CLEANING
Before visualizing the data, I cleaned and standardized all fields inside MySQL. 
Below is a summary of the transformations performed:
 -Standardized inconsistent phone formats
 -Cleaned monthly bill column
 -Cleaned and standardized dates
 - Standardized names & adresses
 - Standardized language, browser, company, and status fields
 - Fixed ZIP codes and usage fields
I kept the original dara intact by creating a duplicate table and applying all cleaning steps to the copy.
---
### POWER BI DASHBOARD DEVELOPMENT
After cleaning and standardizing the dataset in SQL, I imported the data into Power BI and built a dashboard to summarize utility-company performance.
### Created DAX Measures
 To calculate KPIs and make the dashboard dynamic, I created several DAX measures, includig:
  - Total Revenue
  - Average Monthly Usage (kWh)
  - Active Customer Count
  - Total Customers
Adding the measures made the dashboard easier to update and helped everything run smoother.
### Dashboard also includes:
  - Revenue Distribution by Service Type
  - Customer Distribution Map
  - Top 5 States by Energy Usage
  - Customer Status Overview
  - Revenue Trend Over Time
---

### KEY INSIGHT
~ Water customers brought in the most revenue overall.
~ A few states, like Maryland and Minnesota, had much higher energy usage than others.
~ Most customers were Active (230 accounts), with Inactive (48) and Delinquent (28) customers making up the rest.
This shows that most people are keeping their accounts in good standing.
~ Revenue fluctuates year to year, showing that performance is not always consistent
~ Customer distribution varies across the U.S., with some states having more customers or higher usage levels.
---

### KEY TAKEAWAY
This project gave me hands-on experience cleaning data with SQL and visualizing it in Power BI to highlight important company performance metrics. I learned how to create useful DAX measures, design a structured dashboard layout, and turn cleaned data into easy to understand insights.




   
