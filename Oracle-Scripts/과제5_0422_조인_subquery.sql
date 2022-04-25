subquery 문제. 

Join 문제.
완료 시간 : 6:20분까지. 
select * from employee;
/*
7. SELF JOIN을 사용하여 사원의 이름 및 사원번호를 관리자 이름 및 관리자 번호와 함께 출력 하시오. 
 	각열에 별칭값을 한글로 넣으시오. 
    -- self JOIN : 반드시 테이블의 별칭을 사용. select 컬럼을 출력할 때 별칭이름.컬럼명 
        -- 조직도를 출력, 사원의 직속상관 정보를 출력.
*/

-- EUQI JOIN : 오라클에서만 사용하는 구문, 두 테이블의 키가 일치하는 것만 출력
-- ANSI : INNER JOIN으로 변환 가능 (모든 DMBS에서 공통 구문, MSSQL, My-SQL, IBM DB2)

select e.ename as "사원의 이름", e.eno as 사원번호, m.ename as "관리자 이름", e.manager as "관리자 번호"
from employee e, employee m
where e.manager = m.eno;

select e1.ename 사원이름, e1.eno 사원번호, e1.manager 관리자번호, e2.ename 관리자이름
from employee e1 inner join employee e2
on e1.manager = e2.eno;

/*
8. OUTER JOIN, SELF JOIN을 사용하여 관리자가 없는 사원을 포함하여 사원번호를 기준으로 내림차순 정렬하여 출력 하시오. 
*/

select e1.ename 사원이름, e1.eno 사원번호, e1.manager 관리자번호, e2.ename 관리자이름
from employee e1, employee e2
where e1.manager = e2.eno (+)
order by e1.eno desc;

-- EQUI JOIN에서는 where 절에 (+)를 붙여주면 outer join과 동일하다.

select e.ename, m.ename
from employee e left outer join employee m
on e.manager = m.eno
order by e.eno desc;

/*
9. SELF JOIN을 사용하여 지정한 사원('SCOTT')의 이름, 부서번호, 지정한 사원과 동일한 부서에서 근무하는 사원을 출력하시오. 
   단, 각 열의 별칭은 이름, 부서번호, 동료로 하시오. / 틀림 m.ename != 'SCOTT'을 빼먹음.
*/

select e.ename as "이름", e.dno as "부서번호", m.ename as "동료"
from employee e, employee m
where e.dno = m.dno
and e.ename = 'SCOTT' and m.ename <> 'SCOTT';

/*
10. SELF JOIN을 사용하여 WARD 사원보다 늦게 입사한 사원의 이름과 입사일을 출력하시오. 
*/

select m.ename 이름, m.hiredate 입사일
from employee e, employee m
where  e.hiredate < m.hiredate
and e.ename = 'WARD';

/*
11. SELF JOIN을 사용하여 관리자 보다 먼저 입사한 모든 사원의 이름 및 입사일을 관리자 이름 및 입사일과 함께 출력하시오. 
    단, 각 열의 별칭을 한글로 넣어서 출력 하시오. 
*/

select e.ename 이름, e.hiredate 입사일, m.ename as "관리자 이름", m.hiredate as "관리자 입사일"
from employee e, employee m
where e.manager = m.eno 
and e.hiredate < m.hiredate;

/*
<<아래 문제는 모두 Subquery를 사용하여 문제를 푸세요.>>

1. 사원번호가 7788인 사원과 담당 업무가 같은 사원을 표시(사원이름 과 담당업무) 하시오.  
*/

select ename, job
from employee
where job = (select job from employee where eno = 7788);

/*
2. 사원번호가 7499인 사원보다 급여가 많은 사원을 표시 (사원이름 과 담당업무) 하시오. 
*/

select ename 사원이름, job 담당업무
from employee
where salary > (select salary from employee where eno = 7499);

/*
3. 최소 급여를 받는 직급별 사원의 이름, 담당 업무 및 급여를 표시 하시오(그룹 함수 사용)
*/

select ename 사원이름, job 담당업무, salary 급여
from employee
where salary in (select min(salary) from employee group by job )
order by job;

/*
4. 직급별 급여 평균 중에 가장 낮은 평균을 가진 직급에서 가장 낮은 급여를 갖는 사원 출력
*/

select ename 이름, job 직급, salary 급여
from employee
where salary = (select min(salary) from employee group by job having avg(salary) <= all(select avg(salary) from employee group by job));

select ename 이름, job 직급, salary 급여
from employee
where salary = (select min(salary) from employee group by job having avg(salary) = (select min(avg(salary)) from employee group by job));

select min(salary) 급여, job 직급
from employee
group by job
having avg(salary) <= all (select avg(salary) from employee group by job);

/*
5. 각 부서의 최소 급여를 받는 사원의 이름, 급여, 부서번호를 표시하시오.
*/

select ename,salary, dno
from employee
where salary in (select min(salary) from employee group by dno );

/*
6. 담당 업무가 분석가(ANALYST) 인 사원보다 급여가 적으면서 업무가 분석가가 아닌 사원들을 표시 (사원번호, 이름, 담당업무, 급여) 하시오.
*/

select eno, ename, job, salary
from employee
where salary < (select min(salary) from employee where job = 'ANALYST') and job != 'ANALYST';

/*
7. 부하직원이 없는 사원의 이름을 표시 하시오. 
*/

select ename
from employee
where ename not in (select m.ename from employee e, employee m where e.manager = m.eno group by m.ename);

-- 선생님것, 훨씬 깔끔
select eno, ename
from employee
where eno not in (select manager from employee where manager is not null);

/*
8. 부하직원이 있는 사원의 이름을 표시 하시오. 
*/

select ename
from employee
where ename in (select m.ename from employee e, employee m where e.manager = m.eno group by m.ename);

-- 선생님것 , 훨씬 깔끔하다
select eno, ename
from employee
where eno in (select manager from employee where manager is not null);

/*
9. BLAKE 와 동일한 부서에 속한 사원의 이름과 입사일을 표시하는 질의를 작성하시오(단, BLAKE 는 제외). 
*/

select ename 성명, hiredate 입사일
from employee
where dno = (select dno from employee where ename = 'BLAKE') and ename <> 'BLAKE';

/*
10. 급여가 평균보다 많은 사원들의 사원번호와 이름을 표시하되 결과를 급여에 대해서 오름 차순으로 정렬 하시오. 
*/

select eno, ename
from employee
where salary > (select avg(salary) from employee)
order by salary asc;

/*
11. 이름에 K 가 포함된 사원과 같은 부서에서 일하는 사원의 사원번호와 이름을 표시하는 질의를 작성하시오. 
*/

select eno, ename
from employee
where dno in (select dno from employee where ename like '%K%');

/*
12. 부서 위치가 DALLAS 인 사원의 이름과 부서 번호 및 담당 업무를 표시하시오. 
*/

select * from department
select * from employee;

-- JOIN을 사용
select ename, e.dno, job, loc               -- 두 테이블의 공통 키 컬럼, EQUI JOIN에서는 테이블명을 명시
from employee e, department d
where e.dno = d.dno
and loc = 'DALLAS';

-- Sub Query
select ename, e.dno, job, loc
from employee e, department d
where e.dno = d.dno
and e.dno in (select dno from department where loc = 'DALLAS');

/*
13. KING에게 보고하는 사원의 이름과 급여를 표시하시오. 
*/

select ename, salary
from employee
where manager = (select eno from employee where ename = 'KING');

/*
14. RESEARCH 부서의 사원에 대한 부서번호, 사원이름 및 담당 업무를 표시 하시오. 
*/

-- Sub Query
select dno, ename, job
from employee
where dno = (select dno from department where dname = 'RESEARCH');

-- JOIN
select e.dno 부서번호, ename 사원이름, job 담당업무
from employee e, department d
where e.dno = d.dno
and d.dname = 'RESEARCH';

/*
15. 평균 급여보다 많은 급여를 받고 이름에 M이 포함된 사원과 같은 부서에서 근무하는 사원의 사원번호, 이름, 급여를 표시하시오. 
*/

select eno 사원번호, ename 이름, salary 급여
from employee
where dno in (select dno from employee where ename like '%M%') and salary > (select avg(salary) from employee);

/*
16. 평균 급여가 가장 적은 업무를 찾으시오. 
*/

select job, round(avg(salary))
from employee
group by job
having avg(salary) <= all(select avg(salary) from employee group by job);

/*
17. 담당업무가 MANAGER인 사원이 소속된 부서와 동일한 부서의 사원을 표시하시오. 
*/

select ename 사원명
from employee
where dno in (select dno from employee where job = 'MANAGER');