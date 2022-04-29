/*
10 : ������ ���Ἲ�� ���� ����, 11 ��
*/

/*
1. employee ���̺��� ������ �����Ͽ� emp_sample �� �̸��� ���̺��� ����ÿ�. 
��� ���̺��� �����ȣ �÷��� ���̺� ������ primary key ���������� �����ϵ� �������� �̸��� my_emp_pk�� �����Ͻÿ�. 
*/

--  ���̺� ������ �� ���������� ������� �ʴ´�. alter table�� ����ؼ� �־���� �Ѵ�.

create table emp_sample
as
select * from employee;

select * from emp_sample;

alter table emp_sample
add constraint pk_emp_sample_eno Primary Key(eno);

select * from user_constraints
where table_name in ('EMP_SAMPLE','DEPT_SAMPLE');

/*
2. department ���̺��� ������ �����Ͽ� dept_sample �� �̸��� ���̺��� ����ÿ�. 
�μ� ���̺��� �μ���ȣ �÷��� ������ primary key ���� ������ �����ϵ� ���� �����̸��� my_dept_pk�� �����Ͻÿ�. 
*/

create table dept_sample
as
select * from department;

select * from dept_sample;

alter table dept_sample
add constraint my_dept_pk primary key(dno);

/*
3. ��� ���̺��� �μ���ȣ �÷��� �������� �ʴ� �μ��� ����� �������� �ʵ��� �ܷ�Ű ���������� �����ϵ� 
���� �����̸��� my_emp_dept_fk �� �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
*/

alter table emp_sample
add constraint FK_emp_sample_dno_dept_sample Foreign Key(dno) REFERENCES dept_sample(dno);

select * from user_constraints
where table_name in ('EMP_SMAPLE','DEPT_SAMPLE');

/*
4. ������̺��� Ŀ�Լ� �÷��� 0���� ū ������ �Է��� �� �ֵ��� ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
*/


alter table emp_sample
add constraint CK_emp_sample_commission check(commission >= 0);

/*
5. ������̺��� ���� �÷��� �⺻ ������ 1000 �� �Է��� �� �ֵ��� ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
*/

alter table emp_sample
modify salary default 1000;

/*
6. ������̺��� �̸� �÷��� �ߺ����� �ʵ���  ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
*/

select * from user_constraints
where table_name in ('EMP_SAMPLE','DEPT_SAMPLE');

alter table emp_sample
add constraint uk_emp_sample_ename Unique(ename);

/*
7. ������̺��� Ŀ�Լ� �÷��� null �� �Է��� �� ������ ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
*/

alter table emp_sample
modify commission NOT NULL;

/*
8. ���� ������ ��� ���� ������ ���� �Ͻÿ�. 
*/


    
select * from user_constraints
where table_name = 'EMP_SAMPLE';
drop table dept_sample cascade constraints;

--���� ������ ���Ž� : Foreign Key �����ϸ� ���Ű� �ȵȴ�
    -- 1. Foreign Key�� ���� ���� �� Primary Key ����
    -- 2. Primary Key�� ������ �� cascade �ɼ��� ��� : Foreign Key ���� ���ŵǰ� Primary Key�� ���ŵ�.
    
alter table dept_sample
drop primary key cascade;

alter table emp_sample
drop constraint PK_EMP_SAMPLE_ENO;

alter table emp_sample
drop constraint CK_EMP_SAMPLE_COMMISSION;


/*
�� ���� 

1. 20�� �μ��� �Ҽӵ� ����� �����ȣ�� �̸��� �μ���ȣ�� ����ϴ� select ���� �ϳ��� view �� ���� �Ͻÿ�.
	���� �̸� : v_em_dno  
*/

create table emp_view
as
select * from employee;

create table dept_view
as
select * from department;

-- �� ����
create view v_em_dno
as
select eno, ename, dno
from emp_view
where dno = 20;

-- �� ����
select * from v_em_dno;

/*
2. �̹� ������ ��( v_em_dno ) �� ���ؼ� �޿� ���� ��� �� �� �ֵ��� �����Ͻÿ�. 
*/
create or replace view v_em_dno
as
select eno, ename, dno, salary
from emp_view
where dno = 20;


/*
3. ������  �並 ���� �Ͻÿ�. 
*/

drop view v_em_dno;

/*
4. �� �μ��� �޿���  �ּҰ�, �ִ밪, ���, ������ ���ϴ� �並 ���� �Ͻÿ�.  // Ʋ�� group by dno�� �� ����. 
	���̸� : v_sal_emp
*/

create view v_sal_emp
as
select min(salary) min, max(salary) max, avg(salary) avg, sum(salary) sum
from emp_view
group by dno;

select * from v_sal_emp;

/*
5. �̹� ������ ��( v_em_dno ) �� ���ؼ� �б� ���� ��� �����Ͻÿ�. 
*/

create or replace view v_sal_emp
as
select min(salary) min, max(salary) max, avg(salary) avg, sum(salary) sum
from emp_view with read only;