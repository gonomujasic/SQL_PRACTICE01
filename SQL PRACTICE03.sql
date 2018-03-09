-- 문제 1. 
-- 현재 급여가 많은 직원부터 직원의 사번, 이름, 그리고 연봉을 출력 하시오.
SELECT E.EMP_NO, E.FIRST_NAME, S.SALARY 
	FROM SALARIES S, EMPLOYEES E
    WHERE S.EMP_NO = E.EMP_NO
    AND TO_DATE = '9999-01-01'
    ORDER BY S.SALARY DESC;
    
-- 문제2.
-- 전체 사원의 사번, 이름, 현재 직책을 이름 순서로 출력하세요.
SELECT E.EMP_NO, E.FIRST_NAME, T.TITLE
	FROM EMPLOYEES E, TITLES T
    WHERE T.EMP_NO = E.EMP_NO
    AND T.TO_DATE = '9999-01-01'
    ORDER BY E.FIRST_NAME;
    
-- 문제3.
-- 전체 사원의 사번, 이름, 현재 부서를 이름 순서로 출력하세요..
SELECT E.EMP_NO, E.FIRST_NAME, D.DEPT_NAME
	FROM EMPLOYEES E, DEPT_EMP DE,  DEPARTMENTS D
    WHERE E.EMP_NO = DE.EMP_NO
    AND DE.DEPT_NO = D.DEPT_NO
    AND DE.TO_DATE = '9999-01-01'
    ORDER BY E.FIRST_NAME;
    
-- 문제4.
-- 전체 사원의 사번, 이름, 연봉, 직책, 부서를 모두 이름 순서로 출력합니다.
SELECT E.EMP_NO, E.FIRST_NAME, S.SALARY, T.TITLE, D.DEPT_NAME
	FROM EMPLOYEES E, DEPT_EMP DE,  DEPARTMENTS D, SALARIES S, TITLES T
    WHERE E.EMP_NO = DE.EMP_NO
    AND E.EMP_NO = S.EMP_NO
    AND E.EMP_NO = T.EMP_NO
    AND DE.DEPT_NO = D.DEPT_NO
    AND DE.TO_DATE = '9999-01-01'
    AND S.TO_DATE = '9999-01-01'
    AND T.TO_DATE = '9999-01-01'
    ORDER BY E.FIRST_NAME;
    
-- 문제5.
-- ‘Technique Leader’의 직책으로 과거에 근무한 적이 있는 모든 사원의 사번과 이름을 출력하세요.
-- (현재 ‘Technique Leader’의 직책(으로 근무하는 사원은 고려하지 않습니다.) 
-- 이름은 first_name과 last_name을 합쳐 출력 합니다.
SELECT E.EMP_NO, CONCAT(FIRST_NAME, ' ', LAST_NAME) 이름  
	FROM TITLES T, EMPLOYEES E
    WHERE T.EMP_NO = E.EMP_NO
    AND T.TITLE = 'Technique Leader' AND T.TO_DATE != '9999-01-01';
    
-- 문제6.
-- 직원 이름(last_name) 중에서 S(대문자)로 시작하는 직원들의 이름, 부서명, 직책을 조회하세요.
SELECT E.LAST_NAME, D.DEPT_NAME, T.TITLE 
	FROM EMPLOYEES E, DEPT_EMP DE, DEPARTMENTS D, TITLES T
    WHERE E.EMP_NO = DE.EMP_NO
    AND E.EMP_NO = T.EMP_NO
    AND DE.DEPT_NO = D.DEPT_NO
    AND E.LAST_NAME LIKE 'S%';

-- 문제7.
-- 현재, 직책이 Engineer인 사원 중에서 현재 급여가 40000 이상인 사원을 급여가 
-- 큰 순서대로 출력하세요.
SELECT E.EMP_NO, S.SALARY, T.TITLE 
	FROM EMPLOYEES E, SALARIES S, TITLES T
    WHERE E.EMP_NO = S.EMP_NO
    AND E.EMP_NO = T.EMP_NO
    AND S.TO_DATE = '9999-01-01'
	AND T.TO_DATE = '9999-01-01'
    AND S.SALARY >= 40000
    AND T.TITLE ='Engineer'
    ORDER BY SALARY DESC;    
    
-- 문제8.
-- 현재 급여가 50000이 넘는 직책을 직책, 급여로 급여가 큰 순서대로 출력하시오


-- 문제9.
-- 현재, 부서별 평균 연봉을 연봉이 큰 부서 순서대로 출력하세요.
SELECT D.DEPT_NAME, AVG(S.SALARY) AVG_SAL
	FROM EMPLOYEES E, DEPT_EMP DE,  DEPARTMENTS D, SALARIES S
    WHERE E.EMP_NO = DE.EMP_NO
    AND E.EMP_NO = S.EMP_NO
    AND DE.DEPT_NO = D.DEPT_NO
    AND DE.TO_DATE = '9999-01-01'
    AND S.TO_DATE = '9999-01-01'
	GROUP BY D.DEPT_NAME
    ORDER BY AVG_SAL DESC;

-- 문제10.
-- 현재, 직책별 평균 연봉을 연봉이 큰 직책 순서대로 출력하세요.
SELECT T.TITLE, AVG(S.SALARY) AVG_SAL
	FROM EMPLOYEES E, TITLES T, SALARIES S
    WHERE E.EMP_NO = T.EMP_NO
    AND E.EMP_NO = S.EMP_NO
    AND T.TO_DATE = '9999-01-01'
    AND S.TO_DATE = '9999-01-01'
	GROUP BY T.TITLE
    ORDER BY AVG_SAL DESC;