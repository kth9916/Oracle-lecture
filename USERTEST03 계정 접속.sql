
create table testTbl (
    a number not null,
    b number null,
    c varchar2(10) null
    );
    
insert into testTbl
values(1,1,'°¡');

select * from testTbl;