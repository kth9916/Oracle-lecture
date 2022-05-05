-- 저장 프로시져 문제 

/*
1. 각 부서별로 최소급여, 최대급여, 평균급여를 출력하는 저장프로시져를 생성하시오. 
	[employee, department ] 테이블 이용
*/

set serveroutput on

create or replace procedure sp_salary
is      -- 변수 선언부, 커서 선언
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
        exit when c2%notfound;      -- 레코드의 값이 더 이상 존재하지 않을 때
        dbms_output.put_line('부서번호는 ' || v_dno||'이고 '|| v_min||'은 최소값이고 '||v_max||'은 최대값이다. '||v_avg ||'은 평균값이다.');
    end loop;
    close c2;
end;
/
select * from user_source
where name = 'SP_SALARY';
exec SP_SALARY; 


/*
2.  사원번호, 사원이름, 부서명, 부서위치를 출력하는 저장프로시져를 생성하시오.  
	[employee, department ] 테이블 이용
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
3. 급여를 입력 받아  입력받은 급여보다 높은 사원의 사원이름, 급여, 직책을 출력 하세요.
	저장프로시져명 : sp_salary_b
*/
desc employee;
create or replace procedure sp_salary_b(
    v_salary in employee.salary%type
)
is
    v_emp employee%rowtype;     -- 모든 컬럼의 자료형을 선언
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
4. 인풋 매개변수 : emp_c10, dept_c10  두개를 입력 받아 각각 employee, department 테이블을 복사하는 저장프로시져를 생성하세요. 
	저장프로시져명 : sp_copy_table
*/	

-- PL/SQL 내부에서 테이블을 생성 : grant create table to public; <sys 계정으로 접속>
-- 저장 프로시저 실행 후 : revoke create table from public;

create or replace procedure sp_copytable(
    v_emp in varchar2,
    v_dept in varchar2
)                           -- 주의 : ';'을 넣으면 안됨, 자료형의 크기를 지정하면 안됨
is
    c1 INTEGER;    -- 커서 변수 선언
    v_sql1 varchar2(500);   -- 테이블 생성 쿼리를 담을 변수
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
5. dept_c10 테이블에서 dno, dname, loc 컬럼의 값을 인풋 받아 인풋 받은 값을 insert하는 저장프로시져를 생성하시요. 
	입력 값 : 50  'HR'  'SEOUL'
	입력 값 : 60  'HR2'  'PUSAN' 
*/

create or replace procedure sp_ex5 (
    v_dno in dept_c10.dno%type, v_dname in dept_c10.dname%type, v_loc in dept_c10.loc%type
)
is
begin
    insert into dept_c10
    values (v_dno, v_dname, v_loc);
    dbms_output.put_line('정상적으로 잘 입력이 되었습니다');
end;
/

exec sp_ex5(60,'HR2','PUSAN');

select * from dept_c10;


/*
6. emp_c10 테이블에서 모든 컬럼의 값을 인풋 받아 인풋 받은 값을 insert하는 저장프로시져를 생성하시요. 
	입력 값 : 8000  'SONG'    'PROGRAMER'  7788  sysdate  4500  1000  50 
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
    dbms_output.put_line('정상적으로 입력이 되었습니다.');
end;
/

exec sp_ex6(8000,'SONG','PROGRAMER',7788,sysdate,4500,1000,50);

/*
7. dept_c10 테이블에서 4번문항의 부서번호 50의 HR 을 'PROGRAM' 으로 수정하는 저장프로시져를 생성하세요. 
	<부서번호와 부서명을 인풋받아 수정하도록 하시오.> 
	입력갑 : 50  PROGRAMER 
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
8. emp_c10 테이블에서 사원번호를 인풋 받아 월급을 수정하는 저장 프로시져를 생성하시오. 
	입력 값 : 8000  6000
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
9. 위의 두 테이블명을 인풋 받아 두 테이블을 삭제하는 저장프로시져를 생성 하시오. 
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
10. 사원이름을 인풋 받아서 사원명, 급여, 부서번호, 부서명, 부서위치을 OUT 파라미터에 넘겨주는 프로시저를 PL / SQL에서 호출
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
    and ename = v_ename;            -- v_ename을 조건으로 해서
end;
/
desc employee;
declare     -- OUT 파라메타 받을 변수 선언
    var_ename employee.ename%type;
    var_sal employee.salary%type;
    var_dno employee.dno%type;
    var_dname department.dname%type;
    var_loc department.loc%type;
begin
    sel_empename('SMITH',var_ename,var_sal,var_dno,var_dname,var_loc);
    dbms_output.put_line('이름은 ' ||var_ename||', 급여는 '||var_sal||', 부서번호는 '||var_dno||', 부서명은 '||var_dname||', 부서위치는 '||var_loc);
end;
/



/*
11. 사원번호를 받아서 사원명, 급여, 직책, 부서명, 부서위치을 OUT 파라미터에 넘겨주는 프로시저를 PL / SQL에서 호출
    (값이 여러개 나오므로 커서 이용)
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
    dbms_output.put_line('사원번호는 7369이고 사원명은 '||var_ename||', 급여는 '||var_sal||', 부서명은 '||var_dname||', 부서위치는 '||var_loc);
end;
/

select * from employee;