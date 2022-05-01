-- 주말 과제

/*
[문항1] 다음과 같은 예제 테이블을 기준으로 아래 문항에 답하시오

EQUI 조인을 사용하여 SCOTT 사원의 사원번호, 사원이름, 직책, 부서번호,  부서이름을 출력 하시오
*/

select eno 사원번호, ename 사원이름, job 직책, e.dno 부서번호, dname 부서이름
from employee e, department d
where e.dno = d.dno
and e.ename = 'SCOTT';

/*
[문항2] ANSI 호환인 INNER 조인을 사용하여 SCOTT 사원의 사원번호, 사원이름, 직책, 부서번호,  부서이름을 출력 하시오 .
*/

select eno 사원번호, ename 사원이름, job 직책, e.dno 부서번호, dname 부서이름
from employee e join department d
on e.dno = d.dno
where e.ename = 'SCOTT';

/*
[문항3] employee 테이블을 복사해서 emp_copy 테이블을 생성 하시오, department 테이블을 복사해서 dept_copy 테이블을 생성하시오.
*/

create table emp_copy
as
select * from employee;

create table dept_copy
as
select * from department;

/*
[문항4] Alter Table 을 사용해서 3번 문항의 emp_copy, dept_copy 테이블의 제약 조건을 추가 하시오.

    - emp_copy 테이블의 eno 컬럼에 Primary Key 제약 조건을 추가하시오. ( 제약조건이름: emp_copy_eno_pk )
        - dept_copy 테이블의 dno 컬럼에 Primary Key 제약조건을 추가하시오 ( 제약조건이름: dept_copy_don_pk )
    - emp_copy 테이블의 dno 컬럼에 Foreign Key 제약 조건을 추가 하시오 ( 제약조건이름: emp_copy_dno_fk )
*/

alter table emp_copy
add constraint emp_copy_eno_pk primary key(eno);

alter table dept_copy
add constraint dept_copy_dno_pk primary key(dno);

alter table emp_copy
add constraint emp_copy_dno_fk foreign key(dno) references dept_copy(dno);

/*
[문항5] employee 테이블에서 직책이 ’SALESMAN’ 인 사원의 사원번호, 사원이름, 부서번호, 직책 을 출력하는 뷰를 생성하시오
(뷰이름 : v_emp_job) ??생성한 뷰를 출력하는 구문을 작성하시오.
*/

create view v_emp_job
as
select eno 사원번호, ename 사원이름, dno 부서번호, job 직책
from employee
where job = 'SALESMAN';

/*
[문항6] v_auto_join 뷰 이름으로  1번 문항의 JOIN 구문을 생성하는 뷰를 만드시오. 뷰를 출력하는 구문을 작성하시오.
*/

create view v_auto_join
as
select eno 사원번호, ename 사원이름, job 직책, e.dno 부서번호, dname 부서이름
from employee e, department d
where e.dno = d.dno
and e.ename = 'SCOTT';

/*
[문항7] employee 테이블의 ename 컬럼은 검색에 자주 사용하는 컬럼입니다. 이컬럼에 index 를 생성하시오. ?
( 인덱스 이름 : idx_employee_ename )
*/

create index idx_employee_ename
on employee(ename);

/*
[문항8] NVL2 함수를 사용하여 각 사원의 연봉을 출력하는 쿼리를 작성하시오. 
출력 컬럼은 [사원이름], [연봉] 으로 별칭 이름을 사용하여 출력 하시오.
*/

select ename 사원이름, nvl2(salary, salary, 0) * 12 연봉
from employee;

/*
[문항9] 초기값 1 증가값 1씩 증가하는 시퀀스를 생성하시오. 단 cache는 생성하지 않도록 설정하시오.
department 테이블의 구조만 복사하여 dept_copy 테이블을 생성하여 dno 컬럼에 생성된 시퀀스를 적용 하시오.
*/

create SEQUENCE d_seq
    increment by 1
    start with 1
    nocache;

create table dept_copy
as
select * from department
where 0=1;

insert into dept_copy(dno)
values (D_SEQ.nextval);

/*
[문항10] self 조인을 사용해서 Employee 테이블의  직급상사번호에 해당 하는 직급 상사명을 출력하시오.
 출력 컬럼은 [사원번호], [사원이름], [직급상사번호],[직급상사명] 으로 별칭이름으로 출력하시오.
*/

select e.eno 사원번호,e.ename 사원이름,m.eno 직급상사번호,m.ename 직습상사명
from employee e, employee m
where e.manager = m.eno;


