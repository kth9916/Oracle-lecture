-- ���� ���ν��� ���� 

/*
1. �� �μ����� �ּұ޿�, �ִ�޿�, ��ձ޿��� ����ϴ� �������ν����� �����Ͻÿ�. 
	[employee, department ] ���̺� �̿�
*/

set serveroutput on

create or replace procedure sp_salary
is      -- ���� �����, Ŀ�� ����
    v_dno employee.dno%type;
    v_min employee.salary%type;
    v_max employee.salary%type;
    v_avg employee.salary%type;
    
    cursor c2
    is
    select dno, min(salary), max(salary), avg(salary) 
    from employee
    group by dno;
begin
    open c2;
    loop
        fetch c2 into v_dno, v_min, v_max, v_avg;
        exit when c2%notfound;      -- ���ڵ��� ���� �� �̻� �������� ���� ��
        dbms_output.put_line('�μ���ȣ�� ' || v_dno||'�̰� '|| v_min||'�� �ּҰ��̰� '||v_max||'�� �ִ밪�̴�. '||v_avg ||'�� ��հ��̴�.');
    end loop;
    close c2;
end;
/
select * from user_source
where name = 'SP_SALARY';
exec SP_SALARY; 


/*
2.  �����ȣ, ����̸�, �μ���, �μ���ġ�� ����ϴ� �������ν����� �����Ͻÿ�.  
	[employee, department ] ���̺� �̿�
*/
desc employee;
create or replace procedure sp_p2
is
    v_emp employee%rowtype;
    v_dept department%rowtype;
    cursor c1
    is
    select e.eno, e.ename, d.dname, d.loc
    from employee e, department d
    where e.dno = d.dno;
begin
    open c1;
    loop
        fetch c1 into v_emp.eno,v_emp.ename,v_dept.dname,v_dept.loc;
        exit when c1%notfound;
        dbms_output.put_line(v_emp.eno||'   '||v_emp.ename||'   '||v_dept.dname||'     '||v_dept.loc);
    end loop;
    close c1;
end;
/

EXECUTE sp_p2;
/*
3. �޿��� �Է� �޾�  �Է¹��� �޿����� ���� ����� ����̸�, �޿�, ��å�� ��� �ϼ���.
	�������ν����� : sp_salary_b
*/
desc employee;
create or replace procedure sp_salary_b(
    v_salary in employee.salary%type
)
is
    v_emp employee%rowtype;     -- ��� �÷��� �ڷ����� ����
    cursor c1
    is
    select ename,salary, job
    from employee
    where salary > v_salary;
begin
    open c1;
    loop
        fetch c1 into v_emp.ename, v_emp.salary, v_emp.job;
        exit when c1%notfound;
        dbms_output.put_line(v_emp.ename||'    '||v_emp.salary||'       '||v_emp.job);
    end loop;
    close c1;
end;
/

exec sp_salary_b(500);


/*
4. ��ǲ �Ű����� : emp_c10, dept_c10  �ΰ��� �Է� �޾� ���� employee, department ���̺��� �����ϴ� �������ν����� �����ϼ���. 
	�������ν����� : sp_copy_table
*/	

-- PL/SQL ���ο��� ���̺��� ���� : grant create table to public; <sys �������� ����>
-- ���� ���ν��� ���� �� : revoke create table from public;

create or replace procedure sp_copytable(
    v_emp in varchar2,
    v_dept in varchar2
)                           -- ���� : ';'�� ������ �ȵ�, �ڷ����� ũ�⸦ �����ϸ� �ȵ�
is
    c1 INTEGER;    -- Ŀ�� ���� ����
    v_sql1 varchar2(500);   -- ���̺� ���� ������ ���� ����
    v_sql2 varchar2(500);
begin
    v_sql1 := 'CREATE TABLE '||v_emp|| ' as select * from employee';
    v_sql2 := 'CREATE TABLE '||v_dept||' as select * from department';
    c1 := DBMS_SQL.OPEN_CURSOR;
    DBMS_SQL.PARSE(c1, v_sql1, dbms_sql.v7);
    DBMS_SQL.PARSE(c1, v_sql2, dbms_sql.v7);
    DBMS_SQL.CLOSE_CURSOR(c1);
end;
/

exec sp_copytable('emp_c10' , 'dept_c10');

select * from emp_c10;
select * from dept_c10;

/*
5. dept_c10 ���̺��� dno, dname, loc �÷��� ���� ��ǲ �޾� ��ǲ ���� ���� insert�ϴ� �������ν����� �����Ͻÿ�. 
	�Է� �� : 50  'HR'  'SEOUL'
	�Է� �� : 60  'HR2'  'PUSAN' 
*/

create or replace procedure sp_ex5 (
    v_dno in dept_c10.dno%type, v_dname in dept_c10.dname%type, v_loc in dept_c10.loc%type
)
is
begin
    insert into dept_c10
    values (v_dno, v_dname, v_loc);
    dbms_output.put_line('���������� �� �Է��� �Ǿ����ϴ�');
end;
/

exec sp_ex5(60,'HR2','PUSAN');

select * from dept_c10;


/*
6. emp_c10 ���̺��� ��� �÷��� ���� ��ǲ �޾� ��ǲ ���� ���� insert�ϴ� �������ν����� �����Ͻÿ�. 
	�Է� �� : 8000  'SONG'    'PROGRAMER'  7788  sysdate  4500  1000  50 
*/
select * from emp_c10;
create or replace procedure sp_ex6(
    v_eno in emp_c10.eno%type,
    v_ename in emp_c10.ename%type,
    v_job in emp_c10.job%type,
    v_manager in emp_c10.manager%type,
    v_hiredate in emp_c10.hiredate%type,
    v_salary in emp_c10.salary%type,
    v_commission in emp_c10.commission%type, 
    v_dno in emp_c10.dno%type
)
is
begin
    insert into emp_c10
    values (v_eno, v_ename,v_job,v_manager,v_hiredate,v_salary,v_commission,v_dno);
    dbms_output.put_line('���������� �Է��� �Ǿ����ϴ�.');
end;
/

exec sp_ex6(8000,'SONG','PROGRAMER',7788,sysdate,4500,1000,50);

/*
7. dept_c10 ���̺��� 4�������� �μ���ȣ 50�� HR �� 'PROGRAM' ���� �����ϴ� �������ν����� �����ϼ���. 
	<�μ���ȣ�� �μ����� ��ǲ�޾� �����ϵ��� �Ͻÿ�.> 
	�Է°� : 50  PROGRAMER 
*/
desc dept_c10;
select * from dept_c10;
create or replace procedure sp_Ex7(
    v_dno in dept_c10.dno%type,
    v_dname in dept_c10.dname%type
)
is
begin
    UPDATE dept_c10
    set dname = v_dname
    where dno = v_dno;
end;
/

exec sp_ex7(50,'PROGRAMER');


/*
8. emp_c10 ���̺��� �����ȣ�� ��ǲ �޾� ������ �����ϴ� ���� ���ν����� �����Ͻÿ�. 
	�Է� �� : 8000  6000
*/
select * from emp_c10;
create or replace procedure sp_ex8(
     v_eno in emp_c10.eno%type,
     v_salary in emp_c10.salary%type
)
is
begin
    update emp_c10
    set salary = v_salary
    where eno = v_eno;
end;
/

exec sp_ex8(8000,6000);

/*
9. ���� �� ���̺���� ��ǲ �޾� �� ���̺��� �����ϴ� �������ν����� ���� �Ͻÿ�. 
*/

create or replace procedure sp_ex9(
    table1 varchar2,
    table2 varchar2
)
is
    c1 integer;
    v_sql1 varchar2(500);
    v_sql2 varchar2(500);
begin
    v_sql1 := 'Drop table '||table1;
    v_sql2 := 'DROP table '||table2;
    c1 := dbms_sql.open_cursor;
    dbms_sql.parse(c1,v_sql1,dbms_sql.v7);
    dbms_sql.parse(c1,v_sql2,dbms_sql.v7);
    dbms_sql.close_cursor(c1);
end;
/

exec sp_ex9('emp_c10','dept_c10');



/*
10. ����̸��� ��ǲ �޾Ƽ� �����, �޿�, �μ���ȣ, �μ���, �μ���ġ�� OUT �Ķ���Ϳ� �Ѱ��ִ� ���ν����� PL / SQL���� ȣ��
*/
select * from employee;
select * from department;
create or replace procedure sel_empename(
    v_ename in employee.ename%type,
    v_o_ename out employee.ename%type,
    v_sal out employee.salary%type,
    v_dno out employee.dno%type,
    v_dname out department.dname%type,
    v_loc out department.loc%type
    )
is
begin
    select ename,salary,e.dno,dname,loc into v_o_ename,v_sal,v_dno,v_dname,v_loc
    from employee e, department d
    where e.dno = d.dno 
    and ename = v_ename;            -- v_ename�� �������� �ؼ�
end;
/
desc employee;
declare     -- OUT �Ķ��Ÿ ���� ���� ����
    var_ename employee.ename%type;
    var_sal employee.salary%type;
    var_dno employee.dno%type;
    var_dname department.dname%type;
    var_loc department.loc%type;
begin
    sel_empename('SMITH',var_ename,var_sal,var_dno,var_dname,var_loc);
    dbms_output.put_line('�̸��� ' ||var_ename||', �޿��� '||var_sal||', �μ���ȣ�� '||var_dno||', �μ����� '||var_dname||', �μ���ġ�� '||var_loc);
end;
/



/*
11. �����ȣ�� �޾Ƽ� �����, �޿�, ��å, �μ���, �μ���ġ�� OUT �Ķ���Ϳ� �Ѱ��ִ� ���ν����� PL / SQL���� ȣ��
    (���� ������ �����Ƿ� Ŀ�� �̿�)
*/

create or replace procedure sel_eno(
    v_eno in number,
    v_ename out varchar2,
    v_sal out number,
    v_job out varchar2,
    v_dname out varchar2,
    v_loc out varchar2
    )
is
    cursor c1
    is
    select ename,salary,job,dname,loc
    from employee e, department d
    where e.dno = d.dno 
    and eno = v_eno;
begin
    open c1;
    loop
        fetch c1 into v_ename,v_sal,v_job,v_dname,v_loc;
        exit when c1%notfound;
    end loop;
    close c1;
end;
/

declare
    var_ename varchar2(50);
    var_sal number;
    var_job varchar2(50);
    var_dname varchar2(50);
    var_loc varchar2(50);
begin
    sel_eno(7369,var_ename,var_sal,var_job,var_dname,var_loc);
    dbms_output.put_line('�����ȣ�� 7369�̰� ������� '||var_ename||', �޿��� '||var_sal||', �μ����� '||var_dname||', �μ���ġ�� '||var_loc);
end;
/

select * from employee;