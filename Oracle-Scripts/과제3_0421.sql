--�׷��Լ� ����. 

--1. ��� ����� �޿� �ְ��, ������, �Ѿ�, �� ��� �޿��� ��� �Ͻÿ�. �÷��� ��Ī�� ����(�ְ��, ������, �Ѿ�, ���)�ϰ� �����ϰ� ��տ� ���ؼ��� ������ �ݿø� �Ͻÿ�. 
select max(salary) as �ְ��, min(salary) as ������, sum(salary) as �Ѿ�, round(avg(salary)) as ���
from employee;

--2. �� ������ �������� �޿� �ְ��, ������, �Ѿ� �� ��վ��� ����Ͻÿ�. �÷��� ��Ī�� ����(�ְ��, ������, �Ѿ�, ���)�ϰ� �����ϰ� ��տ� ���ؼ��� ������ �ݿø� �Ͻÿ�. 
select job, count(*), max(salary) as �ְ��, min(salary) as ������, sum(salary) as �Ѿ�, round(avg(salary)) as ���
from employee
group by job;

-- rollup, cube : group by ������ ����ϴ� Ư���� Ű����

select job, count(*), max(salary) as �ְ��, min(salary) as ������, sum(salary) as �Ѿ�, round(avg(salary)) as ���
from employee
group by cube(job)
order by job;

-- �� �� �̻��� �÷��� �׷���(�Ѿ�)
select dno,job, count(*), max(salary) as �ְ��, min(salary) as ������, sum(salary) as �Ѿ�, round(avg(salary)) as ���
from employee
group by rollup(dno, job) -- �ΰ� �̻��� �÷��� �׷��� : �� �÷��� ��� ������ �� �׷��� / �Ѿ��� ���� �÷����θ� ����ؼ� ������.
order by dno asc;

-- �� �� �̻��� �÷��� �׷���(ť��)
select dno, job, count(*), max(salary) as �ְ��, min(salary) as ������, sum(salary) as �Ѿ�, round(avg(salary)) as ���
from employee
group by cube(dno, job) -- ť��� ���� �÷����� ����ؼ� ������
order by dno;

--3. count(*)�Լ��� ����Ͽ� ��� ������ ������ ������� ����Ͻÿ�. 
select job, count(*) as �����
from employee
group by job;

select distinct job, count(*)
from employee
group by job;

select count(distinct job) from employee;


--4. ������ ���� ���� �Ͻÿ�. �÷��� ��Ī�� "�����ڼ�" �� ���� �Ͻÿ�.    // Ʋ��  : distinct�� ��� ���԰� �ִ�.
select count( distinct manager) as �����ڼ�   -- count�� null�� �������� �ʴ´�.
from employee;

--5. �޿� �ְ��, ���� �޿����� ������ ��� �Ͻÿ�, �÷��� ��Ī�� "DIFFERENCE"�� �����Ͻÿ�. 
select max(salary) as �ְ�ݾ�, min(salary) as �����ݾ�, (max(salary) - min(salary)) as DIFFERENCE
from employee;

--6. ���޺� ����� ���� �޿��� ����Ͻÿ�. �����ڸ� �� �� ���� ��� �� ���� �޿��� 2000�̸��� �׷��� ���� ��Ű�� 
--   ����� �޿��� ���� ������������ �����Ͽ� ��� �Ͻÿ�. 
-- where , having ��� ���

select * from employee;

select job, min(salary) as "���� �޿�"
from employee
where manager is not null       -- ��� ������ �� ���� ó��
group by job, manager
having min(salary) >= 2000      -- ��� ���� �� ���� ó��
order by min(salary) desc;

--7. �� �μ������� �μ���ȣ, �����, �μ����� ��� ����� ��� �޿��� ����Ͻÿ�. �÷��� ��Ī�� [�μ���ȣ, �����, ��ձ޿�] �� �ο��ϰ� ��ձ޿��� �Ҽ��� 2°�ڸ����� �ݿø� �Ͻÿ�. 
select dno as �μ���ȣ, count(*) as �����, round(avg(salary),2) as ��ձ޿�
from employee
group by dno;

--8. �� �μ��� ���� �μ���ȣ�̸�, ������, �����, �μ����� ��� ����� ��� �޿��� ����Ͻÿ�.  
-- �÷��� ��Ī�� [�μ���ȣ�̸�, ������, �����,��ձ޿�] �� �����ϰ� ��ձ޿��� ������ �ݿø� �Ͻÿ�.  
select * from employee;
select DECODE(dno, 10,'ACCOUNTING' ,
                        20,'RESEARCH',
                        30,'SALES' ,
                        dno) as dname,
       DECODE(dno, 10, 'NEW YORK' ,
                    20, 'DALLAS',
                    30,'CHICAGO',
                    dno) as Location, 
                    count(*) as "Number of People",
                    round(avg(salary)) as Salary
from employee
group by dno;
/*
[��¿���] 

dname		Location		Number of People		Salary
-----------------------------------------------------------------------------------------------
SALES		CHICAO			6		1567
RESERCH		DALLS			5		2175
ACCOUNTING   	NEW YORK		3		2917
*/