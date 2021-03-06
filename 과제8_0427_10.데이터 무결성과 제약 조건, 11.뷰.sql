/*
10 : 테이터 무결성과 제약 조건, 11 뷰
*/

/*
1. employee 테이블의 구조를 복사하여 emp_sample 란 이름의 테이블을 만드시오. 
사원 테이블의 사원번호 컬럼에 테이블 레벨로 primary key 제약조건을 지정하되 제약조건 이름은 my_emp_pk로 지정하시오. 
*/

--  테이블 복사할 때 제약조건은 복사되지 않는다. alter table을 사용해서 넣어줘야 한다.

create table emp_sample
as
select * from employee;

select * from emp_sample;

alter table emp_sample
add constraint pk_emp_sample_eno Primary Key(eno);

select * from user_constraints
where table_name in ('EMP_SAMPLE','DEPT_SAMPLE');

/*
2. department 테이블의 구조를 복사하여 dept_sample 란 이름의 테이블을 만드시오. 
부서 테이블의 부서번호 컬럼에 레벨로 primary key 제약 조건을 지정하되 제약 조건이름은 my_dept_pk로 지정하시오. 
*/

create table dept_sample
as
select * from department;

select * from dept_sample;

alter table dept_sample
add constraint my_dept_pk primary key(dno);

/*
3. 사원 테이블의 부서번호 컬럼에 존재하지 않는 부서의 사원이 배정되지 않도록 외래키 제약조건을 지정하되 
제약 조건이름은 my_emp_dept_fk 로 지정하시오. [주의 : 위 복사한 테이블을 사용하시오]
*/

alter table emp_sample
add constraint FK_emp_sample_dno_dept_sample Foreign Key(dno) REFERENCES dept_sample(dno);

select * from user_constraints
where table_name in ('EMP_SMAPLE','DEPT_SAMPLE');

/*
4. 사원테이블의 커밋션 컬럼에 0보다 큰 값만을 입력할 수 있도록 제약 조건을 지정하시오. [주의 : 위 복사한 테이블을 사용하시오]
*/


alter table emp_sample
add constraint CK_emp_sample_commission check(commission >= 0);

/*
5. 사원테이블의 웝급 컬럼에 기본 값으로 1000 을 입력할 수 있도록 제약 조건을 지정하시오. [주의 : 위 복사한 테이블을 사용하시오]
*/

alter table emp_sample
modify salary default 1000;

/*
6. 사원테이블의 이름 컬럼에 중복되지 않도록  제약 조건을 지정하시오. [주의 : 위 복사한 테이블을 사용하시오]
*/

select * from user_constraints
where table_name in ('EMP_SAMPLE','DEPT_SAMPLE');

alter table emp_sample
add constraint uk_emp_sample_ename Unique(ename);

/*
7. 사원테이블의 커밋션 컬럼에 null 을 입력할 수 없도록 제약 조건을 지정하시오. [주의 : 위 복사한 테이블을 사용하시오]
*/

alter table emp_sample
modify commission NOT NULL;

/*
8. 위의 생성된 모든 제약 조건을 제거 하시오. 
*/


    
select * from user_constraints
where table_name = 'EMP_SAMPLE';
drop table dept_sample cascade constraints;

--제약 조건을 제거시 : Foreign Key 참조하면 제거가 안된다
    -- 1. Foreign Key를 먼저 제거 후 Primary Key 제거
    -- 2. Primary Key를 제거할 때 cascade 옵션을 사용 : Foreign Key 먼저 제거되고 Primary Key가 제거됨.
    
alter table dept_sample
drop primary key cascade;

alter table emp_sample
drop constraint PK_EMP_SAMPLE_ENO;

alter table emp_sample
drop constraint CK_EMP_SAMPLE_COMMISSION;


/*
뷰 문제 

1. 20번 부서에 소속된 사원의 사원번호과 이름과 부서번호를 출력하는 select 문을 하나의 view 로 정의 하시오.
	뷰의 이름 : v_em_dno  
*/

create table emp_view
as
select * from employee;

create table dept_view
as
select * from department;

-- 뷰 생성
create view v_em_dno
as
select eno, ename, dno
from emp_view
where dno = 20;

-- 뷰 실행
select * from v_em_dno;

/*
2. 이미 생성된 뷰( v_em_dno ) 에 대해서 급여 역시 출력 할 수 있도록 수정하시오. 
*/
create or replace view v_em_dno
as
select eno, ename, dno, salary
from emp_view
where dno = 20;


/*
3. 생성된  뷰를 제거 하시오. 
*/

drop view v_em_dno;

/*
4. 각 부서의 급여의  최소값, 최대값, 평균, 총합을 구하는 뷰를 생성 하시오.  // 틀림 group by dno를 안 넣음. 
	뷰이름 : v_sal_emp
*/

create view v_sal_emp
as
select min(salary) min, max(salary) max, avg(salary) avg, sum(salary) sum
from emp_view
group by dno;

select * from v_sal_emp;

/*
5. 이미 생성된 뷰( v_em_dno ) 에 대해서 읽기 전용 뷰로 수정하시오. 
*/

create or replace view v_sal_emp
as
select min(salary) min, max(salary) max, avg(salary) avg, sum(salary) sum
from emp_view with read only;