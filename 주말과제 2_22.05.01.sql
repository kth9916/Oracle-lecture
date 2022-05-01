-- �ָ� ����

/*
[����1] ������ ���� ���� ���̺��� �������� �Ʒ� ���׿� ���Ͻÿ�

EQUI ������ ����Ͽ� SCOTT ����� �����ȣ, ����̸�, ��å, �μ���ȣ,  �μ��̸��� ��� �Ͻÿ�
*/

select eno �����ȣ, ename ����̸�, job ��å, e.dno �μ���ȣ, dname �μ��̸�
from employee e, department d
where e.dno = d.dno
and e.ename = 'SCOTT';

/*
[����2] ANSI ȣȯ�� INNER ������ ����Ͽ� SCOTT ����� �����ȣ, ����̸�, ��å, �μ���ȣ,  �μ��̸��� ��� �Ͻÿ� .
*/

select eno �����ȣ, ename ����̸�, job ��å, e.dno �μ���ȣ, dname �μ��̸�
from employee e join department d
on e.dno = d.dno
where e.ename = 'SCOTT';

/*
[����3] employee ���̺��� �����ؼ� emp_copy ���̺��� ���� �Ͻÿ�, department ���̺��� �����ؼ� dept_copy ���̺��� �����Ͻÿ�.
*/

create table emp_copy
as
select * from employee;

create table dept_copy
as
select * from department;

/*
[����4] Alter Table �� ����ؼ� 3�� ������ emp_copy, dept_copy ���̺��� ���� ������ �߰� �Ͻÿ�.

    - emp_copy ���̺��� eno �÷��� Primary Key ���� ������ �߰��Ͻÿ�. ( ���������̸�: emp_copy_eno_pk )
        - dept_copy ���̺��� dno �÷��� Primary Key ���������� �߰��Ͻÿ� ( ���������̸�: dept_copy_don_pk )
    - emp_copy ���̺��� dno �÷��� Foreign Key ���� ������ �߰� �Ͻÿ� ( ���������̸�: emp_copy_dno_fk )
*/

alter table emp_copy
add constraint emp_copy_eno_pk primary key(eno);

alter table dept_copy
add constraint dept_copy_dno_pk primary key(dno);

alter table emp_copy
add constraint emp_copy_dno_fk foreign key(dno) references dept_copy(dno);

/*
[����5] employee ���̺��� ��å�� ��SALESMAN�� �� ����� �����ȣ, ����̸�, �μ���ȣ, ��å �� ����ϴ� �並 �����Ͻÿ�
(���̸� : v_emp_job) ??������ �並 ����ϴ� ������ �ۼ��Ͻÿ�.
*/

create view v_emp_job
as
select eno �����ȣ, ename ����̸�, dno �μ���ȣ, job ��å
from employee
where job = 'SALESMAN';

/*
[����6] v_auto_join �� �̸�����  1�� ������ JOIN ������ �����ϴ� �並 ����ÿ�. �並 ����ϴ� ������ �ۼ��Ͻÿ�.
*/

create view v_auto_join
as
select eno �����ȣ, ename ����̸�, job ��å, e.dno �μ���ȣ, dname �μ��̸�
from employee e, department d
where e.dno = d.dno
and e.ename = 'SCOTT';

/*
[����7] employee ���̺��� ename �÷��� �˻��� ���� ����ϴ� �÷��Դϴ�. ���÷��� index �� �����Ͻÿ�. ?
( �ε��� �̸� : idx_employee_ename )
*/

create index idx_employee_ename
on employee(ename);

/*
[����8] NVL2 �Լ��� ����Ͽ� �� ����� ������ ����ϴ� ������ �ۼ��Ͻÿ�. 
��� �÷��� [����̸�], [����] ���� ��Ī �̸��� ����Ͽ� ��� �Ͻÿ�.
*/

select ename ����̸�, nvl2(salary, salary, 0) * 12 ����
from employee;

/*
[����9] �ʱⰪ 1 ������ 1�� �����ϴ� �������� �����Ͻÿ�. �� cache�� �������� �ʵ��� �����Ͻÿ�.
department ���̺��� ������ �����Ͽ� dept_copy ���̺��� �����Ͽ� dno �÷��� ������ �������� ���� �Ͻÿ�.
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
[����10] self ������ ����ؼ� Employee ���̺���  ���޻���ȣ�� �ش� �ϴ� ���� ������ ����Ͻÿ�.
 ��� �÷��� [�����ȣ], [����̸�], [���޻���ȣ],[���޻���] ���� ��Ī�̸����� ����Ͻÿ�.
*/

select e.eno �����ȣ,e.ename ����̸�,m.eno ���޻���ȣ,m.ename ��������
from employee e, employee m
where e.manager = m.eno;


