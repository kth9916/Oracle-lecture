-- 9���� ������, �ε���

/*
    ������: �ڵ� ��ȣ �߻���
        -- ��ȣ�� �ڵ� �߻��Ǹ� �ǵ��� �� ����.(���� �� �ٽ� �����ؾ� �Ѵ�.)
        -- Primary Key �÷��� ��ȣ�� �ڵ����� �߻���Ű�� ���� ���
        -- Primary Key �÷��� �ߺ����� �ʴ� ������ ���� �Ű澲�� �ʾƵ� �ȴ�.
*/

-- �ʱⰪ: 10, ������: 10
create sequence sample_seq
    increment by 10         -- ������
    start with 10;           -- �ʱⰪ
    
-- �������� ������ ����ϴ� ������ ����
select * from user_sequences;

select sample_seq.nextval from dual;    -- �������� ���� ���� ���
select sample_seq.currval from dual;    -- ���� �������� ���� ���

-- �ʱⰪ: 2, ������:2
create sequence sample_seq2
increment by 2
start with 2
nocache;         -- ĳ���� ������� �ʰڴ�. (RAM) ������ ���ϸ� �ٿ��� �� �ִ�.

select sample_seq2.nextval from dual;
select sample_seq2.currval from dual;


-- �������� Primary Key�� �����ϱ�
create table dept_copy80
as
select * from department
where 0=1;

select * from dept_copy80;

-- ������ ����: �ʱⰪ 10 ,������ 10
create sequence dept_seq
increment by 10
start with 10
nocache;

/* Sequence�� cache�� ��� �ϴ�/�����ʴ� ���
    -- cache : ������ ������ ����ϱ� ���� ��� (�⺻��: 20��)
    -- ������ �ٿ�� ��� ĳ���� �ѹ����� ��� ���ư���. ���ο� ���� �Ҵ� �޴´�.
*/

insert into dept_copy80(dno, dname, loc)
values(dept_seq.nextval, 'HR','SEOUL');
commit;

select * from dept_copy80;

-- ������ ����
create sequence emp_seq_no
increment by 1
start with 1
nocache;

create table emp_copy80
as
select * from employee
where 1 = 0;

select * from emp_copy80;

-- �������� ���̺��� Ư�� �÷��� ����
insert into emp_copy80
values(emp_seq_no.nextval, 'SMITH', 'SALESMAN', 2222, sysdate, 3000, 300, 20 );



-- ������ ������ ����
select * from user_sequences;

alter sequence emp_seq_no
maxvalue 1000;       -- �ִ�

alter sequence emp_seq_no
cycle;       -- �ִ��� ����ǰ� �ٽ� ó������ ��ȯ

alter sequence emp_seq_no
nocycle;   

select * from user_sequences;

drop sequence sample_seq;


/*
    INDEX: ���̺��� �÷��� ����, Ư�� �÷��� �˻��� ������ ����� �� �ֵ��� �Ѵ�. 
        - INDEX Page: �÷��� �߿� Ű���带 �ɷ��� ��ġ ������ ��Ƴ��� �������� index page�� �Ѵ�.
            - DB ������ 10%
        - ����(index): ������ �߿� Ű���带 �����ؼ� ��ġ�� �˷���
        - ���̺� ��ĵ: ���ڵ��� ó������ ���������� �˻�(�˻� �ӵ��� ������.) �ε����� ������� ����
            - Index�� �����Ǿ� ���� ���� �÷��� ���̺� ��ĵ�� �Ѵ�.
        
        - Primary Key, Unique Ű�� ����� �÷��� index page�� �����Ǿ� �˻��� ������ �Ѵ�.
        - where ������ ���� �˻��� �ϴ� �÷��� index�� ����
        - ���̺� �˻��� ���� �ϴ� �÷��� index����, ���̺� ��ĵ�� ���� �ʰ� index page�� �˻��ؼ� ��ġ�� ������ ã�´�.
        - Index�� ������ �� ���ϰ� ���� �ɸ���. ���� �����ð��� ���ؼ� �����.
        
*/

-- index ������ ����Ǿ� �ִ� ������ ����
    -- user_columns, user_ind_columns

select * from user_tab_columns;
select * from user_ind_columns;

select * from user_tab_columns
where table_name in('EMPLOYEE','DEPARTMENT');

select index_name, table_name, column_name
from user_ind_columns
where table_name in('EMPLOYEE','DEPARTMENT');

select * from employee;     -- ENO �÷��� Primary Key < �ڵ����� Index�� ������.


/*
    index �ڵ� ����, (Primary Key, Unique)
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
where ename = 'KING';       -- ename �÷��� index�� �����Ƿ� KING�� �˻��ϱ� ���� ���̺� ��ĵ


select * from emp_copy90
where job = 'SALESMAN';


-- ename �÷��� index �����ϱ� (���� �߰��� �۾�, ���ϰ� ���� �ɸ���.)

-- �÷��� index�� �����Ǿ� ���� ������ ���̺� ��ĵ
-- �÷��� index�� �����Ǿ� ������ index page�� �˻��Ѵ�.
create index id_emp_ename
on emp_copy90(ename);

drop index id_emp_ename;



/*
    index�� �ֱ������� REBUILD ����� �Ѵ�. 
    index page�� insert, update, delete�� ����� �Ͼ�� ��������
*/

-- index rebuild�� �ؾ� �ϴ� ���� ���: INDEX�� tree ���̰� 4�̻��� ��찡 ��ȸ�Ǹ� rebuild�� �ʿ䰡 �ִ�.

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

alter index id_emp_ename rebuild;   -- index�� ���Ӱ� ����

select * from emp_copy90;

/*
    index�� ����ؾ� �ϴ� ���
        1. ���̺��� ��(�ο�, ���ڵ�)�� ������ ���� ���
        2. where ������ ���� ���Ǵ� �÷�
        3. join�� ���Ǵ� Ű �÷�
        4. �˻� ����� ���� ���̺� �������� 2~4 % �Ǵ� ���
        5. �ش� �÷��� null�� ���ԵǴ� ��� (������ null ������)
        
    index�� ������� �ʾƵ� �Ǵ� ���
        1. ���̺� ���� ������ ���� ���
        2. �˻� ����� ���� ���̺��� ���� ������ �����ϴ� ���
        3. insert, update, delete�� ����ϰ� �Ͼ�� �÷�


    index ����
        1. ���� �ε��� (Unique Index) : �÷��� �ߺ����� �ʴ� ������ ���� ���� index(Primary Key, Unique)
        2. ���� �ε��� (Single Index) : �� �÷��� �ο��Ǵ� index
        3. ���� �ε��� (Composite Index) : ���� �÷��� ��� ������ index
        4. �Լ� �ε��� (Function Base Index) : �Լ��� ������ �÷��� ������ index

*/


select * from emp_copy90;

-- ���� �ε��� ����
create index inx_emp_copy90_salary
on emp_copy90(salary);

-- ���� �ε��� ����: �� �� �̻��� �÷��� �����Ͽ� �ε��� ����
create table dept_copy91
as
select * from department;

create index idx_dept_copy90_dname_loc
on dept_copy91 (dname, loc);


select index_name, table_name, column_name
from user_ind_columns
where table_name in('DEPT_COPY91');


-- �Լ� ��� �ε���: �Լ��� ������ �÷��� �ο��Ǵ� index
create table emp_copy91
as
select * from employee;

create index idx_emp_copy91_allsal
on emp_copy91 (salary * 12);        -- �÷��� �Լ�, ������ ������ index



/*�ε��� ����*/
drop index idx_emp_copy91_allsal;







/*���� ����*/
/*
    ��� ����: DBMS�� ���� ���� ���
        - �� ����ں��� ������ ����: DBMS�� ������ �� �ִ� ����ڸ� ����
         ���� (Authentication : Credential(Identity + Password) Ȯ��)
         �㰡 (Authorization : ������ ����ڿ��� Oracle�� �ý��� ����, ��ü(���̺�, ��, Ʈ����, �Լ�) ����
                - System Privileges : Oracle�� �������� ����, ���̺� �����̽� ������ �������� ����
                - Object Privileges : ��ü(���̺�, ��, Ʈ����, �Լ�, �������ν���, ������, �ε���) ���� ����
*/



-- Oracle���� ���� ����. (�Ϲ� ���������� ������ ������ �� �ִ� ������ ����.)
-- �ְ� ������ ���� (sys) : ������ ������ �� �ִ� ������ ������ �ִ�.
-- ���̵�: usertest01, ��ȣ: 1234
show user;
create user usertest01 identified by 1234;

-- ������ ��ȣ�� �����ϰ� Oracle�� ������ �� �ִ� ������ �޾ƾ� �Ѵ�.

-- System Privileges
    -- Create Session : Oracle�� ������ �� �ִ� ����
    -- Create Table : Oracle���� ���̺��� ������ �� �ִ� ����
    -- Create Sequence : Oracle���� �������� ������ �� �ִ� ����
    -- Create View : Oracle���� �並 ������ �� �ִ� ����
    


/*  ���ڱ� ����
    DDL: ��ü ����(Create, Alter, drop)
    DML: ���ڵ� ����(Insert, Update, Delete)
    DQL: ���ڵ� �˻�(Select
    DTL: Ʈ�����(Begin transaction, rollback, commit)
    DCL: ���Ѱ���(Grant, Revoke, Deny)
*/


-- ������ ������ Oracle ���� ������ Create Session ���� �ο�
-- grant �ο��� ���� to ������
grant create session to usertest01; -- sys���� ���� 

grant create table to usertest01;

/*���̺� �����̽�(table space)
    : ��ü(���̺�, ��, ������, �ε���, Ʈ����, �������ν���, �Լ�...)�� �����ϴ� ����
    ������ �������� �� ����ں� ���̺� �����̽��� Ȯ���� �� �ִ�.
*/
select * from dba_users;

select username, default_tablespace as DataFile, temporary_tablespace as LogFile
from dba_users
where username in ('HR','USERTEST01');

-- ���� ���̺� �����̽� ���� (SYSTEM --> USERS) 
alter user usertest01
default tablespace users
temporary tablespace temp;

-- USERS ���̺� �����̽��� ����� �� �ִ� ���� �Ҵ�(users ���̺� �����̽��� 2mb ��� ���� �Ҵ�)
alter user usertest01
quota 2m on users;

select * from all_tables        -- ���̺��� �����ָ� ������ش�. �������� ������ ���̺��� ����� �� �ִ�.
where owner in ('HR','USERTEST01','USERTEST02');





-- Object Privileges: ���̺�, ��, Ʈ����, �Լ�, �������ν���, ������, �ε����� �ο��Ǵ� ����
/*
    ����      Table   view    SEQUENCE    PROCEDURE
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


-- Ư�� ���̺� select ���� �ο��ϱ�
-- Authentication(����) : credential (ID+PW)
create user user_test10 identified by 1234;    -- ���� ����

-- Authorization(�㰡) : system ���� �Ҵ�
grant create session, create table, create view to user_test10;

-- ������ �����ϸ� system ���̺� �����̽��� ����Ѵ�. <== �����ڸ� ��밡���� ���̺� �����̽�
-- ���̺� �����̽� �ٲٱ�. (USERS)
alter user user_test10
default tablespace "USERS"
temporary tablespace "TEMP";

-- ���̺� �����̽� �뷮 �Ҵ�
ALTER USER "USER_TEST10" QUOTA UNLIMITED ON "USERS";


-- Ư�� �������� ��ü�� �����ϸ� �� ������ ��ü�� �����ϰ� �ȴ�.
select * from dba_tables
where owner in ('HR','USER_TEST10');


-- �ٸ� ������� ���̺��� �����Ϸ��� ������ ������ �Ѵ�.
-- user_test10���� HR�� �������� employee ���̺��� ���� �� �� ���� ���� �ʿ�

select * from employee;
-- ��ü ��� �� ��ü�� �տ� �����ָ��� �־���� �Ѵ�.
-- �ڽ��� ���̺��� ���� ��������
select * from hr.employee;


grant select on hr.employee to user_test10;     --���� �ο�


-- �⺻������ �ڽ��� ��ü�� ����� �� ���� ����
select * from test10Tbl;

-- �ٸ� ������� ��ü�� ������ ���� �����ָ�. ��ü��
select * from user_test10.test10Tbl;
select * from employee;     -- �����ָ� (user_test10)�� ��ü�� �������� �߱� ������ ����
select * from hr.employee;  -- �ٸ� ������� ��ü�� ������ �� ���� �ʿ�


-- grant ��ü�� ���� on ��ü�� to ����ڸ�;

grant insert, update, delete on hr.emp_copy55 to user_test10;
-- �ٸ� ����� ���̺��� insert ����
desc hr.employee;

select * from hr.emp_copy55;

-- insert 

insert into hr.emp_copy55(eno)
values(3333);


-- ���� ����
revoke insert, update, delete on hr.emp_copy55 from user_test10;


/* with grant option : Ư�� �������� ������ �ο��ϸ鼭 �ش� ������ �ٸ� ����ڿ��Ե� �ο��� �� ���� */
    -- �ο� ���� ������ �ٸ� ����ڿ��� �ο��� �� �� ����
grant select on hr.employee to user_test10 with grant option;
    -- user_test10 ������ hr.employee ���̺� ���ؼ� �ٸ� ����ڿ��� select ������ �ο��� �� �ִ�.

-- with grant option�� �ο� ���� USER_TEST10����
grant select on hr.employee to user_test11;
-- �� �����ϴ�.



grant select on hr.dept_copy55 to user_test10;

-- HR����
create table dept_copy55
as
select * from department;


/*
    public : ��� ����ڿ��� ������ �ο�
*/
grant select, insert, update, delete on hr.emp_copy56 to public;

/*
    ��(Role) : ���� ����ϴ� �������� ������ ���� ���� ��
    
    1. dba: �ý����� ��� ������ ����� role, sys(�ְ������ ����)
    2. connect: 
    3. resource: 
*/

-- ����� ���� role ����: ���� ����ϴ� ���ѵ��� ��� role�� ����
-- 1. �� ����:
create role roletest1;

-- 2. �ѿ� ���ֻ���ϴ� ������ ����
grant create session, create table, create view, create sequence, create trigger
to roletest1;

-- 3. ������ ���� �������� ����
grant roletest1 to user_test10;


/*���� ����ڿ��� �ο��� �� Ȯ��*/
select * from user_role_privs;

/*�ѿ� �ο��� ���� ���� Ȯ��
    �� -> �ý��� ����
*/
select * from role_sys_privs
where role like 'DBA';

select * from role_sys_privs
where role like 'ROLETEST1';

/*��ü ������ role�� �ο��ϱ�*/
create role roletest2;

grant select on hr.employee to roletest2;
