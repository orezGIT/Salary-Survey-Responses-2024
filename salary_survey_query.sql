CREATE DATABASE SalarySurvey2024

USE SalarySurvey2024 
GO

SELECT COUNT(*) FROM modify_Salary_Survey_2024

SELECT * FROM modify_Salary_Survey_2024

--Create another table by copying all data from modify_Salary_Survey_2024 to SalarySurvey 
SELECT * 
INTO SalarySurvey 
FROM modify_Salary_Survey_2024

--Retrieve information from SalarySurvey table
SELECT * FROM SalarySurvey

SELECT COUNT(*) FROM SalarySurvey


--DATA CLEANING/PREPARATION 

--Drop column Survey_year
ALTER TABLE SalarySurvey 
DROP COLUMN Survey_Year


--Retrieve information from Timestamp column
SELECT [Timestamp] FROM SalarySurvey 

--Create a new column
ALTER TABLE SalarySurvey 
ADD DateYear Date

--Copy data from Timestamp to DateYear
UPDATE SalarySurvey
SET DateYear = [Timestamp]

--Retrieve information from DateYear column
SELECT DateYear FROM SalarySurvey

--Drop Timestamp column
ALTER TABLE SalarySurvey 
DROP COLUMN [Timestamp]


--Retrieve information from country column
SELECT DISTINCT(Country) FROM SalarySurvey


--Drop PostalCode column 
ALTER TABLE SalarySurvey 
DROP COLUMN PostalCode


--Retrieve information from Primary Database column
SELECT DISTINCT(PrimaryDatabase) FROM SalarySurvey

UPDATE SalarySurvey 
SET PrimaryDatabase = 'Elastic search' 
WHERE PrimaryDatabase = 'Elasticsearch'


--Retrieve information from YearsWithThisDatabase
SELECT DISTINCT(YearsWithThisDatabase) FROM SalarySurvey

SELECT * FROM SalarySurvey
WHERE YearsWithThisDatabase = 30331

SELECT YearsWithThisDatabase FROM SalarySurvey 
WHERE YearsWithThisDatabase IN(0, 30331, 1990, 2010, 2008, 
			2002, 2016, 2005, 2000, 53716, 1997, 2003, 2017, 1050, 1995) 
ORDER BY YearsWithThisDatabase 

UPDATE SalarySurvey 
SET YearsWithThisDatabase = NULL 
WHERE YearsWithThisDatabase = 0

UPDATE SalarySurvey 
SET YearsWithThisDatabase = NULL 
WHERE YearsWithThisDatabase = 1050

UPDATE SalarySurvey 
SET YearsWithThisDatabase = 32 
WHERE YearsWithThisDatabase = 1990

UPDATE SalarySurvey 
SET YearsWithThisDatabase = NULL 
WHERE YearsWithThisDatabase = 1050

UPDATE SalarySurvey 
SET YearsWithThisDatabase = NULL 
WHERE YearsWithThisDatabase = 30331

UPDATE SalarySurvey 
SET YearsWithThisDatabase = NULL 
WHERE YearsWithThisDatabase = 53716


--Retrieve information from OtherDatabases
SELECT DISTINCT(OtherDatabases) FROM SalarySurvey

SELECT OtherDatabases FROM SalarySurvey 
WHERE OtherDatabases = '-'

SELECT OtherDatabases FROM SalarySurvey 
WHERE OtherDatabases IS NULL

SELECT OtherDatabases FROM SalarySurvey 
WHERE OtherDatabases = 'null'

SELECT COUNT(OtherDatabases) FROM SalarySurvey 
WHERE OtherDatabases = 'null'

UPDATE SalarySurvey 
SET OtherDatabases = NULL 
WHERE OtherDatabases = 'null'

UPDATE SalarySurvey 
SET OtherDatabases = NULL 
WHERE OtherDatabases = '-'


--Retrieve infomation from EmploymentStatus column
SELECT DISTINCT(EmploymentStatus) FROM SalarySurvey


--Retrieve information from JobTitle column
SELECT DISTINCT(JobTitle) FROM SalarySurvey


--Retrieve information from YearsWithThisTypeOfJob column
SELECT DISTINCT(YearsWithThisTypeOfJob) FROM SalarySurvey

SELECT * FROM SalarySurvey 
WHERE YearsWithThisTypeOfJob  = 0

UPDATE SalarySurvey 
SET YearsWithThisTypeOfJob = NULL
WHERE YearsWithThisTypeOfJob = 0


--Retrieve information from HowManyCompanies 
SELECT DISTINCT(HowManyCompanies) FROM SalarySurvey 

SELECT HowManyCompanies FROM SalarySurvey 
WHERE HowManyCompanies = 'Not Asked'

SELECT HowManyCompanies FROM SalarySurvey 
WHERE HowManyCompanies IS NULL

SELECT COUNT(HowManyCompanies) FROM SalarySurvey 
WHERE HowManyCompanies = 'Not Asked' 

UPDATE SalarySurvey
SET HowManyCompanies = NULL 
WHERE HowManyCompanies =  'Not Asked' 


--Retrieve information from Education column
SELECT DISTINCT(Education) FROM SalarySurvey

SELECT COUNT(Education) FROM SalarySurvey 
WHERE Education = 'Not Asked'

UPDATE SalarySurvey 
SET Education = NULL 
WHERE Education = 'Not Asked'


--Retrieve information from EducationsComputerRelated column
SELECT DISTINCT(EducationComputerRelated) FROM SalarySurvey

SELECT * FROM SalarySurvey 
WHERE EducationComputerRelated = 'N/A'

SELECT COUNT(EducationComputerRelated) FROM SalarySurvey
WHERE EducationComputerRelated = 'Not Asked'

UPDATE SalarySurvey 
SET EducationComputerRelated = NULL 
WHERE EducationComputerRelated = 'Not Asked' 


--Retrieve information from Certifications column 
SELECT DISTINCT(Certifications) FROM SalarySurvey

SELECT COUNT( Certifications) FROM SalarySurvey
WHERE  Certifications = 'Not Asked' 

UPDATE SalarySurvey
SET  Certifications = NULL  
WHERE  Certifications = 'Not Asked'


--Drop column PopulationOfLargestCityWithin20Miles
ALTER TABLE SalarySurvey
DROP COLUMN PopulationOfLargestCityWithin20Miles


--Retrieve information from EmploymentSector
SELECT DISTINCT(EmploymentSector) FROM SalarySurvey


--Retrieve information from CareerPlansThisYear column
SELECT DISTINCT(CareerPlansThisYear) FROM SalarySurvey 

SELECT COUNT(CareerPlansThisYear) FROM SalarySurvey 
WHERE CareerPlansThisYear = 'Not Asked' 

UPDATE SalarySurvey 
SET CareerPlansThisYear = NULL 
WHERE CareerPlansThisYear = 'Not Asked'


--Retrieve informtation from Gender column
SELECT DISTINCT(Gender) FROM SalarySurvey

UPDATE SalarySurvey 
SET Gender = NULL 
WHERE Gender = 'Not Asked'

UPDATE SalarySurvey 
SET Gender = NULL 
WHERE Gender = 'None'


--EXPLORATORY DATA ANALYSIS

SELECT * FROM SalarySurvey

--Retrieve Total Salary for each year
SELECT YEAR(DateYear) AS Year,  SUM(SalaryUSD) AS TotalSalary
FROM SalarySurvey 
GROUP BY YEAR(DateYear)
ORDER BY [Year]

--Retrieve Total salary for each month in a year
WITH CTE AS (
	SELECT FORMAT(DateYear, 'yyyy-MM') AS Yearmonth,  SUM(SalaryUSD) AS TotalSalary
	FROM SalarySurvey 
	GROUP BY FORMAT(DateYear, 'yyyy-MM')
),
monthlysalary AS( 
	SELECT Yearmonth, SUM(TotalSalary) AS salarypermonth
	FROM CTE
	GROUP BY Yearmonth
)
SELECT * FROM monthlysalary
ORDER BY Yearmonth

--Retrieve countries with the highest salaries and its average salaries
SELECT  Country, SUM(SalaryUSD) AS TotalSalaryUSD, AVG(SalaryUSD) AS AverageSalaryUSD
FROM SalarySurvey 
GROUP BY Country
ORDER BY TotalSalaryUSD DESC

--Retrieve countries with the primary databases used more by professionals
SELECT Country, PrimaryDatabase, YearsWithThisDatabase, OtherDatabases
FROM SalarySurvey
ORDER BY PrimaryDatabase, Country

--Retrieve JobTitles with their total salaries for each year from highest to lowest
WITH CTE AS(
		SELECT YEAR(DateYear) AS [Year], JobTitle,  SUM(SalaryUSD) AS Salary
		FROM SalarySurvey 
		GROUP  BY YEAR(DateYear), JobTitle),
Jobtitle_salary AS(  
		SELECT [Year], JobTitle, SUM(Salary) as Total_Salary
		FROM CTE
		GROUP BY [Year], JobTitle
)
SELECT * FROM Jobtitle_salary 
ORDER BY [Year] ASC, Total_Salary DESC

--Retrieve JobTitles for each year and the number of professionals 
SELECT YEAR(DateYear) AS [Year], JobTitle, COUNT(JobTitle) as Numberofprofessionals
FROM SalarySurvey 
WHERE JobTitle IN (SELECT JobTitle  FROM SalarySurvey)
GROUP BY Year(DateYear), JobTitle 
ORDER BY [Year], JobTitle

--Retrieve top 5 jobTitles for each year with their years of experience and 
--the number companies they work with
WITH CTE AS(
	SELECT YEAR(DateYear) AS [Year], JobTitle, YearsWithThisTypeOfJob, HowManyCompanies, SalaryUSD
	FROM SalarySurvey),		
Top_Job_Title AS( 
	SELECT *, ROW_NUMBER() OVER(PARTITION BY [Year] ORDER BY SalaryUSD DESC) AS Job_Rank 
	FROM CTE	
)
SELECT * FROM Top_Job_Title
WHERE Job_Rank  <= 5 
ORDER BY [Year]

--Retrieve number of males working for each year
SELECT Year(DateYear) AS [Year], COUNT(Gender) AS Males_Employed
FROM SalarySurvey 
WHERE Gender = 'Male'
GROUP BY Year(DateYear)
ORDER BY [Year]

--Retrieve number of males working for each year
SELECT Year(DateYear) AS [Year], COUNT(Gender) AS Females_Employed
FROM SalarySurvey 
WHERE Gender = 'Female'
GROUP BY Year(DateYear)
ORDER BY [Year]

--Retrieve the number of  different categories of gender working 
SELECT
	(SELECT COUNT(Gender) FROM SalarySurvey WHERE Gender = 'Male') AS Total_Males_Employed, 
	(SELECT COUNT(Gender) FROM SalarySurvey WHERE Gender = 'Female') AS Total_Females_Employed,
	(SELECT COUNT(*) FROM SalarySurvey WHERE Gender IS NULL) AS No_Response,
	(SELECT COUNT(Gender) FROM SalarySurvey WHERE Gender NOT IN ('Male', 'Female')) AS Other_categories

--Retrieve the type of degrees and sectors with salaries ranging from highest to lowest
SELECT Education, EducationComputerRelated, 
	Certifications, EmploymentSector, SUM(SalaryUSD) AS TotalSalary
FROM SalarySurvey 
GROUP BY Education, EducationComputerRelated, Certifications, EmploymentSector
ORDER BY TotalSalary DESC

--Retrive the total Salary for each degree
SELECT Education, SUM(SalaryUSD) AS TotalSalary
FROM SalarySurvey 
GROUP BY Education 
ORDER BY TotalSalary DESC


SELECT JobTitle, CareerPlansThisYear, COUNT(CareerPlansThisYear) AS Career_Contentment
FROM SalarySurvey
WHERE CareerPlansThisYear IS NOT NULL
GROUP BY JobTitle, CareerPlansThisYear 
ORDER BY CareerPlansThisYear, 
	Career_Contentment DESC

SELECT 
	(SELECT COUNT(CareerPlansThisYear) 
	FROM SalarySurvey 
	WHERE CareerPlansThisYear = 'Change both employers and roles') AS [ChangeEmployers&Roles],
	(SELECT COUNT(CareerPlansThisYear) 
	FROM SalarySurvey
	WHERE CareerPlansThisYear = 'Prefer not to say') AS OtherCategories, 
	(SELECT COUNT(CareerPlansThisYear) 
	FROM SalarySurvey
	WHERE CareerPlansThisYear = 'Stay with the same employer,  but change roles') AS SameEmployerChangeRoles, 
	(SELECT COUNT(CareerPlansThisYear) 
	FROM SalarySurvey
	WHERE CareerPlansThisYear = 'Stay with the same employer, same role') AS [SameEmployer&Role], 
	(SELECT COUNT(CareerPlansThisYear) 
	FROM SalarySurvey 
	WHERE CareerPlansThisYear = 'Stay with the same role, but change employers') AS SameRoleChangeEmployers



