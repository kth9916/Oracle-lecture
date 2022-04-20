select * from employee;
--1. SUBSTR �Լ��� ����Ͽ� ������� �Ի��� �⵵�� �Ի��� �޸� ��� �Ͻÿ�. 
select substr(hiredate,1,2) as "�Ի��� �⵵", substr(hiredate,4,2) as "�Ի��� ��"
from employee;
--2. SUBSTR �Լ��� ����Ͽ� 4���� �Ի��� ����� ��� �Ͻÿ�. 
select *
from employee
where substr(hiredate,4,2) = 04;
--3. MOD �Լ��� ����Ͽ� ���ӻ���� Ȧ���� ����� ����Ͻÿ�. 
select *
from employee
where mod(manager,2) = 1;
--3-1. MOD �Լ��� ����Ͽ� ������ 3�� ����� ����鸸 ����ϼ���.
select *
from employee
where mod(salary,3) = 0;
--4. �Ի��� �⵵�� 2�ڸ� (YY), ���� (MON)�� ǥ���ϰ� ������ ��� (DY)�� �����Ͽ� ��� �Ͻÿ�. 
select to_char(hiredate,'YY MON DY')
from employee;
--5. ���� �� ���� �������� ��� �Ͻÿ�. ���� ��¥���� ���� 1�� 1���� �� ����� ����ϰ� TO_DATE �Լ��� ����Ͽ�
--   ������ ������ ��ġ ��Ű�ÿ�. 
select sysdate - to_date(20220101, 'YYYYMMDD')
from dual;

--5-1. �ڽ��� �¾ ��¥���� ������� �� ���� �������� ��� �ϼ���.
select sysdate - to_date(19920502, 'YYYYMMDD')
from dual;
--5-2. �ڽ��� �¾ ��¥���� ������� �� ������ �������� ��� �ϼ���. 
select months_between(sysdate,to_date(19920502,'YYYYMMDD'))
from dual;
--6. ������� ��� ����� ����ϵ� ����� ���� ����� ���ؼ��� null ����� 0���� ��� �Ͻÿ�. 
select nvl2(manager,manager,0)
from employee;

--7.  DECODE �Լ��� ���޿� ���� �޿��� �λ��ϵ��� �Ͻÿ�. ������ 'ANAIYST' ����� 200 , 'SALESMAN' ����� 180,
    'MANAGER'�� ����� 150, 'CLERK'�� ����� 100�� �λ��Ͻÿ�. 
    desc employee;
select * from employee;

select decode (job, 'ANALYST', SALARY + 200,
                   'SALESMAN', SALARY + 180,
                   'MANAGER', SALARY + 150,
                   'CLERK', SALARY + 100,
                   salary)
from employee;
/*
8. 
�����ȣ , 
[�����ȣ 2�ڸ��� ��� �������� *����] as "������ȣ",
 �̸�,
 [�̸��� ù�ڸ� ��� �� ���ڸ�, �� �ڸ��� * ����] as "�����̸�"
 */
 select eno, rpad(substr(eno,1,2),4,'*') as "������ȣ", ename, rpad(substr(ename,1,1),4,'*') as "�����̸�"
 from employee;
 
 /*
 9. �ֹι�ȣ�� ����ϵ� 801210-1****** ��� �ϵ���, ��ȭ ��ȣ : 010-11******
	dual ���̺� ���
*/
select rpad(substr('801210-1000000',1,8),14,'*') as "���� �ֹι�ȣ", rpad(substr('010-1100-0000',1,6),13,'*') as "���� ��ȭ��ȣ"
from dual;

/*
10. �����ȣ, �����, ���ӻ��,
	[���ӻ���� �����ȣ�� ���� ��� : 0000
	���ӻ���� �����ȣ �� 2�ڸ��� 75�� ��� : 5555	
	���ӻ���� �����ȣ �� 2�ڸ��� 76�� ��� : 6666
	���ӻ���� �����ȣ �� 2�ڸ��� 77�� ��� : 7777
	���ӻ���� �����ȣ �� 2�ڸ��� 78�� ��� : 8888
	�׿ܴ� �״�� ���.
*/
select substr(manager,1,2) from employee;
select eno, ename, manager, case when manager is null then 0000
                                 when substr(manager,1,2) = 76 then 6666
                                 when substr(manager,1,2) = 77 then 7777
                                 when substr(manager,1,2) = 78 then 8888
                                 else manager 
                 END as ����
from employee;