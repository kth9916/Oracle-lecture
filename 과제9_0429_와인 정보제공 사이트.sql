
-- 테이블 설계

create table grade_pt_rade(
    men_grade varchar2(20) not null Primary Key,
    grade_pt_rate number(3,2)
    );

insert into grade_pt_rade
values ('VIP',5);

insert into grade_pt_rade
values ('일반',3);

insert into grade_pt_rade
values ('뉴비',1);

select * from grade_pt_rade;
    
create table member(
    mem_id varchar2(6) not null Primary Key,
    mem_grade varchar2(20),
    Foreign Key(mem_grade) references GRADE_PT_RADE(men_grade),
    mem_pw varchar2(20) not null,
    mem_birth date not null,
    mem_tel varchar2(20),
    mem_pt varchar2(10) not null
    );

insert into member
values ('id1','VIP','111',sysdate + 1,'010-1111-1111',default);

insert into member
values ('id2','일반','222',sysdate + 2,'010-2222-2222',default);

insert into member
values ('id3','뉴비','333',sysdate + 3,'010-3333-3333',default);

alter table member
modify (mem_birth default sysdate);

alter table member
modify (mem_pt default 0);

select * from member;

create table today(
    today_code varchar2(6) not null Primary Key,
    today_sens_value number(3),
    today_intell_value number(3),
    today_phy_value number(3)
    );

insert into today
values ('가',1,1,1);

insert into today
values ('나',2,2,2);

insert into today
values ('다',3,3,3);
   
create table nation(
    nation_code varchar2(26) not null primary key,
    nation_name varchar2(50) not null
    );
    
insert into nation
values ('82','한국');

insert into nation
values ('83','일본');

insert into nation
values ('84','중국');
    
create table theme(
    theme_code varchar2(6) not null primary key,
    theme_name varchar2(50) not null
    );
    
insert into theme
values ('RED','레드');

insert into theme
values ('WHITE','화이트');

insert into theme
values ('BLUE','블루');

create table wine_type(
    wine_type_code varchar2(6) not null primary key,
    wine_type_name varchar2(50)
    );
    
insert into wine_type
values ('A','까베르네 소비뇽');

insert into wine_type
values ('B','샤르도네');

insert into wine_type
values ('C','소비뇽 블랑');
    
create table wine(
    wine_code varchar2(26) not null primary key,
    wine_name varchar2(100) not null,
    wine_url blob,
    nation_code varchar2(6),
    Foreign key(nation_code) references nation(nation_code),
    wine_type_code varchar2(6),
    Foreign key(wine_type_code) references wine_type(wine_type_code),
    wine_sugar_code number(2),
    wine_price number(15) not null,
    wine_vintage date,
    theme_code varchar2(6),
    Foreign key(theme_code) references theme(theme_code),
    today_code varchar2(6),
    Foreign key(today_code) references today(today_code)
    );

insert into wine
values ('001','피노 누아',empty_blob(),'82', 'A',1,15000,'1900/01/01','RED','가');

insert into wine
values ('002','리슬링',empty_blob(),'83', 'B',2,20000,'1900/01/01','WHITE','나');

insert into wine
values ('003','로마네 꽁띠',empty_blob(),'84', 'C',3,30000,'1900/01/01','RED','다');
    
select * from today;
select * from nation;
select * from wine_type;
select * from theme;

 
alter table wine
modify (wine_price default 0);

create table sale(
    sale_date date not null primary key,
    wine_code varchar2(6) not null,
    foreign key(wine_code) references wine(wine_code),
    mem_id varchar2(30) not null,
    foreign key(mem_id) references member(mem_id),
    sale_amount varchar2(5) not null,
    sale_price varchar2(6) not null,
    sale_tot_price varchar2(15) not null
    );

commit;

insert into sale
values (default, '001', 'id1','5','15000','75000');

insert into sale
values (default, '002', 'id2','5','20000','100000');

insert into sale
values (default, '003', 'id3','5','30000','150000');

select * from wine;
select * from member;

alter table sale
modify (sale_date default sysdate);

alter table sale
modify (sale_amount default 0);

alter table sale
modify (sale_price default 0);

alter table sale
modify (sale_tot_price default 0);

create table manager(
    manager_id varchar2(30) not null primary key,
    manager_pwd varchar2(20) not null,
    manager_tel varchar2(20)
    );

insert into manager
values ('100','111','010-1111-1111');

insert into manager
values ('200','222','010-2222-2222');

insert into manager
values ('300','333','010-3333-3333');

select * from member;

create table stock_management(
    stock_code varchar2(6) not null primary key,
    wine_code varchar2(6),
    foreign key(wine_code) REFERENCES wine(wine_code),
    manager_id varchar2(30),
    foreign key(manager_id) REFERENCES manager(manager_id),
    ware_date date not null,
    stock_amount number(5) not null
    );
    
insert into stock_management
values ('010','001','100',default,10);

insert into stock_management
values ('020','002','200',default,10);

insert into stock_management
values ('030','003','300',default,10);

select * from wine;

alter table stock_management
modify (ware_date default sysdate);

alter table stock_management
modify (stock_amount default 0);


commit;
