show user;

-- 최고 관리자 계정 (sys) : 계정을 생성할 수 있는 권한을 가지고 있다.
-- 아이디 : usertest01, 암호 : 1234
Create user usertest01 identified by 1234;

-- 계정과 암호를 생성했다고 해서 오라클에 접속할 수 있는 권한을 부여 받아야 접속 가능

-- System Privileges : 
    -- Create Session : 오라클에 접속할 수 있는 권한
    -- Create table : 오라클에서 테이블을 생성할 수 있는 권한.
    -- Create Sequence : 시퀀스 생성할 수 있는 권한
    -- Create view : 뷰를 생성할 수 있는 권한

-- 생성한 계정에게 오라클에 접속할 수 있는 Create Session 권한을 부여

DDL : 객체 생성 (Create, Alter, Drop)
DML : 레코드 조작 (Insert, update, delete)
DQL : 레코드 검색 (select)
DTL : 트랜젝션(Begin Transaction, rollback, commit)
DCL : 권한관리 (Grant, Revoke, Deny)

-- 생성한 계정에게 오라클에 접속할 수 있는 Create Session 권한을 부여
-- grant 부여할 권한 to 게정명
grant create session to usertest01;

-- 오라클에 접속했다라고해서 테이블에 접속할 수 있는 권한이 없다.
grant create table to usertest01;

/*
    테이블 스페이스 (Table Space) : 객체 (테이블, 뷰, 시퀀스, 인덱스, 트리거, 저장프로시져, 함수...)
    를 저장하는 공간. 관리자 계정에서 각 사용자별 테이블 스페이스를 확인. 
*/

select * from dba_users;        -- dba_ : sys (최고 관리자 계정에서 확인)

select username, default_tablespace as datafile, temporary_tablespace as logfile
from dba_users
where username in ('HR','USERTEST01');

-- 계정에게 테이블 스페이스 변경 (System ==> Users) 변경
alter user usertest01
default tablespace users
temporary tablespace temp;

-- 계정에게 Users 테이블 스페이스를 사용할 수 있는 공간 할당(users 테이블 스페이스에 2mb를 사용 공간할당)
alter user usertest01
quota 2m on users;

==========================================
문제 : Usertest02 계정을 생성 후에 users 테이블 스페이스에서 테이블 (tbl2) 생성 후 insert

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

select * from all_tables        -- 테이블의 소유주를 출력해 준다. 계정별로 소유한 테이블을 출력 할 수 있다.
where owner in ('HR','USERTEST01','USERTEST02');