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
values ('aaaa','abcd','ȫ�浿','111-111','�强��','010-1111-1111',default);

insert into member
values ('bbbb','efgh','�������','222-222','�溹��','010-2222-2222',default);

insert into member
values ('cccc','ijkl','�̼���','333-333','�ѻ�','010-3333-3333',default);

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
values ('111-111','����','���빮','����','148');

insert into tb_zipcode
values ('222-222','����','���빮','����','200');

insert into tb_zipcode
values ('333-333','����','���빮','�ϳ�','112');

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
values ('��','������ ��Ƽ����Ʈ','1','10��','50��','���� ���콺�Դϴ�.','���콺 ����','0cm','20cm','10��','0',sysdate);

insert into products
values ('��','�ٹз� Ű����','2','50��','200��','���� Ű�����Դϴ�.','Ű���� ����','0cm','80cm','10��','0',sysdate);

insert into products
values ('��','�Ｚ �����','3','100��','5000��','Ŀ��� ������Դϴ�','����� ����','0cm','150cm','10��','0',sysdate);

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
values (1111111111,'��','aaaa','20cm','1','1',sysdate);

insert into orders
values (2222222222,'��','bbbb','80cm','1','1',sysdate);

insert into orders
values (3333333333,'��','cccc','150cm','1','1',sysdate);

commit;

select * from orders;

desc tb_zipcode;