/*
12���� - PL/SQL : ����Ŭ���� ���α׷��� ��Ҹ� ������ SQL, �����ϰ� ó���ؼ� ����
        MSQL : T-SQL
    SQL : ����ȭ�� ���Ǿ��, ���� : ������ ���α׷��� ����� ������ �� ����.
*/

set serveroutput on;         -- PL/SQL�� ����� Ȱ��ȭ 

/* PL SQL�� �⺻ �ۼ� ���� */

begin
    -- PL/SQL ����
end;
/

-- PL/SQL���� �⺻ ���
set serveroutput on
begin
    dbms_output.put_line('Welcome to Oracle');
end;
/

-- PL / SQL���� ���� ���� �ϱ�.
    
    ������ : = ��

desc employee;
    
    -- �ڷ��� ����
        1. Oracle�� �ڷ����� ���
        2. �����ڷ��� : ���̺��� �÷��� ����� �ڷ����� �����ؼ� ���.
            %type : ���̺��� Ư���÷��� �ڷ����� �����ؼ� ���. (���̺��� �÷� 1�� ����)
            %rowtype : ���̺� ��ü �÷��� �ڷ����� ��� �����ؼ� ���
            


set serveroutput on

declare -- ���� ���� (���� �����)
    v_eno number(4);               -- ����Ŭ�� �ڷ���
    v_ename employee.ename%type;    -- ���� �ڷ��� : ���̺��� �÷��� �ڷ����� �����ؼ� ����
begin
    v_eno := 7788;                  -- := ������ ���� �Ҵ��� �� ���.
    v_ename := 'SCOTT';
    
    dbms_output.put_line('�����ȣ      ����̸�');
    dbms_output.put_line('--------------------');
    dbms_output.put_line(v_eno ||'     '|| v_ename);

end;
/

/* �����ȣ�� ����̸� ��� �ϱ� */
set serveroutput on
declare
    v_eno employee.eno%type;
    v_ename employee.ename%type;
begin
    dbms_output.put_line('�����ȣ      ����̸�');
    dbms_output.put_line('--------------------');
    
    select eno, ename into v_eno, v_ename
    from employee
    where ename = 'SCOTT';
    
    dbms_output.put_line(v_eno||'       '||v_ename);
end;
/

select eno, ename
from employee
where ename = 'SCOTT';

/* PL/SQL���� ��� ����ϱ� */

/* IF ~ End IF �� ����ϱ� */

set serveroutput on
declare
    v_employee employee%rowtype;    --rowtype : employee���̺��� ��� �÷��� �ڷ����� �����ؼ� ���
                                    -- v_employee ������ employee ���̺��� ��� �÷��� ����.
    annsal number (7,2);            -- �� ������ �����ϴ� ����
begin
    select * into v_employee
    from employee
    where ename = 'SCOTT';
    
    if (v_employee.commission is null) then
        v_employee.commission := 0;
    end if;
    
    annsal := v_employee.salary * 12 + v_employee.commission;
    
    dbms_output.put_line('�����ȣ      ����̸�        ����');
    dbms_output.put_line('--------------------------------');
    dbms_output.put_line(v_employee.eno || '    '||v_employee.ename||'   '||
            annsal );
end;
/

/*
    v_employee.eno := 77788
    v_employee.ename := 'SCOTT'
    v_employee.job := ANALYST
    v_employee.manager := 7566
    v_employee.hiredate := 87/07/13
    v_employee.salary := 3000
    v_employee.commission := 
*/

select * from employee
where ename = 'SCOTT';

/* 
    PL/SQL�� ����ؼ� department ���̺��� ������ ��Ƽ� ��� �غ�����.
    ������ dno = 20�� ������ ��Ƽ� ��� �غ�����.
*/
1. %type : ������ data type�� ���̺��� �÷��ϳ��ϳ��� �����ؼ� �Ҵ�.
set serveroutput on
declare 
    v_dno department.dno%type;
    v_dname department.dname%type;
    v_loc department.loc%type;
begin
    select dno,dname,loc into v_dno, v_dname, v_loc
    from department
    where dno = 20;
    
    dbms_output.put_line('�μ���ȣ   �μ���   ��ġ');
    dbms_output.put_line('---------------------');
    dbms_output.put_line(v_dno||'   '||v_dname||'   '||v_loc);
end;
/

2. %rowtype : ���̺��� ��� �÷��� �����ؼ� ���
set serveroutput on
declare 
    v_department department%rowtype;
begin
    select dno,dname,loc into v_department
    from department
    where dno = 20;
    
    dbms_output.put_line('�μ���ȣ   �μ���   ��ġ');
    dbms_output.put_line('---------------------');
    dbms_output.put_line(v_department.dno||'   '||v_department.dname||'   '||v_department.loc);
end;
/

/* IF ~ ELSIF ~ END IF */

set serveroutput on
declare
    v_eno employee.eno%type;
    v_ename employee.ename%type;
    v_dno employee.dno%type;
    v_dname department.dname%type := null;
 begin
    select eno, ename,dno into v_eno,v_ename,v_dno
    from employee
    where ename = 'SCOTT';
    
    if(v_dno = 10) then
        v_dname := 'ACCOUNT';
    elsif (v_dno = 20) then
        v_dname := 'RESEARCH';
    elsif (v_dno = 30) then
        v_dname := 'SALES';
    elsif (v_dno = 40) then
        v_dname := 'OPERATIONS';
    end if;
    
    DBMS_OUTPUT.PUT_line('�����ȣ  ����� �μ���');
    dbms_output.put_line('---------------------');
    dbms_output.put_line(v_eno||'   '||v_ename||'   '||v_dname);
 end;
 /
 
 /* employee ���̺��� eno, ename, salary, dno �� PL/SQL�� ����ؼ� ���
    ������ ���ʽ� 1400�� ����� ���ؼ�
*/

1. %type

set serveroutput on
declare
    v_eno employee.eno%type;
    v_ename employee.ename%type;
    v_salary employee.salary%type;
    v_dno employee.dno%type;
begin
    select eno,ename,salary,dno into v_eno,v_ename,v_salary,v_dno
    from employee
    where commission = 1400;
    
    dbms_output.put_line('�����ȣ  �̸�  ����  �μ���ȣ');
    dbms_output.put_line('---------------------------');
    dbms_output.put_line(v_eno||'  '||v_ename||'   '||v_salary||'  '||v_dno);
end;
/
2. %rowtype

set serveroutput on
declare
    v_employee employee%rowtype;
begin
    select * into v_employee
    from employee
    where commission = 1400;
    
    dbms_output.put_line('�����ȣ  �̸�  ����  �μ���ȣ');
    dbms_output.put_line('---------------------------');
    dbms_output.put_line(v_employee.eno||'  '||v_employee.ename||'   '||v_employee.salary||'  '||v_employee.dno);
end;
/

/* Ŀ�� (cursor) : PL/SQL���� select�� ����� ���� ���ڵ尡 �ƴ϶� ���ڵ� ���� ��쿡 Ŀ���� �ʿ��ϴ�.*/

declare
    cursor Ŀ����                      1. Ŀ�� ����
    is
    Ŀ���� ������ select ����

begin
    open Ŀ����;                       2. Ŀ�� ����
    loop
        fetch ����                    3. Ŀ���� �̵��ϰ� ���
    end loop;
    close Ŀ����;                      4. Ŀ���� ����
end;
/

/* Ŀ���� ����ؼ� department ���̺��� ��� ������ ��� �ϱ� */

set serveroutput on
declare
    v_dept department%rowtype;      -- ���� ����
    cursor c1                       -- 1. Ŀ�� ����
    is
    select * from department;
begin
    dbms_output.put_line('�μ���ȣ  �μ��� �μ���ġ');
    dbms_output.put_line('----------------------');
    open c1;                -- 2. Ŀ�� ����
    loop
        fetch c1 into v_dept.dno,v_dept.dname, v_dept.loc;
        exit when c1%notfound;
        dbms_output.put_line(v_dept.dno||'  '||v_dept.dname||'  '||v_dept.loc);
    end loop;
    close c1;               -- 4. Ŀ�� ����
end;
/

/*
    Ŀ���� �Ӽ��� ��Ÿ���� �Ӽ� ��
    Ŀ����%notfound : Ŀ������ ���� ��� �ڷᰡ FETCH�Ǿ��ٸ� true
    Ŀ����%found : Ŀ������ ���� FETCH ���� �ʴ� �ڷᰡ �����ϸ� true
    Ŀ����%isopen : Ŀ���� ���µǾ��ٸ� true
    Ŀ�Ÿ�%rowcount : Ŀ���� ���� ���ڵ� ����
*/

/*
    �����, �μ���, �μ���ġ, ���� �� ����ϼ���. PL/SQL�� ����ؼ� ����ϼ���. <Ŀ���� �̿�>
*/
select * from department;
set serveroutput on
declare 
    v_emp employee%rowtype;
    v_dept department%rowtype;
    cursor c2
    is
    select ename, dname, loc, salary 
    from employee e, department d
    where e.dno = d.dno;
begin
    dbms_output.put_line('�����   �μ���     �μ���ġ    ����');
    dbms_output.put_line('----------------------');
    
    open c2;
    loop
        fetch c2 into v_emp.ename, v_dept.dname, v_dept.loc, v_emp.salary;
        exit when c2%notfound;
        dbms_output.put_line(v_emp.ename||'     '||v_dept.dname||'      '||v_dept.loc||'        '||v_emp.salary);
    end loop;
    close c2;
end;
/

/*
    cursor for loop ������ Ŀ���� ����ؼ� ���� ���ڵ�� ��� �ϱ�.
        - open, close �� ���� �ؼ� ���
        - �� ���̺��� ��ü ������ ����� �� ���
*/

set serveroutput on
declare
    v_dept department%rowtype;
    cursor c1                       -- Ŀ�� ����
    is
    select * from department;
begin
    DBMS_OUTPUT.PUT_LINE('�μ���ȣ      �μ���     ������');
    DBMS_OUTPUT.PUT_LINE('----------------------------');
    for v_dept in c1 loop
        DBMS_OUTPUT.PUT_LINE(v_dept.dno || '    '||v_dept.dname||'      '||v_dept.loc);
    end loop;
end;
/

-- employee ���̺��� ��� ������ cursor for loop�� ����ؼ� ��� �� ������.
select * from employee;
set serveroutput on
declare
    v_emp employee%rowtype;
    cursor c2
    is
    select * from employee;
begin
    for v_emp in c2 loop
        dbms_output.put_line(v_emp.eno || '    '||v_emp.ename||'    '||v_emp.job||'    '||v_emp.manager||'    '||v_emp.hiredate||'    '||v_emp.salary||'    '||v_emp.commission||'    '||v_emp.dno);
    end loop;
end;
/

-- employee ���̺��� �����ȣ, �����, ����, �μ���ȣ�� ��� , ������ 2000 �̻��̰� �μ��� 20��,30�� �μ��� ���

set serveroutput on
declare
    v_emp employee%rowtype;
    cursor c3
    is
    select eno,ename,salary,dno
    from employee
    where (salary >=2000) and (dno in (20,30));
begin
    DBMS_OUTPUT.PUT_LINE('�����ȣ  �����  ����   �μ���ȣ');
    DBMS_OUTPUT.PUT_LINE('----------------------------');
    for v_emp in c3 loop
        dbms_output.put_line(v_emp.eno||'    '||v_emp.ename||'    '||v_emp.salary||'    '||v_emp.dno);
    end loop;
end;
/

/*
    Ʈ����(Trigger) : ������ ��Ƽ� (Ʈ����) , ��Ƽ踦 ���� �Ѿ��� �߻��.
        - ���̺� �����Ǿ� �ִ�.
        - ���̺� �̺�Ʈ�� �߻��� �� �ڵ����� �۵��Ǵ� ���α׷� �ڵ�
        - ���̺� �߻��Ǵ� �̺�Ʈ (Insert, Update, Delete)
        - Ʈ���ſ��� ���ǵ� begin ~ end ������ ������ �����.
        - before Ʈ���� : ���̺��� Ʈ���Ÿ� ���� ���� �� Insert, Update, Delete�� ����
        - after Ʈ���� : Insert, Update, delete�� ���� �� Ʈ���Ÿ� ����.
        - ��) �ֹ� ���̺� ���� �־��� �� ��� ���̺� �ڵ����� ����
        - ��) �߿� ���̺��� �α׸� ���� ���� ����
        - :new >> ������ �ӽ����̺�, Ʈ���Ű� ������ ���̺� ���Ӱ� ������ ���ڵ��� �ӽ� ���̺�
        - :old >> ������ �ӽ����̺�, Ʈ���Ű� ������ ���̺� �����Ǵ� ���ڵ��� �ӽ� ���̺�
        - Ʈ���Ŵ� �ϳ��� ���̺� �� 3������ ������, (insert, update, delete)
*/

-- �ǽ� ���̺� 2�� ���� : ���̺��� ������ ����
create table dept_original
as
select * from department
where 0=1;

create table dept_copy
as
select * from department
where 0=1;

drop table dept_copy;

select * from dept_original;
select * from dept_copy;

-- Ʈ���� ���� (dept_original ���̺� ����, insert �̺�Ʈ�� �߻��� �� �ڵ����� �۵�)

create or replace trigger tri_sample1
    -- Ʈ���Ű� ������ ���̺�, �̺�Ʈ (Insert, Update, delete), Before, After,
    after insert        -- insert �̺�Ʈ�� �۵� �� Ʈ���Ű� �۵� (begin ~ end ������ �ڵ�)
    on dept_original    -- on ������ ���̺�
    for each row        -- ��� row�� ���ؼ�
    
begin       -- Ʈ���Ű� �۵��� �ڵ�
    if inserting then
        dbms_output.put_line('Insert Trigger �߻� !!!!');
        insert into dept_copy
        values (:new.dno, :new.dname, :new.loc);        -- new ���� �ӽ� ���̺�
    end if;
end;
/

/* Ʈ���� Ȯ�� ������ ���� : user_source */
select * from user_source where name = 'TRI_SAMPLE1';

select * from dept_original;
select * from dept_copy;

insert into dept_original
values (15,'PROGRAM3','PUSAN');

/* delete Ʈ���� : dept_original���� ���� ===> dept_copy ���� �ش� ������ ����*/

create or replace trigger tri_del
    -- Ʈ���Ű� �۵���ų ���̺�, �̺�Ʈ
    after delete        -- ���� ���̺��� delete�� ���� ���� �� Ʈ���� �۵�
    on dept_original    -- dept_original ���̺� Ʈ���� ����
    for each row
begin       -- Ʈ���Ű� �۵��� �ڵ�
    dbms_output.put_line('Delete Trigger �߻��� !!!');
    delete dept_copy
    where dept_copy.dno = :old.dno;         -- dept-original���� �����Ǵ� ���� �ӽ� ���̺� :old
end;
/

select * from dept_original;
select * from dept_copy;

delete dept_original
where dno = 15;

/* update Ʈ���� : dept_original ���̺��� Ư�� ���� �����ϸ� dept_copy ���̺��� ������ ������Ʈ �� */

create or replace trigger tri_update
    after update
    on dept_original
    for each row
begin
    dbms_output.put_line('Update Trigger �߻��� !!!');
    update dept_copy
    set dept_copy.dname = :new.dname
    where dept_copy.dno = 13;
end;
/

update dept_original
set dname = 'prog'
where dno = 13;

select * from dept_original;
select * from dept_copy;