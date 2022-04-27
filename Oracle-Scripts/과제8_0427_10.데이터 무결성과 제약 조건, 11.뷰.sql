/*
10 : ������ ���Ἲ�� ���� ����, 11 ��
*/

/*
1. employee ���̺��� ������ �����Ͽ� emp_sample �� �̸��� ���̺��� ����ÿ�. 
��� ���̺��� �����ȣ �÷��� ���̺� ������ primary key ���������� �����ϵ� �������� �̸��� my_emp_pk�� �����Ͻÿ�. 
*/

create table emp_sample
as
select * from employee;

select * from emp_sample;

alter table emp_sample
add constraint my_emp_pk Primary Key(eno);

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
add constraint my_emp_dept_fk Foreign Key(dno) REFERENCES dept_sample(dno);



/*
4. ������̺��� Ŀ�Լ� �÷��� 0���� ū ������ �Է��� �� �ֵ��� ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
*/

update emp_sample
set commission = 0
where commission is null;

commit;

select * from emp_sample;

select * from user_constraints
where table_name = 'emp_sample';

alter table emp_sample
add constraint ck_emp_sample CHECK(COMMISSION > 0);

alter table emp_sample
add constraint CK_emp_sample_commission check(commission > 0);

/*
5. ������̺��� ���� �÷��� �⺻ ������ 1000 �� �Է��� �� �ֵ��� ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
*/

alter table emp_sample
modify salary default 1000;

/*
6. ������̺��� �̸� �÷��� �ߺ����� �ʵ���  ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
*/

alter table emp_sample
add constraint uk_emp_sample_ename Unique(ename);

/*
7. ������̺��� Ŀ�Լ� �÷��� null �� �Է��� �� ������ ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
*/

alter table emp_sample
modify commission constraint NN_emp_sample_commission NOT NULL;

/*
8. ���� ������ ��� ���� ������ ���� �Ͻÿ�. 
*/
select * from user_constraints
where table_name = 'EMP_SAMPLE';
drop table dept_sample cascade constraints;

/*
�� ���� 

1. 20�� �μ��� �Ҽӵ� ����� �����ȣ�� �̸��� �μ���ȣ�� ����ϴ� select ���� �ϳ��� view �� ���� �Ͻÿ�.
	���� �̸� : v_em_dno  
*/

create view v_em_dno
as
select eno, ename, dno
from employee
where dno = 20;

/*
2. �̹� ������ ��( v_em_dno ) �� ���ؼ� �޿� ���� ��� �� �� �ֵ��� �����Ͻÿ�. 
*/
create or replace view v_em_dno
as
select eno, ename, dno, salary
from employee
where dno = 20;


/*
3. ������  �並 ���� �Ͻÿ�. 
*/

drop view v_em_dno;

/*
4. �� �μ��� �޿���  �ּҰ�, �ִ밪, ���, ������ ���ϴ� �並 ���� �Ͻÿ�. 
	���̸� : v_sal_emp
*/

create view v_sal_emp
as
select min(salary) min, max(salary) max, avg(salary) avg, sum(salary) sum
from employee;

/*
5. �̹� ������ ��( v_em_dno ) �� ���ؼ� �б� ���� ��� �����Ͻÿ�. 
*/

create or replace view v_sal_emp
as
select min(salary) min, max(salary) max, avg(salary) avg, sum(salary) sum
from employee with read only;