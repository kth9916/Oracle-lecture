/*
    Foreign Key로 참조되는 테이블 삭제시
        1. 자식 테이블을 먼저 삭제 후 부모 테이블 삭제
        2. Foreign Key  제약 조건을 모두 제거 후 테이블 삭제
        
*/


-- 테이블 삭제시 주의 사항 : 다른 테이블에서 Foreign Key로 자신의 테이블을 참조하고 있으면 삭제가 안됨.
    -- 다른 테이블이 참조하고 있더라도 강제로 삭제하는 옵션 : cascade **(중요)

drop table orders;
drop table member;             -- 오류 발생 : orders 테이블의 id 컬럼이 member 테이블의 id 컬럼을 참조 하고 있다.
drop table tb_zipcode;          -- 오류 발생 : member 테이블의 zipcode 컬럼이 tb_zipcode 테이블의 zipcode 컬럼을 참조하고 있다.
drop table products;

-- 제약 조건 제거 후 테이블 삭제 (FOREIGN KEY)
alter table member
drop constraint FK_MEMBER_ZIPCODE;

alter table orders
drop constraint FK_ORDERS_ID_MEMBER;

alter table orders
drop constraint FK_ORDERS_PRODUCT_CODE;

-- 제약 조건 확인
select * from user_constraints
where table_name = 'ORDERS';

-- cascade constraints 옵션을 사용해서 삭제, <== Foreign Key 제약 조건을 먼저 제거 후 삭제.
drop table member cascade constraints; 
drop table tb_zipcode cascade constraints;
drop table products cascade constraints;
drop table orders cascade constraints;

-- 테이블 생성시 ( Foreign Key) : 부모 테이블(FK 참조 테이블) 을 먼저 생성해야 한다. 자식 테이블 생성
    -- 자식 테이블을 생성할 때 FK를 넣지 않고 생성 후, 부모테이블 생성 후 , Alter table 사용해서 나중에 FK를 넣어준다. 

-- 테이블 설계 --
create table member(
    id varchar2(20) not null constraint PK_member_id Primary Key,
    pwd varchar2(20),
    name varchar2(50),
    zipcode varchar2(7),
    constraint FK_member_zipcode Foreign Key(zipcode) references tb_zipcode(zipcode),
    address varchar2(20),
    tel varchar2(13),
    indate date default sysdate
    );
    
insert into member
values ('aaaa','abcd','홍길동','111-111','장성군','010-1111-1111',default);

insert into member
values ('bbbb','efgh','세종대왕','222-222','경복궁','010-2222-2222',default);

insert into member
values ('cccc','ijkl','이순신','333-333','한산','010-3333-3333',default);

commit;

select * from member;
    
create table tb_zipcode(
    zipcode varchar2(7) not null constraint PK_tb_zipcode_zipcode Primary Key,
    sido varchar2(30),
    gugum varchar2(30),
    dong varchar2(30),
    bungi varchar2(30)
    );

insert into tb_zipcode
values ('111-111','서울','동대문','전농','148');

insert into tb_zipcode
values ('222-222','서울','서대문','서농','200');

insert into tb_zipcode
values ('333-333','서울','남대문','북농','112');

commit;

select * from tb_zipcode;
    
create table products(
    product_code varchar2(20) not null constraint PK_products_product_code Primary Key,
    product_name varchar2(100),
    product_kind char(1),
    product_price1 varchar2(10),
    product_price2 varchar2(10),
    product_content varchar2(1000),
    product_image varchar2(50),
    sizeSt varchar2(5),
    sizeEt varchar2(5),
    product_quantity varchar2(5),
    useyn char(1),
    indate date
    );

insert into products
values ('가','바이퍼 얼티메이트','1','10원','50원','무선 마우스입니다.','마우스 사진','0cm','20cm','10개','0',sysdate);

insert into products
values ('나','바밀로 키보드','2','50원','200원','기계식 키보드입니다.','키보드 사진','0cm','80cm','10개','0',sysdate);

insert into products
values ('다','삼성 모니터','3','100원','5000원','커브드 모니터입니다','모니터 사진','0cm','150cm','10개','0',sysdate);

commit;

select * from products;


create table orders(
    o_seq number(10) not null constraint PK_orders_o_seq Primary Key,
    product_code varchar2(20),
    constraint FK_orders_product_code Foreign key(product_code) references products(product_code),
    id varchar2(16),
    constraint FK_orders_id_member Foreign key(id) references member(id),
    product_size varchar2(5),
    quantity varchar2(5),
    result char(1),
    indate date
    );

insert into orders
values (1111111111,'가','aaaa','20cm','1','1',sysdate);

insert into orders
values (2222222222,'가','bbbb','80cm','1','1',sysdate);

insert into orders
values (3333333333,'가','cccc','150cm','1','1',sysdate);

commit;

select * from orders;

desc tb_zipcode;