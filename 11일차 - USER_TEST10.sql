

create table TEST10TBL(
    a number not null,
    b varchar2(50) null
    );
    
--user_Test10���� hr�� �������� employee ���̺��� ������ �� -- ��ü�� ���ٱ����� �ʿ��ϴ�

select * from hr.employee;

--�⺻������ �ڽ��� ��ü�� ����� �� ���� ����.
show user;

select * from user_test10.test10tbl;

-- �ٸ� ������� ��ü�� ������ ���� �����ָ�.��ü��
select * from employee;     -- �����ָ� (user_test10) 
select * from hr.employee;  -- �ٸ� ������� ��ü�� ������ �� ������ �־�� �Ѵ�.

-- �ٸ� ����� ���̺��� insert ����.
desc hr.employee

select * from hr.emp_copy55;

desc hr.emp_copy55;

-- insert
insert into hr.emp_copy55(eno)
values (3333);

-- with grant option�� �ο� ���� USER_TEST10����
grant select on hr.employee to user_test11;
-- �� �����ϴ�.

select * from hr.dept_copy55;

select * from hr.dept_copy56;

select * from user_role_privs;

select * from hr.dept_copy57;
