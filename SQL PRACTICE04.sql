-- 문제1.
-- 현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?
SELECT COUNT(*) 
	FROM SALARIES
    WHERE TO_DATE = '9999-01-01'
    AND SALARY > (
					SELECT AVG(SALARY) 
						FROM SALARIES
                        );
                        
-- 문제2. 
-- 현재, 각 부서별로 최고의 급여를 받는 사원//의 사번, 이름, 부서, 연봉을 조회하세요. 
-- 단 조회결과는 연봉의 내림차순으로 정렬되어 나타나야 합니다. 
SELECT E.EMP_NO, CONCAT(E.FIRST_NAME, ' ', E.LAST_NAME), D.DEPT_NAME, S.SALARY
	FROM EMPLOYEES E, DEPARTMENTS D, DEPT_EMP DE, SALARIES S 
    WHERE E.EMP_NO = DE.EMP_NO
    AND E.EMP_NO = S.EMP_NO
    AND DE.DEPT_NO = D.DEPT_NO
    AND S.TO_DATE = '9999-01-01'
    AND DE.TO_DATE = '9999-01-01'
    AND E.EMP_NO IN (SELECT DEMP.EMP_NO EMP_NO
						FROM DEPT_EMP DEMP, SALARIES SAL, (SELECT DE.DEPT_NO MAX_DE, MAX(SALARY) MAX_SAL
															FROM SALARIES S, DEPT_EMP DE
															WHERE S.EMP_NO = DE.EMP_NO
															AND S.TO_DATE = '9999-01-01'
															AND DE.TO_DATE = '9999-01-01'
															GROUP BY DE.DEPT_NO) A 
						WHERE DEMP.DEPT_NO = A.MAX_DE
						AND SAL.SALARY = A.MAX_SAL
						AND SAL.EMP_NO = DEMP.EMP_NO
						AND SAL.TO_DATE = '9999-01-01'
						AND DEMP.TO_DATE = '9999-01-01')
	ORDER BY S.SALARY DESC;


-- 문제3.
-- 현재, 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번, 이름과 연봉을 조회하세요 
SELECT E.EMP_NO, E.FIRST_NAME, S.SALARY
	FROM EMPLOYEES E, SALARIES S, DEPT_EMP DE, (SELECT DE.DEPT_NO DEPT_NO, AVG(S.SALARY) AVG_SAL
									FROM SALARIES S, DEPT_EMP DE
									WHERE S.EMP_NO = DE.EMP_NO
									AND S.TO_DATE = '9999-01-01'
									AND DE.TO_DATE = '9999-01-01' 
									GROUP BY DE.DEPT_NO) A
	WHERE E.EMP_NO = S.EMP_NO
    AND E.EMP_NO = DE.EMP_NO
    AND DE.DEPT_NO = A.DEPT_NO
    AND S.TO_DATE = '9999-01-01'
	AND DE.TO_DATE = '9999-01-01' 
    AND S.SALARY > A.AVG_SAL
    ;

-- 문제4.
-- 현재, 사원들의 사번, 이름, 매니저 이름, 부서 이름으로 출력해 보세요.
SELECT E.EMP_NO, E.FIRST_NAME, A.MGR_NAME, A.DEPT_NAME
	FROM EMPLOYEES E, (SELECT E.FIRST_NAME MGR_NAME, D.DEPT_NAME DEPT_NAME
							FROM EMPLOYEES E, DEPARTMENTS D, DEPT_MANAGER DM
							WHERE E.EMP_NO = DM.EMP_NO
							AND DM.DEPT_NO = D.DEPT_NO
							AND DM.TO_DATE = '9999-01-01') A
    WHERE E.FIRST_NAME = A.MGR_NAME;

-- 문제5.
-- 현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로 출력하세요.
SELECT E.EMP_NO, E.FIRST_NAME, T.TITLE, S.SALARY 
	FROM EMPLOYEES E, DEPT_EMP DEMP, TITLES T, SALARIES S, (SELECT DE.DEPT_NO DEPT_NO, AVG(S.SALARY) AVG_SAL
										FROM DEPT_EMP DE, SALARIES S
										WHERE DE.EMP_NO = S.EMP_NO
										AND DE.TO_DATE = '9999-01-01'
										AND S.TO_DATE = '9999-01-01'
										GROUP BY DE.DEPT_NO
                                        ORDER BY AVG_SAL DESC
										LIMIT 0,1) A 
    WHERE E.EMP_NO = DEMP.EMP_NO
    AND DEMP.TO_DATE = '9999-01-01'
    AND T.TO_DATE = '9999-01-01'
    AND S.TO_DATE = '9999-01-01'
    AND DEMP.DEPT_NO = A.DEPT_NO
    AND E.EMP_NO = S.EMP_NO
    AND E.EMP_NO = T.EMP_NO
    ORDER BY S.SALARY DESC;
    
-- 문제6.
-- 평균 연봉이 가장 높은 부서는? 
SELECT DISTINCT D.DEPT_NAME
	FROM DEPARTMENTS D, DEPT_EMP DE, SALARIES S, (SELECT DE.DEPT_NO, AVG(S.SALARY) AVG_SAL
													FROM SALARIES S, DEPT_EMP DE, DEPARTMENTS D
													WHERE D.DEPT_NO = DE.DEPT_NO
													AND DE.EMP_NO = S.EMP_NO
                                                    AND S.TO_DATE = '9999-01-01'
                                                    AND DE.TO_DATE = '9999-01-01'
													GROUP BY DE.DEPT_NO
													ORDER BY AVG_SAL DESC
                                                    LIMIT 0,1) A
    WHERE D.DEPT_NO = DE.DEPT_NO
    AND DE.EMP_NO = S.EMP_NO
    AND DE.DEPT_NO = A.DEPT_NO
    AND S.TO_DATE = '9999-01-01'
    AND DE.TO_DATE = '9999-01-01'
    ;
    
     

-- 문제7.
-- 평균 연봉이 가장 높은 직책?
SELECT T.TITLE, AVG(S.SALARY) AVG_SAL
FROM SALARIES S, TITLES T, EMPLOYEES E
WHERE E.EMP_NO = S.EMP_NO
AND E.EMP_NO = T.EMP_NO
AND S.TO_DATE = '9999-01-01'
AND T.TO_DATE = '9999-01-01'
GROUP BY T.TITLE
ORDER BY AVG_SAL DESC
LIMIT 0,1;

-- 문제8.
-- 현재 자신의 매니저보다 높은 연봉을 받고 있는 직원은?
-- 부서이름, 사원이름, 연봉, 매니저 이름, 메니저 연봉 순으로 출력합니다.
SELECT D.DEPT_NAME, EMP.EMP_NO, SAL.SALARY, A.SAL 
	FROM EMPLOYEES EMP, SALARIES SAL, DEPT_EMP DEMP, DEPARTMENTS D, (SELECT T.TITLE TITLE, E.EMP_NO EMP_NO, S.SALARY SAL, DE.DEPT_NO DEPT_NO
														FROM TITLES T, EMPLOYEES E, SALARIES S, DEPT_EMP DE
														WHERE T.EMP_NO = E.EMP_NO
														AND E.EMP_NO = S.EMP_NO
														AND DE.EMP_NO = E.EMP_NO
														AND S.TO_DATE = '9999-01-01'
														AND T.TO_DATE = '9999-01-01'
														AND DE.TO_DATE = '9999-01-01'
														AND T.TITLE = 'Manager') A
    WHERE EMP.EMP_NO = SAL.EMP_NO
    AND EMP.EMP_NO = DEMP.EMP_NO
    AND DEMP.DEPT_NO = A.DEPT_NO
    AND DEMP.DEPT_NO = D.DEPT_NO
    AND SAL.TO_DATE = '9999-01-01'
    AND DEMP.TO_DATE = '9999-01-01'
    AND SAL.SALARY > A.SAL