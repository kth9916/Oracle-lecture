show user;

-- �ְ� ������ ���� (sys) : ������ ������ �� �ִ� ������ ������ �ִ�.
-- ���̵� : usertest01, ��ȣ : 1234
Create user usertest01 identified by 1234;

-- ������ ��ȣ�� �����ߴٰ� �ؼ� ����Ŭ�� ������ �� �ִ� ������ �ο� �޾ƾ� ���� ����

-- System Privileges : 
    -- Create Session : ����Ŭ�� ������ �� �ִ� ����
    -- Create table : ����Ŭ���� ���̺��� ������ �� �ִ� ����.
    -- Create Sequence : ������ ������ �� �ִ� ����
    -- Create view : �並 ������ �� �ִ� ����

-- ������ �������� ����Ŭ�� ������ �� �ִ� Create Session ������ �ο�

DDL : ��ü ���� (Create, Alter, Drop)
DML : ���ڵ� ���� (Insert, update, delete)
DQL : ���ڵ� �˻� (select)
DTL : Ʈ������(Begin Transaction, rollback, commit)
DCL : ���Ѱ��� (Grant, Revoke, Deny)

-- ������ �������� ����Ŭ�� ������ �� �ִ� Create Session ������ �ο�
-- grant �ο��� ���� to ������
grant create session to usertest01;

-- ����Ŭ�� �����ߴٶ���ؼ� ���̺� ������ �� �ִ� ������ ����.
grant create table to usertest01;

/*
    ���̺� �����̽� (Table Space) : ��ü (���̺�, ��, ������, �ε���, Ʈ����, �������ν���, �Լ�...)
    �� �����ϴ� ����. ������ �������� �� ����ں� ���̺� �����̽��� Ȯ��. 
*/

select * from dba_users;        -- dba_ : sys (�ְ� ������ �������� Ȯ��)

select username, default_tablespace as datafile, temporary_tablespace as logfile
from dba_users
where username in ('HR','USERTEST01');

-- �������� ���̺� �����̽� ���� (System ==> Users) ����
alter user usertest01
default tablespace users
temporary tablespace temp;

-- �������� Users ���̺� �����̽��� ����� �� �ִ� ���� �Ҵ�(users ���̺� �����̽��� 2mb�� ��� �����Ҵ�)
alter user usertest01
quota 2m on users;

==========================================
���� : Usertest02 ������ ���� �Ŀ� users ���̺� �����̽����� ���̺� (tbl2) ���� �� insert

create user usertest02 identified by 1234;

grant create session, create table to usertest02;

alter user usertest02
default tablespace users
temporary tablespace temp;

select default_tablespace
from dba_users
where username in ('HR','USERTEST02');

alter user usertest02
quota 100m on users;

select * from all_tables        -- ���̺��� �����ָ� ����� �ش�. �������� ������ ���̺��� ��� �� �� �ִ�.
where owner in ('HR','USERTEST01','USERTEST02');