-- 6���� - CRUD ( Create, Read, Update, Delete )

-- Object (��ü) : DataBase�� ���� ( XE, <= Express Edition(���� ����), 
        -- Standard Edition(����), Enterprise Edition(����) )
        -- 1. ���̺� , 2. �� , 3. ���� ���ν���, 4. Ʈ����, 5. �ε���, 6. �Լ�, 7. ������        <== DDL (Create, Alter, Drop)

-- ���̺� ���� (Create)  -- DDL ��ü ����

/*
    Create Table ���̺�� (
        �÷��� �ڷ��� ����뿩�� [��������],
        �÷��� �ڷ��� ����뿩�� [��������],
        �÷��� �ڷ��� ����뿩�� [��������]
    );
*/

Create Table dept (
    dno number(2) not null,
    dname varchar(14) not null,
    loc varchar2(13) null
    );
    
select * from dept;

-- DML : ���̺��� ��( ���ڵ�, �ο�)�� �ְ� (Insert), ����(update), ����(delete)
    -- Ʈ�������� �߻� ��Ŵ : log�� ����� ���� �ϰ� Database�� �����Ѵ�.
    
    Begin transaction;          -- Ʈ������ ����( Insert, update, delete ������ ���۵Ǹ� �ڵ����� ����)
    rollback;                   -- Ʈ�� ������ �ѹ� (RAM�� ����� Ʈ�������� ����)
    commit ;                    -- Ʈ�� ������ ���� (���� DataBase�� ������ ����)

/*
    insert into ���̺�� ( �÷���1, �÷���2, �÷���3)
    values3 (�� 1, �� 2, �� 3),
*/

insert into dept (dno, dname, loc)
values (10, 'MANAGER', 'SEOUL');

        -- insert, update, delete ������ �ڵ����� Ʈ�������� ���� (begin transaction) - RAM���� ����Ǿ� �ִ� ����

rollback;
commit;

/*
    insert �� �÷����� ����
    insert into dept 
    values (��1, ��2,  ��3)
*/

insert into dept
values (20, 'ACCOUNTING', 'PUSAN')

commit;

desc dept ;

/* NULL ��� �÷��� ���� ���� �ʱ� */
insert into dept(dno, dname)
values (30, 'RESEARCH');

/* ������ ������ ���� �ʴ� �� ������ ���� �߻� */

insert into dept (dno, dname, loc)
values (50, 'SALES', 'TAEGUE');     -- ���� �߻�, NUMBER(2) - 2�ڸ������� ����

insert into dept (loc, dname, dno)
values ('TAEGUN','SALESSSSSSSSSSSSSSSSSSSSSSSSSSSS', 60);   -- ���� �߻�, dname varchar2(14) - 14�ڸ������� ����

-- �ڷ��� (���� �ڷ���) 
    -- char (10)    : ����ũ�� 10����Ʈ , 3����Ʈ�� ���� ��� ����� 7����Ʈ�� ���� , ������ ����(����), �ϵ�������� (����)
        -- �ڸ����� �� �� �ִ� ���� ũ�� �÷� ( �ֹι�ȣ, ��ȭ��ȣ )
    -- varchar (10) : ����ũ�� 10����Ʈ , 3����Ʈ�� ���� ��� 3����Ʈ�� �����Ҵ�, ������ ���� (����), �ϵ� �������� ����
        -- �ڸ����� ����ũ���� ��� (�ּ�, �����ּ�..)
    -- Nchar (10) : �����ڵ� 10�� (�ѱ�, �߱���, �Ϻ��� ... )
    -- Nvarchar2 (10) : �����ڵ� 10�� (�ѱ�, �߱���, �Ϻ��� ... )
    
-- �ڷ��� ( ���� �ڷ��� )
    -- NUMBER (2)   : ��ü 2�ڸ��� �Է� ����
    -- NUMBER (7,3) : ��ü 7�ڸ�, �Ҽ��� 3�ڸ����� ������ ��.
    -- NUMBER (8,5) : ��ü 8�ڸ�, �Ҽ��� 5�ڸ����� �����.
    
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
values (3.22, 75.77755, 'aaaaaa', 'bbbbbbbbbb', '�ѱۿ����ڱ�', '�ѱۿ��ڱ����Դϴ���');

insert into test1_tb1 (a,b,c,d,e,f)
values (3.22, 75.77755, '�ѱ�', '�ѱ�', '�ѱۿ����ڱ�', '�ѱۿ��ڱ����Դϴ���');

-- �ѱ� 1�ڴ� 3byte�� �����Ѵ�.

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
values (1, 'aaaa', 'password', 'ȫ�浿','010-1111-1111','���� �߱� ���굿', sysdate,'aaa@aaa.com');

insert into member1 
values (2, 'bbbb', 'password', '�̼���','010-2222-2222','���� �߱� ���굿', sysdate,'bbb@bbb.com');

-- Null ��� �÷��� Null�� ���� �Ҵ�.
insert into member1 (no, id, passwd, name, phone, address, mdate, email)
values (3, 'cccc', 'password', '������',null,null, sysdate,null);

-- Null ��� �÷��� ���� ���� ���� ��� Null ���� ��.
insert into member1 (no, id, passwd,name, mdate)
values (4, 'ddd', 'password', '�������', sysdate);

commit;

drop table member1;

select * from member1;

desc member1

-- ������ ���� ( update : ������ ���� �� commit ;
            -- �ݵ�� where ������ ����ؾ� �Ѵ�. �׷��� ������ ��� ���ڵ尡 ������.
/*
    update ���̺��
    set �÷��� = ������ ��
    where �÷��� = ��
*/

update member1
set name = '�Ż��Ӵ�'
where no = 2;

commit;

select * from member1;

update member1
set name = '��������'
where no = 3

rollback

update member1
set mdate = '22/01/01'
where no = 4

-- �ϳ��� ���ڵ忡�� �����÷� ���ÿ� �����ϱ�

update member1
set name = '������', email = 'kkk@kkk.com', phone = '010-7777-7777'
where no = 1

commit;

update member1
set mdate = to_date('2022-01-01', 'YYYY-MM-DD')
where no = 3;

-- ���ڵ� (�ο�) ���� ( delete : �ݵ�� where ������ ����ؾ���.)

/*
    delete ���̺��
    where �÷��� = ��
*/

delete member1
where no = 3;

commit;

select * from member1;

delete member1      -- ��� ���ڵ尡 ������.
rollback;    

/*
    update, delete�� �ݵ�� where ������ ����ؾ� �Ѵ�.  Ʈ�������� ���� ( rollback, commit)
    
    update, delete �� where ���� ���Ǵ� �÷��� ������ �÷��̾�� �Ѵ�. (Primary key, Unique �÷��� ����ؾ� �Ѵ�.
    �׷��� ������ ���� �÷��� ������Ʈ �ǰų� ������ �� �ִ�.
*/

update member1
set name = '��ʶ�'
where no = 4;

-- ���� ���� : �÷��� ���Ἲ�� Ȯ���ϱ� ���ؼ� ���, ���Ἲ : ���Ծ��� ������(��, ���ϴ� �����͸� ����) 
    -- Primary Key
        -- �ϳ��� ���̺� �ѹ��� ���, �ߺ��� �����͸� ���� ���ϵ��� ����.
        -- null ���� �Ҵ��� �� ����.

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
values (7, 'aaaa', 'password', 'ȫ�浿','010-1111-1111','���� �߱� ���굿', sysdate,'aaa@aaa.com');

insert into member2
values (2, 'bbbb', 'password', '�̼���','010-2222-2222','���� �߱� ���굿', sysdate,'bbb@bbb.com');

-- Null ��� �÷��� Null�� ���� �Ҵ�.
insert into member2 (no, id, passwd, name, phone, address, mdate, email)
values (3, 'cccc', 'password', '������',null,null, sysdate,null);

-- Null ��� �÷��� ���� ���� ���� ��� Null ���� ��.
insert into member2 (no, id, passwd,name, mdate)
values (4, 'ddd', 'password', '�������', sysdate);

select * from member2;

update member2
set name = '������'
where no = 6;           -- <== ���̺��� �ߺ����� �ʴ� ������ �÷��� �������� ����ؾ� �Ѵ�.

/*
    ��������
        -- UNIQUE : �ߺ����� �ʴ� ������ ���� ����. �ϳ��� ���̺��� ���� �÷��� ���� �� �� �ִ�.
                -- NULL�� �����, NULL�� �ѹ��� ������ �� �ִ�.
                -- 
*/

create table member3(
    no number (10) Primary key,         -- �ߺ��� ���� ���� �� ����.
    id varchar2 (50) not null UNIQUE ,  -- �ߺ��� ���� ���� �� ����.
    passwd varchar2(50) not null,
    name Nvarchar2(6) not null,
    phone varchar2(50) null,
    address varchar2(100) null,
    mdate date not null,
    email varchar2 (50) null
    ) ;

select * from member3;

insert into member3 (no, id, passwd, name, phone, address, mdate, email)
values (1, 'aaaa', 'password', 'ȫ�浿','010-1111-1111','���� �߱� ���굿', sysdate,'aaa@aaa.com');

insert into member3
values (2, 'bbbb', 'password', '�̼���','010-2222-2222','���� �߱� ���굿', sysdate,'bbb@bbb.com');

-- Null ��� �÷��� Null�� ���� �Ҵ�.
insert into member3 (no, id, passwd, name, phone, address, mdate, email)
values (3, 'cccc', 'password', '������',null,null, sysdate,null);

-- Null ��� �÷��� ���� ���� ���� ��� Null ���� ��.
insert into member3 (no, id, passwd,name, mdate)
values (6, 'ffff', 'password', '�������', sysdate);

update member3
set no = 1
where id = 'aaaa'
