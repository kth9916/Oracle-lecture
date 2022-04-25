-- 2���� : DQL : Select

-- desc ���̺��    : ���̺��� ������ Ȯ��
desc department;

select * from department;

/*
SQL : ����ȭ�� ���� ���

Select ������ ��ü �ʵ� ����

Select      <== �÷���
Distinct    <== �÷����� ���� �ߺ��� �����ض�.
From        <== ���̺��, ���
Where       <== ����
Group By    <== Ư�� ���� �׷���
Having      <== �׷����� ���� ����
Order by    <== ���� �����ؼ� ���

*/

desc employee;

SELECT
    *
FROM employee;

-- Ư�� �÷��� ��� �ϱ�
select eno, ename from employee;

-- Ư�� �÷��� ������ ���
select eno, ename, eno, ename, ename from employee;

select eno, ename, salary from employee;

-- �÷��� ������ ������ �� �ִ�.

select eno, ename, salary, salary * 12 from employee;

-- �÷��� �˸��(Alias) : �÷��� �̸��� ����
    -- �÷��� ������ �ϰų� �Լ��� ����ϸ� �÷����� ��������.
select eno, ename, salary, salary * 12 as ���� from employee;
select eno as �����ȣ, ename as �����, salary as ����, salary * 12 as ���� from employee;
select eno �����ȣ, ename �����, salary ����, salary * 12 ���� from employee;
   
    -- �����̳� Ư�����ڰ� ��� ������ ""���� ó���ؾ� �Ѵ�.
select eno "��� ��ȣ", ename �����, salary ����, salary * 12 ���� from employee;

-- nvl �Լ� : ����ÿ� null�� ó���ϴ� �Լ�
select * from employee;

-- nvl �Լ��� ������� �ʰ� ��ü ������ ���. (null�� ���Ե� �÷��� ������ �����ϸ� null)
    -- null�� 0���� ó���ؼ� �����ؾ���.    : NVL
select eno �����ȣ, ename �����, salary ����, commission ���ʽ�,
salary * 12,
salary * 12 + commission        -- ��ü ����
from employee;

-- nvl �Լ��� ����ؼ� ����
select eno �����ȣ, ename �����, salary ����, commission ���ʽ�,
salary * 12,
salary * 12 + NVL(commission, 0)        -- ��ü ����
from employee;

-- Ư�� �÷��� ������ �ߺ� ���� �� ���
select * from employee;
select dno from employee;
select DISTINCT dno from employee;

select ename, distinct dno from employee;

-- ������ ����ؼ� �˻� (Where)

select * from employee;
select eno �����ȣ, ename �����, job ��å, manager ���ӻ��, hiredate �Ի糯¥,
    salary ����, commission ���ʽ�, dno �μ���ȣ
from employee;

-- �����ȣ�� 7788�� ����� �̸��� �˻�.
select * from employee
where eno = 7788;

select ename from employee
where eno = 7788;

-- �����ȣ�� 7788�� ����� �μ���ȣ, ���ް� �Ի糯¥�� �˻�.
select dno �μ���ȣ, salary ����, hiredate �Ի糯¥ 
from employee
where eno = 7788;

desc employee;

select *
from employee
where ename = 'SMITH';

-- ���ڵ�(�ο�) �� �����ö� 
    -- number �϶� '' �� ������ �ʴ´�.
    -- ���ڵ�����(char, varcahr2)�� ��¥(date) �� �����ö��� '' �� ó��.
    -- ��ҹ��ڸ� ����

-- �Ի糯¥�� '81/12/03' �� ��� ���
select ename, hiredate
from employee
where hiredate = '81/12/03';

-- �μ� �ڵ尡 10�� ��� ������� ���.
select ename, dno
from employee
where dno = 30;

select * from employee;

-- ������ 3000 �̻��� ����� �̸��� �μ��� �Ի糯¥�� ������ ���.
select ename, dno, hiredate, salary
from employee
where salary >= 3000;

-- NULL �˻� : is Ű���� ���.     <== ���� : = �� ����ϸ� �ȵȴ�.
select * 
from employee
where commission is null;

-- commission �� 300 �̻��� �����, ��å�� ������ ���
select ename, job, salary, commission
from employee
where commission >= 300;

-- Ŀ�̼��� ���� ����� ����� ���
select ename
from employee
where commission is null;

-- ���ǿ��� and, or, not

-- ������ 500 �̻� 2500 �̸��� ������� �����, �����ȣ, �Ի糯¥, ������ ���
select ename, eno, hiredate, salary
from employee
where salary >= 500 and salary < 2500; 

-- 1. ��å�� SALESMAN �̰ų� �μ��ڵ尡 20 �� �����, ��å, ����, �μ��ڵ� ���.
select ename, job, salary, dno
from employee
where job = 'SALESMAN' or dno = 20;

-- 2. Ŀ�̼��� ���� ����� �߿� �μ��ڵ尡 20�� ������� �̸�, �μ��ڵ�� �Ի糯¥ ���
select ename, dno, hiredate, commission
from employee
where commission is null and dno = 20;

-- 3. Ŀ�̼��� null�� �ƴ� ������� �̸�, �Ի糯¥, ���� ���
select ename, hiredate, salary, commission
from employee
where commission is not null;

-- ��¥ �˻� : 
select * from employee;

-- 1982/01/01 ~ 1983/12/31 ���̿� �Ի��� ����� �̸�, ��å, �Ի糯¥

select ename, job, hiredate
from employee
where hiredate >= '1982/01/01' and hiredate < '1983/12/31';

-- 1981�⵵�� �Ի��� ������� �̸�, ��å, �Ի糯¥
select ename, job, hiredate
from employee
where hiredate >= '1981/1/1' and hiredate < '1981/12/31';

-- �÷��� between A and B  : A�̻� B����
select ename, job, hiredate
from employee
where hiredate between '1981/1/1' and '1981/12/31';

-- IN ������

-- Ŀ�̼��� 300, 500, 1400�� ����� �̸�, ��å, �Ի����� ���
select * from employee;
select ename, job, hiredate, commission
from employee
where commission = 300 or commission = 500 or commission = 1400;

select ename, job, hiredate, commission
from employee
where commission in (300, 500, 1400);

-- like     : �÷����� Ư���� ���ڿ��� �˻�      <== �� �˻� ����� ����Ҷ� 
    -- %    : �ڿ� � ���ڰ� �͵� �������.
    -- _    : �� ���ڰ� � ���� �͵� �������.

-- F �� �����ϴ� �̸��� ���� ����� ��� �˻� �ϱ�.
select * from employee
where ename like 'F%';

-- �̸��� ES�� ������ ����� �˻��ϱ�.
select ename from employee
where ename like '%ES';

-- J�� ���۵ǰ� J���� �α��ڰ� ����� �͵� ������� ��� ���. �ڿ��� ES�� ��������.
select ename 
from employee
where ename like 'J__ES';

-- ������ ���ڰ� R�� ������ ��� ����ϱ�
select *
from employee
where ename like '%R';

-- MAN �ܾ �� ��å�� ���
select job
from employee
where job like '%MAN%';

-- 81�⵵�� �Ի��� ����� ����ϱ�.
select *
from employee
where hiredate >= '81/1/1' and hiredate < '81/12/31';

select *
from employee
where hiredate between '81/1/1' and '81/12/31';

select *
from employee
where hiredate like '81%';

-- 81�� 2���� �Ի��� ����� ���
select *
from employee
where hiredate like '81/02%';

-- ���� : order by, asc(�������� ����) : �⺻, des(�������� ����)

select *
from employee
order by eno;       --asc ������

select *
from employee
order by eno asc;

select *
from employee
order by eno desc;

-- �̸� �÷��� ����
select *
from employee
order by ename desc;

-- ��¥����
select *
from employee
order by hiredate desc;

-- �����亯�� �Խ��ǿ��� �ַ� ���. �� �� �̻��� �÷��� �����Ҷ�
select * from employee
order by dno desc;

-- �� ���� �÷��� ���� : ���� ó�� �÷��� ������ �ϰ�, ������ ���� ���ؼ� �ι�° �÷��� ����.

select dno, ename
from employee
order by dno, ename;

select dno, ename
from employee
order by dno desc, ename desc;

-- where ���� order by ���� ���� ���� ��.

select *
from employee
where commission is null
order by ename desc;

-- �پ��� �Լ� ����ϱ�
/*
    1. ���ڸ� ó���ϴ� �Լ�
        - UPPER : �빮�ڷ� ��ȯ
        - LOWER : �ҹ��ڷ� ��ȯ
        - INITCAP : ù�ڴ� �빮�ڷ� �������� �ҹ��ڷ� ��ȯ
*/

select '�ȳ��ϼ���' as �ȳ�
from dual;

select 'Oracle mania' , upper('Oracle mania'),lower('Oracle mania'), Initcap('Oracle mania')
from dual;

select * from employee;

select ename, lower(ename), initcap(ename) ,upper(ename)
from employee;

select * from employee
where ename = 'allen';      -- �˻��� �ȵ�.

select * from employee
where lower(ename) = 'allen';  

select * from employee
where initcap(ename) = 'Allen';

select ename, initcap (ename) from employee
where initcap(ename) = 'Allen';

-- ���� ���̸� ��� �ϴ� �Լ�
    -- length : ������ ���̸� ��ȯ, �����̳� �ѱ� ������� ���ڼ��� ����
    
    -- lengthb : ������ ���̸� ��ȯ, �ѱ� 3byte�� ��ȯ
    
select length ('Oracle mania'),length('����Ŭ �ŴϾ�') from dual;

select lengthb ('Oracle mania'),lengthb('����Ŭ �ŴϾ�') from dual;

select * from employee ;

select ename, length(ename), job, length(job) from employee;

-- ���� ���� �Լ�
    -- concat : ���ڿ� ���ڸ� �����ؼ� ���
    -- substr : ���ڸ� Ư�� ��ġ���� �߶���� �Լ� (����, �ѱ� ��� 1byte�� ó��)
    -- substrb : ���ڸ� Ư�� ��ġ���� �߶���� �Լ� (������ 1byte, �ѱ��� 3byte�� ó��)
    -- instr    : ������ Ư�� ��ġ�� �ε��� ���� ��ȯ
    -- instrb   : ������ Ư�� ��ġ�� �ε��� ���� ��ȯ(������ 1byte, �ѱ��� 3byte�� ó��)
    -- 1pad, rpad : �Է� ���� ���ڿ����� Ư���� ���ڸ� ����
    -- trm      : �߶󳻰� ���� ���ڸ� ��ȯ
    
select 'Oracle', 'mania', concat ('Oracle' , 'mania') from dual;

select * from employee;

select concat ( ename, ' ' || job) from employee;

select '�̸��� : ' || ename || ' �̰�, ��å�� : ' || job || ' �Դϴ�' from employee;

select ' �̸��� : ' || ename || ' �̰�, ��å�� : ' || job || ' �Դϴ�' as �÷����� from employee;

select '�̸��� : ' || ename || ' �̰�, ���ӻ������� : ' || manager || ' �Դϴ�' as ���ӻ����� from employee;

-- substr (���, ������ġ, ���ⰹ��) : Ư����ġ���� ���ڸ� �߶�´�.
select 'Oracle Mania', substr ('Oracle mania', 4,3), substr('����Ŭ �ŴϾ�', 2,4) from dual; 

select 'Oracle Mania', substr ('Oracle mania', -4,3), substr('����Ŭ �ŴϾ�', -6,4) from dual; 

select ename, substr (ename,2,3) , substr(ename, -5,2) from employee;

select substrb('Oracle Mania',3,3), substrb ('����Ŭ �ŴϾ�', 4,6) from dual;

-- �̸��� N���� ������ ����� ��� �ϱ�(substr �Լ��� ����ؼ� )
select ename from employee
where substr (ename,-1,1) = 'N';

-- 87�⵵ �Ի��� ����� ��� �ϱ� (substr �Լ��� ���)
select * from employee
where substr (hiredate,1,2) = '87';

select * from employee
where hiredate like '87%';

-- instr (���, ã�� ����, ������ġ, ���° �߰�) : ��󿡼� ã�� ������ �ε������� ���.

select 'Oracle mania' , instr('Oracle mania', 'a') from dual;

select 'Oracle mania' , instr('Oracle mania', 'a',5,2) from dual;

select 'Oracle mania' , instr('Oracle mania', 'a',-5,1) from dual;

select distinct instr (job, 'A', 1, 1) from employee
where job = 'MANAGER';

-- lpad, rpad : Ư�� ���̸�ŭ ���ڿ��� �����ؼ� ����, �����U�� ������ Ư�� ���ڷ� ó��
    -- lpad( ���, �÷��� ���ڿ� ũ��, Ư����������)
select lpad (1234, 10, '#') from dual;
select rpad (1234, 10, '#') from dual;

select lpad (salary, 10, '*') from employee;
select rpad (salary , 10, '*') from employee;

-- TRIM : ��������, Ư�� ���ڵ� ����
    -- LTRIM    : ������ ������ ����
    -- RTRIM    : �������� ������ ����
    -- TRIM     : ����, ������ ������ ����

select ltrim('   Oracle mania    ') a, rtrim('   Oracle mania    ') b, trim('   Oracle mania    ') c  from dual;

-- ������ Ÿ�� Ȯ�� ��� / not null�� �ݵ�� �ԷµǾ�� �ϴ� ��
desc employee;

--1. ���� �����ڸ� ����Ͽ� ��� ����� ���ؼ� $300�� �޿� �λ��� ������� ����̸�, �޿�, �λ�� �޿��� ����ϼ���. 
select ename, salary, salary+300 as "�λ�� �޿�"
from employee;

--2. ����� �̸�, �޿�, ���� �� ������ ������ ���� ���������� ��� �Ͻÿ�. ���� �� ������ ���޿� 12�� ������ $100�� �󿩱��� ���ؼ� ��� �Ͻÿ�. // Ʋ��
select ename, salary, commission, salary*12 + NVL(commission,0)+ 100 as "���� �� ����"
from employee
order by salary desc;

--3. �޿��� 2000�� �Ѵ� ����� �̸��� �޿��� �޿��� ������ ���� ���������� ����ϼ���. 
select ename, salary        -- �÷���
from employee               -- ���̺�, ��
where salary >= 2000        -- ����
order by salary desc;       -- ����

--4. �����ȣ�� 7788�� ����� �̸��� �μ���ȣ�� ����ϼ���. 
select ename, dno
from employee
where eno = 7788;

--5. �޿��� 2000���� 3000���̿� ���Ե��� �ʴ� ����� �̸��� �޿��� ��� �ϼ���. // Ʋ��
select ename, salary
from employee
where salary not between 2000 and 3000;

--6. 1981�� 2�� 20�Ϻ��� 81�� 5�� 1�� ������ �Ի��� ����� �̸� ������, �Ի����� ����Ͻÿ�
select ename, job, hiredate
from employee
where hiredate between '81/02/20' and '81/05/01';
--7. �μ���ȣ�� 20�� 30�� ���� ����� �̸��� �μ���ȣ�� ����ϵ� �̸��� ����(��������)���� ����Ͻÿ�. // Ʋ��
select ename, dno
from employee
where dno in (20, 30)
order by ename desc;

--8. ����� �޿��� 2000���� 3000���̿� ���Եǰ� �μ���ȣ�� 20 �Ǵ� 30�� ����� �̸�, �޿��� �μ���ȣ�� ����ϵ� �̸��� ������������ ����ϼ���. 
select ename, salary, dno
from employee
where (salary between 2000 and 3000) and (dno in (20,30))
order by ename asc;

--9. 1981�⵵ �Ի��� ����� �̸��� �Ի����� ��� �Ͻÿ� ( like �����ڿ� ���ϵ� ī�� ���)
select ename, hiredate
from employee
where hiredate like '81/%';

--10. �����ڰ� ���� ����� �̸��� �������� ����ϼ���.
select ename, job
from employee
where manager is null;

--11. Ŀ�Լ��� ���� �� �ִ� �ڰ��� �Ǵ� ����� �̸�, �޿�, Ŀ�̼��� ����ϵ� �޿��� Ŀ�Լ��� �������� �������� �����Ͽ� ǥ���Ͻÿ�. 
select ename, salary, commission
from employee
where commission is not null
order by salary desc, commission desc;

--12. �̸��� ����° ������ R�� ����� �̸��� ǥ���Ͻÿ�. 
select ename
from employee
where ename like '__R%';

--13. �̸��� A �� E �� ��� �����ϰ� �ִ� ����� �̸��� ǥ���Ͻÿ�. 
select ename
from employee
where ename like '%A%' and ename like '%E%';

--14. ��� ������ �繫��(CLERK) �Ǵ� �������(SALESMAN)�̸缭 �޿��� $1600, $950, �Ǵ� $1300 �� �ƴ� ����� �̸�, ������, �޿��� ����Ͻÿ�. 
select ename, job, salary
from employee
where job in ('CLERK','SALESMAN') and salary not in (1600,950,1300);
-- where (job = 'CLERK' or job = 'SALESMAN') and salary not in (1600,950,1300);

--15. Ŀ�̼��� $500�̻��� ����� �̸��� �޿� �� Ŀ�̼��� ����Ͻÿ�.  
select ename, salary, commission
from employee
where commission >= 500;