-- 연습문제1
-- 문제1
select 
	concat(first_name, ' ', last_name) as '이름' 
	from employees 
    where emp_no = 10944;
    
-- 문제2
SELECT 
		concat(first_name, ' ', last_name) as '이름',
		gender as '성별',
        hire_date as '입사일'
	FROM employees 
    order by hire_date;

-- 문제3
SELECT GENDER, COUNT(*) FROM EMPLOYEES GROUP BY GENDER;

-- 문제4
SELECT * FROM SALARIES;
SELECT COUNT(*) FROM SALARIES WHERE TO_DATE LIKE '9999%' ;
-- 문제5
SELECT COUNT(*) FROM departments;
-- 문제6
SELECT * FROM DEPT_MANAGER;
SELECT COUNT(*) FROM dept_manager WHERE to_date LIKE '9999%';
-- 문제7
SELECT * FROM departments ORDER BY LENGTH(DEPT_NAME) DESC;
-- 문제8
SELECT COUNT(*) FROM salaries WHERE SALARY > 120000 AND TO_DATE LIKE '9999%';
-- 문제9
SELECT * FROM titles;
SELECT DISTINCT TITLE FROM TITLES ORDER BY LENGTH(TITLE) DESC;
-- 문제10
SELECT COUNT(*) FROM TITLES WHERE TO_DATE LIKE '9999%' AND TITLE = 'Engineer';
-- 문제11
SELECT TITLE, FROM_DATE FROM TITLES WHERE EMP_NO = 13250;