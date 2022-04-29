--���̺� ���� ���� - 06
select * from employee;
--1. EQUI ������ ����Ͽ� SCOTT ����� �μ� ��ȣ�� �μ� �̸��� ��� �Ͻÿ�. 
select e.dno, dname
from employee e, department d
where e.dno = d.dno
and ename = 'SCOTT';

-- �� ���̺��� ���� �� �� ������ Ű �÷��� ã�ƾ� �Ѵ�.
select * from employee;
select * from department;

-- ���� ����   : ���̺��� �÷��� �Ҵ�Ǿ �������� ���Ἲ�� Ȯ��
    -- Primary Key : ���̺� �ѹ��� ����� �� �ִ�. �ϳ��� �÷�, �ΰ� �̻��� �׷����ؼ� ����
                    -- �ߺ��� ���� ���� �� ����. NULL�� ���� �� ����.
    -- UNIQUE       : ���̺� ���� �÷��� �Ҵ��� �� �ִ�. �ߺ��� ���� ���� �� ����.
                    -- NULL ���� �� �ִ�. �� �ѹ��� null
    -- Foreign Key : �ٸ� ���̺��� Ư�� �÷��� ���� �����ؼ� ���� �� �ִ�.
                    -- �ڽ��� �÷��� ������ ���� �Ҵ����� ���Ѵ�.
    -- NOT NULL    : Null ���� �÷��� �Ҵ��� �� ����.
    -- CHECK        : �÷��� ���� �Ҵ��� �� üũ�ؼ� (���ǿ� ����) ���� �Ҵ�
    -- Default      : ���� ���� ���� �� �⺻���� �Ҵ�

--2. INNER JOIN�� ON �����ڸ� ����Ͽ� ����̸��� �Բ� �� ����� �Ҽӵ� �μ��̸��� �������� ����Ͻÿ�. 
select ename ����̸�, dname �μ��̸�, loc ������
from employee e join department d
on e.dno = d.dno;

--3. INNER JOIN�� USING �����ڸ� ����Ͽ� 10�� �μ��� ���ϴ� ��� ��� ������ ������ ���(�ѹ����� ǥ��)�� �μ��� �������� �����Ͽ� ��� �Ͻÿ�. 

-- Join���� Using�� ����ϴ� ��� :
    -- NATURAL JOIN : ���� Ű �÷��� Oracle ���ο��� �ڵ� ó��, �ݵ�� �� ���̺��� ����Ű �÷��� ������ Ÿ���� ���ƾ� �Ѵ�.
    -- �� ���̺��� ���� Ű �÷��� ������ Ÿ���� �ٸ� ��� Using�� ����Ѵ�.
    -- �� ���̺��� ���� Ű �÷��� ���� ���� ��� using�� ����Ѵ�.
    
desc employee;
desc department;

select dno, job, loc
from employee e join department d
using (dno)
where dno = 10;
    
--4. NATUAL JOIN�� ����Ͽ� Ŀ�Լ��� �޴� ��� ����� �̸�, �μ��̸�, �������� ��� �Ͻÿ�. 
select ename,  dname, loc
from employee e natural join department d
where commission is not null;

--5. EQUI ���ΰ� WildCard(_,%)�� ����Ͽ� �̸��� A �� ���Ե� ��� ����� �̸��� �μ����� ��� �Ͻÿ�. 
select ename, dname
from employee e, department d
where e.dno = d.dno
and ename like '%A%';

--6. NATURAL JOIN�� ����Ͽ� NEW YORK�� �ٹ��ϴ� ��� ����� �̸�, ����, �μ���ȣ �� �μ����� ����Ͻÿ�. 
select ename, job, dno, dname
from employee natural join department
where loc = 'NEW YORK';