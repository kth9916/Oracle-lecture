--테이블 조인 문제 - 06
select * from employee;
--1. EQUI 조인을 사용하여 SCOTT 사원의 부서 번호와 부서 이름을 출력 하시오. 
select e.dno, dname
from employee e, department d
where e.dno = d.dno
and ename = 'SCOTT';

--2. INNER JOIN과 ON 연산자를 사용하여 사원이름과 함께 그 사원이 소속된 부서이름과 지역명을 출력하시오. 
select ename, dname, loc
from employee e join department d
on e.dno = d.dno;

--3. INNER JOIN과 USING 연산자를 사용하여 10번 부서에 속하는 모든 담당 업무의 고유한 목록(한번씩만 표시)을 부서의 지역명을 포함하여 출력 하시오. 

--4. NATUAL JOIN을 사용하여 커밋션을 받는 모든 사원의 이름, 부서이름, 지역명을 출력 하시오. 
select ename,  dname, loc
from employee natural join department;

--5. EQUI 조인과 WildCard(_,%)를 사용하여 이름에 A 가 포함된 모든 사원의 이름과 부서명을 출력 하시오. 
select ename, dname
from employee e, department d
where e.dno = d.dno
and ename like '%A%';
--6. NATURAL JOIN을 사용하여 NEW YORK에 근무하는 모든 사원의 이름, 업무, 부서번호 및 부서명을 출력하시오. 
select ename, job, dno, dname
from employee natural join department
where loc = 'NEW YORK';