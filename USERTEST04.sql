
create table a (
    a number not null
    );
    
create view v_b
as
select * from a;

create index idx_c
on a(a);

create sequence a_sec
    increment by 1
    start with 1
    nocache;
    
insert into a
values (a_sec.nextval);

commit;

select * from a;