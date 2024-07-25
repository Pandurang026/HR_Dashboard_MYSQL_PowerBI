
-- ======================== PROJECT ON HR DASHBOARD ==================
create database human_resource;
use human_resource;
show databases;
desc hr;

select*from hr;

-- ========== DATA CLEANING =========
# 1. RENAME ID COLUMN NAME
		alter table hr
        rename column ï»¿id to emp_id ;

# 2. MODIFY COLUMN emp_id
		alter table hr
        modify column emp_id varchar(40) not null;
        
        # OR YOU CAN DO IN OTHER WAY
        alter table hr
        change column ï»¿id emp_id varchar(40) not null;
        
# 3. UPDATE DATATYPE OF BIRTHDATE
		desc hr;
        select birthdate from hr;
        
        set sql_safe_updates = 0;
        
        update hr
        set birthdate = CASE
        when birthdate LIKE '%/%' then date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
        when birthdate LIKE '%-%' then date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
        else null
        end;
        # "NOTE: 'Y' SHOULD BE IN CAPITAL"

# 4. CHANGE DATA TYPE OF BIRTHDATE COLUMN
		alter table hr
        modify column birthdate date;
        
# 5. UPDATE HIRE_DATE
		   update hr
        set hire_date = CASE
        when hire_date LIKE '%/%' then date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
        when hire_date LIKE '%-%' then date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
        else null
        end;
        
# 6. CHANGE DATA TYPE OF hire_date 
		alter table hr
        modify column hire_date date;
        
        select hire_date from hr;
        
		
 
 # 7. CHAGE FIRST FORMAT OF TERMDATE AND THEN DATA TYPE
		update hr
		set termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
        where termdate is not null and termdate != '';
        
               
        select termdate from hr; 
        
		alter table hr
        modify column termdate date; #
        
        select * from hr;
        
# 8. ADD NEW COLUMN "AGE"
		alter table hr
        add column age int;
        
        update hr
        set age = timestampdiff(year, birthdate, curdate());
        
        select birthdate, age from hr;
        
# 9. CALCULATE YOUNGEST AND OLDEST AGE 
		select min(age) as youngest,
        max(age) as oldest
        from hr;
        
        select count(*) from hr
        where age < 18;
        
        
        
-- ================ QUESTIONS ================
-- 1. What is the gender breakdown of employees in the company?
		select * from hr;
        
        select gender, COUNT(*) AS Total_Count 
        from hr
        group by gender;
        
        select gender, COUNT(*) AS Total_Count 
        from hr
        where age > 18 AND termdate = ''
        group by gender;
        
        select gender, COUNT(*) AS Total_Count 
        from hr
        where age >= 18 AND termdate = ''
        group by gender;
        
		
-- 2. What is the race/ethnicity breakdown of employees in the company?
		select race, count(*) as Total_Count
        from hr
        where age >= 18 AND termdate=''
        group by race 
        order by Total_Count desc;
        
        
-- 3. What is the age distribution of employees in the company?
		select 
        min(age) as youngest,
        max(age) as oldest
        from hr
		where age >= 18 AND termdate = '';
        
        
        select
			CASE
            WHEN age>=18 AND age<=24 THEN '18-24'
            WHEN age>=25 AND age<=34 THEN '25-34'
            WHEN age>=35 AND age<=44 THEN '35-44'
			WHEN age>=45 AND age<=54 THEN '45-54'
			WHEN age>=55 AND age<=64 THEN '55-64'
            ELSE '65+'
            END AS age_group, gender,
			count(*) AS Total_Count
            from hr
            where age >= 18 AND termdate = ''
            group by age_group, gender
            order by age_group, gender;

        

-- 4. How many employees work at headquarters versus remote locations?
		select location, count(*) as Total_Count
        from hr
        where age>=18 AND termdate=''
        group by location 
        order by Total_Count;


-- 5. What is the average length of employment for employees who have been terminated?
		select
        round(AVG(datediff(termdate, hire_date))/365,0) AS Avg_Length_Employee
        from hr
        where  termdate<= curdate() AND termdate<> '' AND age>=18;
        
        
-- 6. How does the gender distribution vary across departments and job titles?
		select  department, gender,  count(*) AS Total_Count
        from hr
        where age>=18 AND termdate=''
        group by department, gender
        order by department;
        

-- 7. What is the distribution of job titles across the company?
		select jobtitle, count(*) AS Total_Count
        from hr
        where age>= 18 AND termdate=''
        group by jobtitle
        order by jobtitle desc;
        

-- 8. Which department has the highest turnover rate?
		select department,
        total_count,
        terminated_count,
        terminated_count/total_count AS termination_rate
        from(
			select department,
            count(*) AS total_count,
            SUM(CASE WHEN termdate <> '' AND termdate <= curdate() THEN 1 ELSE 0 END) AS terminated_count
            from hr
            where age >= 18
            group by department
            ) AS subquery
		order by termination_rate desc;
        

-- 9. What is the distribution of employees across locations by city and state?
		select location_city, location_state, count(*) AS total_count
        from hr
        where age >= 18 and termdate = ''
        group by location_city, location_state
        order by location_city,location_state;
        
        
        select location_state, count(*) AS total_count
        from hr
        where age >= 18 and termdate = ''
        group by location_state
        order by total_count desc;
        

-- 10. How has the company's employee count changed over time based on hire and term dates?
		select
			year,
			hires,
			terminations,
			hires-terminations AS net_change,
			round((hires - terminations)/hires * 100, 2) AS net_change_percent
		from(
			select year(hire_date) AS year,
            count(*) as hires,
            SUM(CASE WHEN termdate <> '' AND termdate <= curdate() THEN 1 ELSE 0 END) AS terminations
            from hr
            where age >= 18
            group by year(hire_date)
            ) AS subquery
		order by year;
        
        
        
-- 11. What is the tenure distribution for each department?
		select department, ROUND(AVG(datediff(termdate, hire_date)/365),0) AS avg_tenure
        from hr
        where termdate <= curdate() AND termdate <> '' AND age>= 18
        group by department;