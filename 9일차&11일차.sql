-- 9일차 시퀀스, 인덱스

/*
    시퀀스: 자동 번호 발생기
        -- 번호가 자동 발생되면 되돌릴 수 없다.(삭제 후 다시 생성해야 한다.)
        -- Primary Key 컬럼에 번호를 자동으로 발생시키기 위해 사용
        -- Primary Key 컬럼은 중복되지 않는 고유한 값을 신경쓰지 않아도 된다.
*/

-- 초기값: 10, 증가값: 10
create sequence sample_seq
    increment by 10         -- 증가값
    start with 10;           -- 초기값
    
-- 시퀀스의 정보를 출력하는 데이터 사전
select * from user_sequences;

select sample_seq.nextval from dual;    -- 시퀀스의 다음 값을 출력
select sample_seq.currval from dual;    -- 현재 시퀀스의 값을 출력

-- 초기값: 2, 증가값:2
create sequence sample_seq2
increment by 2
start with 2
nocache;         -- 캐쉬를 사용하지 않겠다. (RAM) 서버의 부하를 줄여줄 수 있다.

select sample_seq2.nextval from dual;
select sample_seq2.currval from dual;


-- 시퀀스를 Primary Key에 적용하기
create table dept_copy80
as
select * from department
where 0=1;

select * from dept_copy80;

-- 시퀀스 생성: 초기값 10 ,증가값 10
create sequence dept_seq
increment by 10
start with 10
nocache;

/* Sequence에 cache를 사용 하는/하지않는 경우
    -- cache : 서버의 성능을 향상하기 위해 사용 (기본값: 20개)
    -- 서버가 다운된 경우 캐쉬된 넘버링이 모두 날아간다. 새로운 값을 할당 받는다.
*/

insert into dept_copy80(dno, dname, loc)
values(dept_seq.nextval, 'HR','SEOUL');
commit;

select * from dept_copy80;

-- 시퀀스 생성
create sequence emp_seq_no
increment by 1
start with 1
nocache;

create table emp_copy80
as
select * from employee
where 1 = 0;

select * from emp_copy80;

-- 시퀀스를 테이블의 특정 컬럼에 적용
insert into emp_copy80
values(emp_seq_no.nextval, 'SMITH', 'SALESMAN', 2222, sysdate, 3000, 300, 20 );



-- 기존의 시퀀스 수정
select * from user_sequences;

alter sequence emp_seq_no
maxvalue 1000;       -- 최댓값

alter sequence emp_seq_no
cycle;       -- 최댓값이 적용되고 다시 처음부터 순환

alter sequence emp_seq_no
nocycle;   

select * from user_sequences;

drop sequence sample_seq;


/*
    INDEX: 테이블의 컬럼에 생성, 특정 컬럼의 검색을 빠르게 사용할 수 있도록 한다. 
        - INDEX Page: 컬럼의 중요 키워드를 걸러서 위치 정보를 담아놓은 페이지를 index page라 한다.
            - DB 공간의 10%
        - 색인(index): 내용의 중요 키워드를 수집해서 위치를 알려줌
        - 테이블 스캔: 레코드의 처음부터 마지막까지 검색(검색 속도가 느리다.) 인덱스를 사용하지 않음
            - Index가 생성되어 있지 않은 컬럼은 테이블 스캔을 한다.
        
        - Primary Key, Unique 키가 적용된 컬럼은 index page가 생성되어 검색을 빠르게 한다.
        - where 절에서 자주 검색을 하는 컬럼에 index를 생성
        - 테이블 검색을 자주 하는 컬럼에 index생성, 테이블 스캔을 하지 않고 index page를 검색해서 위치를 빠르게 찾는다.
        - Index를 생성할 때 부하가 많이 걸린다. 보통 업무시간을 피해서 만든다.
        
*/

-- index 정보가 저장되어 있는 데이터 사전
    -- user_columns, user_ind_columns

select * from user_tab_columns;
select * from user_ind_columns;

select * from user_tab_columns
where table_name in('EMPLOYEE','DEPARTMENT');

select index_name, table_name, column_name
from user_ind_columns
where table_name in('EMPLOYEE','DEPARTMENT');

select * from employee;     -- ENO 컬럼에 Primary Key < 자동으로 Index가 생성됨.


/*
    index 자동 생성, (Primary Key, Unique)
*/

create table tb11(
    a number(4) constraint PK_tb11_a Primary Key,
    b number(4),
    c number(4)
);

select index_name, table_name, column_name
from user_ind_columns
where table_name in ('TB11','EMPLOYEE','DEPARTMENT');

select * from tb11;

create table tb12(
    a number(4) constraint PK_tb12_a Primary Key,
    b number(4) constraint UK_tb12_b Unique,
    c number(4) constraint UK_tb12_c Unique,
    d number(4),
    e number(4)
);



create table emp_copy90
as
select* from employee;

select * from emp_copy90;

select index_name, table_name, column_name
from user_ind_columns
where table_name in('EMP_COPY90');

select * from emp_copy90
where ename = 'KING';       -- ename 컬럼에 index가 없으므로 KING을 검색하기 위해 테이블 스캔


select * from emp_copy90
where job = 'SALESMAN';


-- ename 컬럼에 index 생성하기 (보통 야간에 작업, 부하가 많이 걸린다.)

-- 컬럼에 index가 생성되어 있지 않으면 테이블 스캔
-- 컬럼에 index가 생성되어 있으면 index page를 검색한다.
create index id_emp_ename
on emp_copy90(ename);

drop index id_emp_ename;



/*
    index는 주기적으로 REBUILD 해줘야 한다. 
    index page는 insert, update, delete가 빈번히 일어나면 조각난다
*/

-- index rebuild를 해야 하는 정보 얻기: INDEX의 tree 깊이가 4이상인 경우가 조회되면 rebuild의 필요가 있다.

SELECT I.TABLESPACE_NAME,I.TABLE_NAME,I.INDEX_NAME, I.BLEVEL,
       DECODE(SIGN(NVL(I.BLEVEL,99)-3),1,DECODE(NVL(I.BLEVEL,99),99,'?','Rebuild'),'Check') CNF
FROM   USER_INDEXES I
WHERE   I.BLEVEL > 4
ORDER BY I.BLEVEL DESC;

SELECT I.TABLESPACE_NAME,I.TABLE_NAME,I.INDEX_NAME, I.BLEVEL,
       DECODE(SIGN(NVL(I.BLEVEL,99)-3),1,DECODE(NVL(I.BLEVEL,99),99,'?','Rebuild'),'Check') CNF
FROM   USER_INDEXES I
WHERE   I.BLEVEL > 4
ORDER BY I.BLEVEL DESC;


-- index rebuild : 

alter index id_emp_ename rebuild;   -- index를 새롭게 생성

select * from emp_copy90;

/*
    index를 사용해야 하는 경우
        1. 테이블의 행(로우, 레코드)의 개수가 많은 경우
        2. where 절에서 자주 사용되는 컬럼
        3. join시 사용되는 키 컬럼
        4. 검색 결과가 원본 테이블 데이터의 2~4 % 되는 경우
        5. 해당 컬럼에 null이 포함되는 경우 (색인은 null 제외함)
        
    index를 사용하지 않아도 되는 경우
        1. 테이블 행의 개수가 적은 경우
        2. 검색 결과가 원본 테이블의 많은 비중을 차지하는 경우
        3. insert, update, delete가 빈번하게 일어나는 컬럼


    index 종류
        1. 고유 인덱스 (Unique Index) : 컬럼의 중복되지 않는 고유한 값을 갖는 index(Primary Key, Unique)
        2. 단일 인덱스 (Single Index) : 한 컬럼에 부여되는 index
        3. 결합 인덱스 (Composite Index) : 여러 컬럼을 묶어서 생성한 index
        4. 함수 인덱스 (Function Base Index) : 함수를 적용한 컬럼에 생성한 index

*/


select * from emp_copy90;

-- 단일 인덱스 생성
create index inx_emp_copy90_salary
on emp_copy90(salary);

-- 결합 인덱스 생성: 두 개 이상의 컬럼을 결합하여 인덱스 생성
create table dept_copy91
as
select * from department;

create index idx_dept_copy90_dname_loc
on dept_copy91 (dname, loc);


select index_name, table_name, column_name
from user_ind_columns
where table_name in('DEPT_COPY91');


-- 함수 기반 인덱스: 함수를 적용한 컬럼에 부여되는 index
create table emp_copy91
as
select * from employee;

create index idx_emp_copy91_allsal
on emp_copy91 (salary * 12);        -- 컬럼에 함수, 계산식을 적용한 index



/*인덱스 삭제*/
drop index idx_emp_copy91_allsal;







/*권한 관리*/
/*
    사용 권한: DBMS는 여러 명이 사용
        - 각 사용자별로 계정을 생성: DBMS에 접속할 수 있는 사용자를 생성
         인증 (Authentication : Credential(Identity + Password) 확인)
         허가 (Authorization : 인증된 사용자에게 Oracle의 시스템 권한, 객체(테이블, 뷰, 트리거, 함수) 권한
                - System Privileges : Oracle의 전반적인 권한, 테이블 스페이스 내에서 전반적인 권한
                - Object Privileges : 객체(테이블, 뷰, 트리거, 함수, 저장프로시저, 시퀀스, 인덱스) 접근 권한
*/



-- Oracle에서 계정 생성. (일반 계정에서는 계정을 생성할 수 있는 권한이 없다.)
-- 최고 관리자 계정 (sys) : 계정을 생성할 수 있는 권한을 가지고 있다.
-- 아이디: usertest01, 암호: 1234
show user;
create user usertest01 identified by 1234;

-- 계정과 암호를 생성하고 Oracle에 접속할 수 있는 권한을 받아야 한다.

-- System Privileges
    -- Create Session : Oracle에 접속할 수 있는 권한
    -- Create Table : Oracle에서 테이블을 생성할 수 있는 권한
    -- Create Sequence : Oracle에서 시퀀스를 생성할 수 있는 권한
    -- Create View : Oracle에서 뷰를 생성할 수 있는 권한
    


/*  갑자기 정리
    DDL: 객체 생성(Create, Alter, drop)
    DML: 레코드 조작(Insert, Update, Delete)
    DQL: 레코드 검색(Select
    DTL: 트랜잭션(Begin transaction, rollback, commit)
    DCL: 권한관리(Grant, Revoke, Deny)
*/


-- 생성한 계정에 Oracle 접속 가능한 Create Session 권한 부여
-- grant 부여할 권한 to 계정명
grant create session to usertest01; -- sys에서 실행 

grant create table to usertest01;

/*테이블 스페이스(table space)
    : 객체(테이블, 뷰, 시퀀스, 인덱스, 트리거, 저장프로시저, 함수...)를 저장하는 공간
    관리자 계정에서 각 사용자별 테이블 스페이스를 확인할 수 있다.
*/
select * from dba_users;

select username, default_tablespace as DataFile, temporary_tablespace as LogFile
from dba_users
where username in ('HR','USERTEST01');

-- 계정 테이블 스페이스 변경 (SYSTEM --> USERS) 
alter user usertest01
default tablespace users
temporary tablespace temp;

-- USERS 테이블 스페이스를 사용할 수 있는 공간 할당(users 테이블 스페이스에 2mb 사용 공간 할당)
alter user usertest01
quota 2m on users;

select * from all_tables        -- 테이블의 소유주를 출력해준다. 계정별로 소유한 테이블을 출력할 수 있다.
where owner in ('HR','USERTEST01','USERTEST02');





-- Object Privileges: 테이블, 뷰, 트리거, 함수, 저장프로시져, 시퀀스, 인덱스에 부여되는 권한
/*
    권한      Table   view    SEQUENCE    PROCEDURE
    -------------------------------------------
    Alter       0               0
    DELETE      0       0       
    EXECUTE                              0
    INDEX       0       
    INSERT      0       0       
    REFERENCE   0
    SELECT      0       0       0
    UPDATE      0       0       
*/


-- 특정 테이블에 select 권한 부여하기
-- Authentication(인증) : credential (ID+PW)
create user user_test10 identified by 1234;    -- 계정 생성

-- Authorization(허가) : system 권한 할당
grant create session, create table, create view to user_test10;

-- 계정을 생성하면 system 테이블 스페이스를 사용한다. <== 관리자만 사용가능한 테이블 스페이스
-- 테이블 스페이스 바꾸기. (USERS)
alter user user_test10
default tablespace "USERS"
temporary tablespace "TEMP";

-- 테이블 스페이스 용량 할당
ALTER USER "USER_TEST10" QUOTA UNLIMITED ON "USERS";


-- 특정 계정에서 객체를 생성하면 그 계정이 객체를 소유하게 된다.
select * from dba_tables
where owner in ('HR','USER_TEST10');


-- 다른 사용자의 테이블을 접근하려면 권한을 가져야 한다.
-- user_test10에서 HR이 소유주인 employee 테이블을 접글 할 때 접근 권한 필요

select * from employee;
-- 객체 출력 시 객체명 앞에 소유주명을 넣어줘야 한다.
-- 자신의 테이블일 경우는 생략가능
select * from hr.employee;


grant select on hr.employee to user_test10;     --권한 부여


-- 기본적으로 자신의 객체를 출력할 때 생략 가능
select * from test10Tbl;

-- 다른 사용자의 객체를 접근할 때는 소유주명. 객체명
select * from user_test10.test10Tbl;
select * from employee;     -- 소유주명 (user_test10)의 객체를 가져오라 했기 때문에 오류
select * from hr.employee;  -- 다른 사용자의 객체를 접근할 때 권한 필요


-- grant 객체의 권한 on 객체명 to 사용자명;

grant insert, update, delete on hr.emp_copy55 to user_test10;
-- 다른 사용자 테이블에서 insert 권한
desc hr.employee;

select * from hr.emp_copy55;

-- insert 

insert into hr.emp_copy55(eno)
values(3333);


-- 권한 삭제
revoke insert, update, delete on hr.emp_copy55 from user_test10;


/* with grant option : 특정 계정에게 권한을 부여하면서 해당 권한을 다른 사용자에게도 부여할 수 있음 */
    -- 부여 받은 권한을 다른 사용자에게 부여해 줄 수 있음
grant select on hr.employee to user_test10 with grant option;
    -- user_test10 계정은 hr.employee 테이블에 대해서 다른 사용자에게 select 권한을 부여할 수 있다.

-- with grant option을 부여 받은 USER_TEST10에서
grant select on hr.employee to user_test11;
-- 이 가능하다.



grant select on hr.dept_copy55 to user_test10;

-- HR에서
create table dept_copy55
as
select * from department;


/*
    public : 모든 사용자에게 권한을 부여
*/
grant select, insert, update, delete on hr.emp_copy56 to public;

/*
    롤(Role) : 자주 사용하는 여러개의 권한을 묶어 놓은 것
    
    1. dba: 시스템의 모든 권한이 적용된 role, sys(최고관리자 권한)
    2. connect: 
    3. resource: 
*/

-- 사용자 정의 role 생성: 자주 사용하는 권한들을 묶어서 role을 생성
-- 1. 롤 생성:
create role roletest1;

-- 2. 롤에 자주사용하는 권한을 적용
grant create session, create table, create view, create sequence, create trigger
to roletest1;

-- 3. 생성된 롤을 계정에게 적용
grant roletest1 to user_test10;


/*현재 사용자에게 부여된 롤 확인*/
select * from user_role_privs;

/*롤에 부여된 권한 정보 확인
    롤 -> 시스템 권한
*/
select * from role_sys_privs
where role like 'DBA';

select * from role_sys_privs
where role like 'ROLETEST1';

/*객체 권한을 role에 부여하기*/
create role roletest2;

grant select on hr.employee to roletest2;
