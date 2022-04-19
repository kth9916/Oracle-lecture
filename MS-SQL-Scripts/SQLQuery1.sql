Create Database myDB;		-- 한줄 주석 /* 여러줄 주석 */

use myDB;		-- myDB에 연결한다

Create Table abc (
	a int not null,
	b char(10) null,
	c varchar(50) null
	);
select * from abc;
insert into abc values(1, '홍길동', 'aaa@aaa.com');
insert into abc values(2, '김유신', 'bbb@bbb.com');