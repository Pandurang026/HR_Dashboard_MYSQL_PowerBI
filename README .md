
# Project Title
HR Dashboard Analysis Using MySQL & Power BI

# TABLE CONTENT
- Objective
- Table names (No of tables)
- Table imported from MYSQL to PowerBI
- Tools used
- Task performed
- SQL Queries
- Questions
- Summery of finding
- Limitations 



## OBJECTIVE: 
The objective of this project is to develop a comprehensive HR dashboard using data from MySQL and visualize it effectively using Power BI. The dashboard aims is visualizations and facilitate data-driven decision-making in areas such as employee working location, gender distribution, race distribution, age group distribution, gender distribution by department, age distribution by gender, employee by state.


### Number of tables (Table Names)
    1. Human Resource.

### Table imported from MySQL to PowerBI
    1. Age group
    2. Age group gender
    3. Avg length department
    4. Avg tenure
    5. Employee chanege
    6. Gender
    7. Gender department
    8. Jobtitle
    9. location
    10. Race 
    11. State 
    12. Turnover rate





### Tools Used:
- Ecxel- Data downloaded
- MYSQL- Data analysis & data cleaning
- Power BI - Data visualizations

--- 

### Task performed
- The project was carried out through the following phases

1. HR Data collected with over 22000+ rows from the year 2000 to 2020.
2. Data included  Id, First name, Last name, Birthdate, Gender, Race, Department, Jobtitle, Location, Hire date, Termdate, Location city, Location state.
3. Ensured data accuracy and completeness through validation and cleaning processes using MYSQL.
4. Imported data into MySQL which is in .CSV format
5. Cleaned data in MY SQL
6. Performed all required tasks
7. Exported result from MY SQL into CSV format
8. Imported all required data into Power BI which is in CSV format 
9. Created dashboard
---




---

### SQL Queries
``` SQL
    create database human_resource;
    use human_resource;
    show databases;
    desc hr;

    select*from hr;
```
---


### Questions


1. What is the gender breakdown of employees in the company?

2. What is the race/ethnicity breakdown of employees in the company?

3. What is the age distribution of employees in the company?


4. How many employees work at headquarters versus remote locations?


5. What is the average length of employment for employees who have been terminated?

6. How does the gender distribution vary across departments and job titles?


7. What is the distribution of job titles across the company?


8. Which department has the highest turnover rate?


9. What is the distribution of employees across locations by city and state?


10. How has the company's employee count changed over time based on hire and term dates?

11. What is the tenure distribution for each department?


--- 

## Summery of finding
-  There are more male employees
-  White race is the most dominant while Native Hawaiian and American Indian are the least dominant.
-  The youngest employee is 21 years old and the oldest is 58 years old
-  5 age groups were created (18-24, 25-34, 35-44, 45-54, 55-64). A large number of employees were between 25-34 followed by 35-44 while the smallest group was 55-64.
- A large number of employees work at the headquarters versus remotely.
- The average length of employment for terminated employees is around 8 years.
- The gender distribution across departments is fairly balanced but there are generally more male than female employees..
- A large number of employees come from the state of Ohio.
- The net change in employees has increased over the years.
- The average tenure for each department is about 8 years with Legal and Auditing having the highest and Services, Sales and Marketing having the lowest.


## Limitations
- Some records had negative ages and these were excluded during querying(967 records). Ages used were 18 years and above.
- Some termdates were far into the future and were not included in the analysis(1599 records). The only term dates used were those less than or equal to the current date.





