-- 6일차 - CRUD ( Create, Read, Update, Delete )

-- Object (객체) : DataBase의 존재 ( XE, <= Express Edition(무료 버전), 
        -- Standard Edition(유료), Enterprise Edition(유료) )
        -- 1. 테이블 , 2. 뷰 , 3. 저장 프로시져, 4. 트리거, 5. 인덱스, 6. 함수, 7. 시퀀스        <== DDL (Create, Alter, Drop)

-- 테이블 생성 (Create)  -- DDL 객체 생성

/*
    Create Table 테이블명 (
        컬럼명 자료형 널허용여부 [제약조건],
        컬럼명 자료형 널허용여부 [제약조건],
        컬럼명 자료형 널허용여부 [제약조건]
    );
*/

Create Table dept (
    dno number(2) not null,
    dname varchar(14) not null,
    loc varchar2(13) null
    );
    
select * from dept;

-- DML : 테이블의 값( 레코드, 로우)을 넣고 (Insert), 수정(update), 삭제(delete)
    -- 트랜젝션을 발생 시킴 : log에 기록을 먼저 하고 Database에 적용한다.
    
    Begin transaction;          -- 트랜젝션 시작( Insert, update, delete 구문이 시작되면 자동으로 시작)
    rollback;                   -- 트랜 젝션을 롤백 (RAM에 적용된 트랜젝션을 삭제)
    commit ;                    -- 트랜 젝션을 적용 (실제 DataBase에 영원히 적용)

/*
    insert into 테이블명 ( 컬럼명1, 컬럼명2, 컬럼명3)
    values3 (값 1, 값 2, 값 3),
*/

insert into dept (dno, dname, loc)
values (10, 'MANAGER', 'SEOUL');

        -- insert, update, delete 구문은 자동으로 트랜젝션이 시작 (begin transaction) - RAM에만 적용되어 있는 상태

rollback;
commit;

/*
    insert 시 컬럼명을 생략
    insert into dept 
    values (값1, 값2,  값3)
*/

insert into dept
values (20, 'ACCOUNTING', 'PUSAN')

commit;

desc dept ;

/* NULL 허용 컬럼에 값을 넣지 않기 */
insert into dept(dno, dname)
values (30, 'RESEARCH');

/* 데이터 유형에 맞지 않는 값 넣으면 오류 발생 */

insert into dept (dno, dname, loc)
values (50, 'SALES', 'TAEGUE');     -- 오류 발생, NUMBER(2) - 2자리까지만 가능

insert into dept (loc, dname, dno)
values ('TAEGUN','SALESSSSSSSSSSSSSSSSSSSSSSSSSSSS', 60);   -- 오류 발생, dname varchar2(14) - 14자리까지만 가능

-- 자료형 (문자 자료형) 
    -- char (10)    : 고정크기 10바이트 , 3바이트만 넣을 경우 빈공간 7바이트가 생김 , 성능이 빠름(장점), 하드공간낭비 (단점)
        -- 자릿수를 알 수 있는 고정 크기 컬럼 ( 주민번호, 전화번호 )
    -- varchar (10) : 가변크기 10바이트 , 3바이트만 넣을 경우 3바이트만 공간할당, 성능이 느림 (단점), 하드 공간낭비가 없음
        -- 자릿수가 가변크기인 경우 (주소, 메일주소..)
    -- Nchar (10) : 유니코드 10자 (한글, 중국어, 일본어 ... )
    -- Nvarchar2 (10) : 유니코드 10자 (한글, 중국어, 일본어 ... )
    
-- 자료형 ( 숫자 자료형 )
    -- NUMBER (2)   : 전체 2자리만 입력 가능
    -- NUMBER (7,3) : 전체 7자리, 소수점 3자리까지 저장이 됨.
    -- NUMBER (8,5) : 전체 8자리, 소수점 5자리까지 저장됨.
    
Create table test1_tb1 (
    a number (3,2) not null,
    b number (7,5) not null,
    c char (6) null,
    d varchar2(10) null,
    e Nchar (6) null,
    f Nvarchar2 (10) null
    );
    
drop table test1_tb1;
    
desc test1_tb1;

select * from test1_tb1;

insert into test1_tb1 (a,b,c,d,e,f)
values (3.22, 75.77755, 'aaaaaa', 'bbbbbbbbbb', '한글여섯자까', '한글열자까지입니다한');

insert into test1_tb1 (a,b,c,d,e,f)
values (3.22, 75.77755, '한글', '한글', '한글여섯자까', '한글열자까지입니다한');

-- 한글 1자는 3byte를 차지한다.

create table test2_tb1 (
    a number (3,2) not null);
    
insert into test2_tb1(a)
values (3.22);
commit

-- 

create table member1(
    no number (10) not null,
    id varchar2 (50) not null,
    passwd varchar2(50) not null,
    name Nvarchar2(6) not null,
    phone varchar2(50) null,
    address varchar2(100) null,
    mdate date not null,
    email varchar2 (50) null
    ) ;

insert into member1 (no, id, passwd, name, phone, address, mdate, email)
values (1, 'aaaa', 'password', '홍길동','010-1111-1111','서울 중구 남산동', sysdate,'aaa@aaa.com');

insert into member1 
values (2, 'bbbb', 'password', '이순신','010-2222-2222','서울 중구 남산동', sysdate,'bbb@bbb.com');

-- Null 허용 컬럼에 Null로 값을 할당.
insert into member1 (no, id, passwd, name, phone, address, mdate, email)
values (3, 'cccc', 'password', '강감찬',null,null, sysdate,null);

-- Null 허용 컬럼에 값을 넣지 않을 경우 Null 값이 들어감.
insert into member1 (no, id, passwd,name, mdate)
values (4, 'ddd', 'password', '세종대왕', sysdate);

commit;

drop table member1;

select * from member1;

desc member1

-- 데이터 수정 ( update : 데이터 수정 후 commit ;
            -- 반드시 where 조건을 사용해야 한다. 그렇지 않으면 모든 레코드가 수정됨.
/*
    update 테이블명
    set 컬럼명 = 수정할 값
    where 컬럼명 = 값
*/

update member1
set name = '신사임당'
where no = 2;

commit;

select * from member1;

update member1
set name = '을지문덕'
where no = 3

rollback

update member1
set mdate = '22/01/01'
where no = 4

-- 하나의 레코드에서 여러컬럼 동시에 수정하기

update member1
set name = '김유신', email = 'kkk@kkk.com', phone = '010-7777-7777'
where no = 1

commit;

update member1
set mdate = to_date('2022-01-01', 'YYYY-MM-DD')
where no = 3;

-- 레코드 (로우) 삭제 ( delete : 반드시 where 조건을 사용해야함.)

/*
    delete 테이블명
    where 컬럼명 = 값
*/

delete member1
where no = 3;

commit;

select * from member1;

delete member1      -- 모든 레코드가 삭제됨.
rollback;    

/*
    update, delete는 반드시 where 조건을 사용해야 한다.  트랜젝션을 종료 ( rollback, commit)
    
    update, delete 시 where 절에 사용되는 컬럼은 고유한 컬럼이어야 한다. (Primary key, Unique 컬럼을 사용해야 한다.
    그렇지 않으면 여러 컬럼이 업데이트 되거나 삭제될 수 있다.
*/

update member1
set name = '김똘똘'
where no = 4;

-- 제약 조건 : 컬럼의 무결성을 확보하기 위해서 사용, 무결성 : 결함없는 데이터(즉, 원하는 데이터만 저장) 
    -- Primary Key
        -- 하나의 테이블에 한번만 사용, 중복된 데이터를 넣지 못하도록 설정.
        -- null 값을 할당할 수 없다.

create table member2(
    no number (10) not null Primary key,
    id varchar2 (50) not null,
    passwd varchar2(50) not null,
    name Nvarchar2(6) not null,
    phone varchar2(50) null,
    address varchar2(100) null,
    mdate date not null,
    email varchar2 (50) null
    ) ;
    
insert into member2 (no, id, passwd, name, phone, address, mdate, email)
values (7, 'aaaa', 'password', '홍길동','010-1111-1111','서울 중구 남산동', sysdate,'aaa@aaa.com');

insert into member2
values (2, 'bbbb', 'password', '이순신','010-2222-2222','서울 중구 남산동', sysdate,'bbb@bbb.com');

-- Null 허용 컬럼에 Null로 값을 할당.
insert into member2 (no, id, passwd, name, phone, address, mdate, email)
values (3, 'cccc', 'password', '강감찬',null,null, sysdate,null);

-- Null 허용 컬럼에 값을 넣지 않을 경우 Null 값이 들어감.
insert into member2 (no, id, passwd,name, mdate)
values (4, 'ddd', 'password', '세종대왕', sysdate);

select * from member2;

update member2
set name = '김유신'
where no = 6;           -- <== 테이블에서 중복되지 않는 고유한 컬럼을 조건으로 사용해야 한다.

/*
    제약조건
        -- UNIQUE : 중복되지 않는 고유한 값을 저장. 하나의 테이블에서 여러 컬럼에 지정 할 수 있다.
                -- NULL을 허용함, NULL은 한번만 저장할 수 있다.
                -- 
*/

create table member3(
    no number (10) Primary key,         -- 중복된 값을 넣을 수 없다.
    id varchar2 (50) not null UNIQUE ,  -- 중복된 값을 넣을 수 없다.
    passwd varchar2(50) not null,
    name Nvarchar2(6) not null,
    phone varchar2(50) null,
    address varchar2(100) null,
    mdate date not null,
    email varchar2 (50) null
    ) ;

select * from member3;

insert into member3 (no, id, passwd, name, phone, address, mdate, email)
values (1, 'aaaa', 'password', '홍길동','010-1111-1111','서울 중구 남산동', sysdate,'aaa@aaa.com');

insert into member3
values (2, 'bbbb', 'password', '이순신','010-2222-2222','서울 중구 남산동', sysdate,'bbb@bbb.com');

-- Null 허용 컬럼에 Null로 값을 할당.
insert into member3 (no, id, passwd, name, phone, address, mdate, email)
values (3, 'cccc', 'password', '강감찬',null,null, sysdate,null);

-- Null 허용 컬럼에 값을 넣지 않을 경우 Null 값이 들어감.
insert into member3 (no, id, passwd,name, mdate)
values (6, 'ffff', 'password', '세종대왕', sysdate);

update member3
set no = 1
where id = 'aaaa'
