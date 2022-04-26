-- 7일차 - 제약 조건

-- 테이블 복사 : 테이블의 전체를 복사함.
    -- 테이블을 복사하면, 컬럼과 레코드만 복사가 됨
    -- 테이블의 할당된 제약조건은 복사되지 않는다. (Alter Table 을 사용해서 할당 해야 한다. )
    -- 제약 조건 : 컬럼에 할당되어 있다. 무결성을 체크
            -- NOT NULL, Primary Key, Unique, Foreign Key, check, default
    

create table dept_copy
as
select * from department;

desc department;
desc dept_copy;

select * from dept_copy;

create table emp_copy
as
select * from employee;

select * from emp_copy;

-- 테이블 복사 : 특정 컬럼만 복사하기
create table emp_second
as
select eno, ename, salary, dno from employee;

select * from emp_second;

-- 테이블 복사 : 조건을 사용해서 테이블 복사.
create table emp_third
as
select eno, ename,salary
from employee
where salary > 2000;

select * from emp_third;

-- 테이블 복사 : 컬럼명을 바꾸어서 복사
create table emp_forth
as
select eno 사원번호, ename 사원명, salary 월급
from employee;

select 사원번호, 사원명, 월급 from emp_forth;        -- 테이블명, 컬럼명 <== 영문 사용을 권장

-- 테이블 복사 : 계산식을 이용해서 테이블 복사 : 반드시 별칭 이름을 사용해야 한다.
create table emp_fifth
as
select eno, ename, salary * 12 as salary from employee;

select * from emp_fifth;

-- 테이블 복사 : 테이블 구조만 복사, 레코드는 복사하지 않는다.

create table emp_sixth
as
select * from employee
where 0 = 1;                 -- where 조건 : false를 리턴

select * from emp_sixth;
desc emp_sixth;

-- 테이블 수정 : Alter Table
create table dept20
as
select * from department;

desc dept20;
select * from dept20;

-- 기존의 테이블에서 컬럼을 추가 함. 주의 : 반드시 추가할 컬럼에 NULL을 허용해야 한다.
Alter Table dept20
add birth date;

alter table dept20
add email varchar2 (100);

alter table dept20
add address varchar2(200);

-- 컬럼의 자료형을 수정  <== 늘릴 수는 있지만, 줄일 수는 없다.
desc dept20;

alter table dept20
modify dname varchar2 (100);

alter table dept20
modify dno number(4);

alter table dept20
modify address Nvarchar2(200);

-- 특정 컬럼 삭제

alter table dept20
drop column birth;

select * from dept20;

alter table dept20
drop column email;

-- 컬럼을 삭제시에 부하가 많이 발생이 됨.
    -- SET UNUSED : 특정 컬럼을 사용 중지 ( 업무중), 야간에 삭제.
    
alter table dept20
set unused (address);

desc dept20;

alter table dept20      -- 야간에 사용 중지된 컬럼을 삭제
drop unused column;     -- 사용하지 않는 컬럼을 삭제 함

/* 컬럼 이름 변경 */
alter table dept20
rename column loc to locations;

alter table dept20
rename column dno to D_Number ;

/* 테이블 이름 변경 */
RENAME dept20 to dept30;

desc dept30;

/* 테이블 삭제 */
drop table dept30;


/*
    DDL : create (생성), alter (수정), drop(삭제)
        << 객체>>
            테이블, 뷰, 인덱스,트리거, 시퀀스, 함수, 저장프로시져 ....
*/

/*
    DML : Insert (레코드 추가), Update( 레코드 수정), delete(레코드 삭제)
        << 테이블의 값(레코드, 로우) >>
*/
/*
    DQL : Select
*/
/*
    테이블의 전체 내용이나 테이블 삭제시
    1. delete           : 테이블의 레코드를 삭제, where를 사용하지 않을시 모든 레코드 삭제. 레코드를 하나씩 삭제해서 느리다.
    2. truncate         : 테이블의 레코드를 삭제, 속도가 굉장히 빠르다.
    3. drop             : 테이블 자체를 삭제
*/

create table emp30
as
select * from employee;

select * from emp10;

-- emp10 : delete를 사용해서 삭제
    delete emp10;
    
    select * from emp10;

-- emp20 : truncate를 사용해서 삭제
    TRUNCATE TABLE emp20;
    
    select * from emp20;
-- emp30 : drop을 사용해서 삭제
    drop table emp30;
    
    select * from emp30;
    
drop table emp;    
drop table emp_copy;

/*
    데이터 사전 : 시스템의 각종 정보를 출력해주는 테이블
        user_       : 자신의 계정에 속한 객체정보를 출력
        all_        : 자신의 계정이 소유한 객체나 권한을 부여 받은 객체 정보를 출력
        dba_        : 데이타 베이스 관리자만 접근 가능한 객체 정보를 출력.
*/

show user;
select * from user_tables;          -- 사용자가 생성한 테이블 정보 출력
select table_name from user_tables;
select * from user_views;           -- 사용자가 생성한 뷰에 대한 정보 출력
select * from user_indexes;         -- 사용자가 생성한 인덱스 정보.
select * from user_constraints;     -- 제약 조건 확인
select * from user_constraints
where table_name =;
select * from user_sequences;
select * from all_tables;           -- 모든 테이블을 출력, 권한을 부여 받은 테이블만 출력.
select * from all_views;

select * from dba_tables;           -- 관리자 계정에서만 실행 가능

/*
    제약 조건 : 테이블의 무결성 확보하기 위해서 컬럼에 부여되는 규칙.
        1. Primary Key
        2. Unique
        3. NOT NULL
        4. CHECK
        5. FOREIGN KEY
        6. DEFAULT
*/

-- 1. Primary Key : 중복된 값을 넣을 수 없다.
    
    -- a . 테이블 생성시 컬럼에 제약 조건 부여
        -- 제약 조건 이름 : 지정하지 않을 경우 : Oracle에서 랜덤한 이름으로 생성
            -- 제약조건을 수정할 때 제약조건 이름을 사용해서 수정
            -- PK_customer01_id : Primary Key, customer01, id
            -- NN_customer01_pwd : Not Null, customer01(테이블명), id (컬럼명)
        
    create table customer01 (
        id varchar2(20) not null constraint PK_customer01_id Primary Key,
        pwd varchar2(20) constraint NN_customer01_pwd not null,
        name varchar2(20) constraint NN_customer01_name not null,
        phone varchar2(30) null,
        address varchar2(100) null
        );

    select * from user_constraints
    where table_name = 'CUSTOMER01';
    
    
      create table customer02 (
        id varchar2(20) not null Primary Key,
        pwd varchar2(20) not null,
        name varchar2(20) not null,
        phone varchar2(30) null,
        address varchar2(100) null
        );

    select * from user_constraints
    where table_name = 'CUSTOMER02';  
    
-- 테이블의 컬럼 생성 후 제약 조건 할당
    create table customer03 (
        id varchar2(20) not null ,
        pwd varchar2(20) constraint NN_customer03_pwd not null,
        name varchar2(20) constraint NN_customer03_name not null,
        phone varchar2(30) null,
        address varchar2(100) null,
        
        constraint PK_customer03_id Primary Key (id)
        );    
    
/*
    Foreign Key (참조키) : 다른 테이블(부모)의 Primary Key, Unique 컬럼을 참조해서 값을 할당.
    check : 컬럼에 값을 할당할 때 check에 맞는 값을 할당.
*/
-- 부모 테이블
create table parenttbl(
    name varchar2 (20),
    age number(3) constraint CK_ParenTbl_age check(AGE > 0 and AGE < 200),
    gender varchar2(3) constraint CK_ParenTbl_gender check (gender in ('M','W')),
    infono number constraint PK_ParenTbl_infono Primary Key
    );

desc parenttBl;
select * from user_constraints
where table_name = 'PARENTTBL';

select * from parenttbl;

insert into Parenttbl
values('홍길동',30,'M',1);

insert into Parenttbl
values('김똘똘',300,'K',1);        -- 오류 발생 : 300 (check 위배), k(check 위배), 1 (Primary Key 위배)

insert into Parenttbl
values('김똘똘',50,'M',2);

rename Parentbl to ParentTbl;

-- 자식 테이블     
create table ChildTbl (
    id varchar2 (40) constraint PK_ChildTbl_id Primary Key,
    pw varchar2 (40),
    infono number ,
    constraint FK_ChildTbl_infono foreign Key(infono) references Parenttbl(infono)
    );
    
insert into ChildTbl
values ('aaa','1234',1);

insert into ChildTbl
values ('bbb','1234',2);

commit;

select * from childtbl;

-- 부모 테이블
create table ParentTbl2(
    dno number(2) not null Primary Key,
    dname varchar2(50),
    loc varchar2(50)
    );

insert into ParentTbl2
values (10,'SALES','SEOUL');
    
-- 자식 테이블
create table ChildTbl2 (
    no number not null,
    ename varchar2(50),
    dno number(2) not null,
    foreign key(dno) references ParentTbl2(dno)
    );

insert into childtbl2
values (1,'Park',10);

select * from childtbl2;
    
commit;

-- default 제약 조건 : 값을 할당하지 않으면 default 값이 할당

create table emp_sample01(
    eno number(4) not null primary key,
    ename varchar2(50),
    salary number(7,2) default 1000
    );

-- default 컬럼에 값을 할당한 경우.
insert into emp_sample01
values(1111,'홍길동', 1500); 

-- default 컬럼에 값을 할당하지 않는 경우. default에 할당된 값이 적용
insert into emp_sample01 (eno, ename)
values(2222,'홍길순');

insert into emp_sample01
values (3333,'김유신', default);

select * from emp_sample01;

create table emp_sample02 (
    eno number(4) not null primary key,
    ename varchar2(50) default '홍홍홍',
    salary number(7,2) default 1000
    );

insert into emp_sample02 (eno)
values (10);

select * from emp_sample02;

insert into emp_sample02
values (20,default,default);

/*
    primary key, Foreign key, Unique, Check, Default, not null
*/

create table member10 (
    no number not null constraint PK_member10_no Primary Key,
    name varchar2(50) constraint NN_member10_name not null,
    birthday date default sysdate,
    age number(3) check(age > 0 and age < 150),
    gender char(1) check (gender in ('M','W')),
    dno number(2) Unique
    );

insert into member10
values(1,'홍길동',default,30,'M',10);

insert into member10
values(2,'김유신',default,30,'M',20);

select * from member10;

create table orders10 (
    no number not null Primary Key,
    P_no varchar2(100) not null,
    p_name varchar2(100) not null,
    price number check (price > 10),
    phone varchar2(100) default '010-0000-0000',
    dno number(2) not null,
    foreign key (dno) references member10 (dno)
    );

insert into orders10
values (1,'11111','유관순',5000,default,10);

select * from orders10;

drop table member;
drop table orders;
