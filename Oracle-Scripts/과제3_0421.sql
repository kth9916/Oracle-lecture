--�׷��Լ� ����. 

--1. ��� ����� �޿� �ְ��, ������, �Ѿ�, �� ��� �޿��� ��� �Ͻÿ�. �÷��� ��Ī�� ����(�ְ��, ������, �Ѿ�, ���)�ϰ� �����ϰ� ��տ� ���ؼ��� ������ �ݿø� �Ͻÿ�. 
select max(salary) as �ְ��, min(salary) as ������, sum(salary) as �Ѿ�, round(avg(salary)) as ���
from employee;

--2. �� ������ �������� �޿� �ְ��, ������, �Ѿ� �� ��վ��� ����Ͻÿ�. �÷��� ��Ī�� ����(�ְ��, ������, �Ѿ�, ���)�ϰ� �����ϰ� ��տ� ���ؼ��� ������ �ݿø� �Ͻÿ�. 
select job, max(salary) as �ְ��, min(salary) as ������, sum(salary) as �Ѿ�, round(avg(salary)) as ���
from employee
group by job;
--3. count(*)�Լ��� ����Ͽ� ��� ������ ������ ������� ����Ͻÿ�. 
select job, count(*) as �����
from employee
group by job;

--4. ������ ���� ���� �Ͻÿ�. �÷��� ��Ī�� "�����ڼ�" �� ���� �Ͻÿ�. 
select count(manager) as �����ڼ�
from employee;

--5. �޿� �ְ��, ���� �޿����� ������ ��� �Ͻÿ�, �÷��� ��Ī�� "DIFFERENCE"�� �����Ͻÿ�. 
select (max(salary) - min(salary)) as DIFFERENCE
from employee;

--6. ���޺� ����� ���� �޿��� ����Ͻÿ�. �����ڸ� �� �� ���� ��� �� ���� �޿��� 2000�̸��� �׷��� ���� ��Ű�� ����� �޿��� ���� ������������ �����Ͽ� ��� �Ͻÿ�. 
select * from employee;
select job, min(salary) as "���� �޿�"
from employee
group by job, manager
having min(salary) >= 2000 and manager is not null
order by min(salary) desc;

--7. �� �μ������� �μ���ȣ, �����, �μ����� ��� ����� ��� �޿��� ����Ͻÿ�. �÷��� ��Ī�� [�μ���ȣ, �����, ��ձ޿�] �� �ο��ϰ� ��ձ޿��� �Ҽ��� 2°�ڸ����� �ݿø� �Ͻÿ�. 
select dno as �μ���ȣ, count(*) as �����, round(avg(salary),2) as ��ձ޿�
from employee
group by dno;

--8. �� �μ��� ���� �μ���ȣ�̸�, ������, �����, �μ����� ��� ����� ��� �޿��� ����Ͻÿ�.  �ᷳ�� ��Ī�� [�μ���ȣ�̸�, ������, �����,��ձ޿�] �� �����ϰ� ��ձ޿��� ������ �ݿø� �Ͻÿ�.  
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