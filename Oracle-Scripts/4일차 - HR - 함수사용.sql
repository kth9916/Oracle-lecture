-- 4����
/*
    �׷� �Լ� : ������ ���� ���ؼ� �׷����ؼ� ó���ϴ� �Լ�
        group by ���� Ư�� �÷��� ������ ���, �ش� �÷��� ������ ������ �׷����ؼ� ������ ����.
        
    ���� �Լ� :
            - SUM : �׷��� �հ�
            - AVG : �׷��� ���
            - MAX : �׷��� �ִ밪
            - MIN : �׷��� �ּҰ�
            - COUNT : �׷��� �� ���� (���ڵ� �� record, �ο� �� row)
*/

select sum(salary), round (avg (salary),2), max (salary), min (salary)
from employee;

-- ���� : ���� �Լ��� ó���� ��, ��� �÷��� ���� ������ ������ �÷��� ���� 

select sum (salary)
from employee;

select ename
from employee;

select * from employee;

-- �����Լ��� null ���� ó���ؼ� �����Ѵ�.
select sum (commission), avg(commission), max(commission), min(commission)
from employee;

-- count() : ���ڵ� ��, �ο� ��
    -- NULL�� ó������ �ʴ´�.
    -- ���̺��� ��ü ���ڵ� ���� ������ ��� : count(*) �Ǵ� NOT NULL �÷��� count ()
    
desc employee;

select eno from employee;
select count (eno) from employee;

select commission from employee;
select count(commission) from employee;

select count (*) from employee;
select * from employee;

-- ��ü ���ڵ� ī��Ʈ 
select count (*) from employee;
select count (eno) from employee;

-- �ߺ����� �ʴ� ������ ���� (job)

select job from employee;

select count(distinct job) from employee;

-- �μ��� ���� (dno)
select count (distinct dno) from employee;

-- group by : Ư�� �÷��� ���� �׷��� �Ѵ�. �ַ� �����Լ��� select ������ ���� ����մϴ�.
/*
    select �÷���, �����Լ� ó���� �÷�
    from ���̺�
    where ����
    group by �÷���
    having ���� ( group by�� ����� ����)
    order by ����
*/

-- �μ��� ��� �޿�
select dno as �μ���ȣ , avg(salary) as ��ձ޿�
from employee
group by dno;       -- dno �÷��� �ߺ��� ���� �׷�����.

select dno from employee order by dno;

-- ��ü ��� �޿�.
select avg (salary) as ��ձ޿�
from employee;

-- group by�� ����ϸ鼭 select ���� ������ �÷��� �� �����ؾ� �Ѵ�.
select dno ,count(dno), sum(salary), avg(salary), max(commission), min(commission)
from employee
group by dno
order by dno asc;

-- 
select job from employee;

-- ������ ��å�� �׷����ؼ� ������ ���, �հ�, �ִ밪, �ּҰ��� ���.
select job, round(avg(salary)) as "������ ���", sum(salary) as "������ �հ�", max(salary) as "������ �ִ밪", min(salary) as "������ �ּҰ�"
from employee
group by job
order by job;

-- ���� �÷��� �׷��� �ϱ�

select dno, job, count(*), sum(salary)
from employee
group by dno, job;          -- �� �÷� ��� ��ġ�ϴ� ���� �׷���

select dno, job
from employee
where dno = 20 and job = 'CLERK';

-- having : group by ���� ���� ����� �������� ó�� �� �� as ���� ��Ī�� having�� ������ �ȵȴ�.

-- �μ��� ������ �հ谡 9000 �̻��� �͸� ���. 
select dno, count(*), sum(salary) as �μ����հ�, round(avg(salary),2) as �μ������
from employee
group by dno
having sum(salary) > 9000 ;

-- �μ��� ������ ����� 2000 �̻� ���.
select dno, count(*), sum(salary) as �μ����հ�, round(avg(salary),2) as �μ������
from employee
group by dno
having round(avg(salary),2) > 2000.00 ;

-- where �� having ���� ���� ���Ǵ� ���
    -- where : ���� ���̺��� �������� �˻�
    -- having : group by ����� ���ؼ� ������ ó��
    
select * from employee;

-- ������ 1500 ���ϴ� �����ϰ� �� �μ����� ������ ����� ���ϵ� ������ ����� 2500�̻��� �͸� ����϶�.

select dno, count(*), round(avg(salary)) as �μ������
from employee
where salary > 1500
group by dno
having round(avg(salary)) > 2500;

-- ROLLUP
-- CUBE
    -- Group by ������ ����ϴ� Ư���� �Լ� 
    -- ���� �÷��� ������ �� �ִ�.
    -- group by ���� �ڼ��� ������ ���...

--rollup, cube�� ������� �ʴ� ���
select dno ,count(*), sum(salary), round(avg(salary))
from employee
group by dno
order by dno;

-- Rollup : �μ��� �հ�� ����� ��� ��, ������ ���ο� ��ü �հ�, ���
select dno ,count(*), sum(salary), round(avg(salary))
from employee
group by rollup(dno)
order by dno;

-- cube : �μ��� �հ�� ����� ��� ��, ������ ���ο� ��ü �հ�, ���
select dno ,count(*), sum(salary), round(avg(salary))
from employee
group by cube(dno)
order by dno;

-- Rollup : �� �÷��̻�
select dno, job, count(*), MAX(salary), sum(salary), round(avg(salary))
from employee
group by rollup(dno, job);      -- �ΰ��� �÷��� �����, �� �÷��� ���ļ� ������ �� �׷���.

-- Rollup ���� ���
select dno, job, count(*), MAX(salary), sum(salary), round(avg(salary))
from employee
group by dno, job
order by dno asc;

-- cube
select dno, job, count(*), MAX(salary), sum(salary), round(avg(salary))
from employee
group by cube(dno, job)
order by dno asc;

-- join : ���� ���̺��� ���ļ� �� ���̺��� �÷��� �����´�. 
    -- department�� employee�� ������ �ϳ��� ���̺��̾�����, �𵨸�(�ߺ�����, �������)�� ���ؼ� �����̺��� �и�
    -- �� ���̺��� ����Ű �÷� (dno) , employee ���̺��� dno �÷��� department ���̺��� dno �÷��� �����Ѵ�.
    -- �ΰ� �̻��� ���̺��� �÷��� Join������ ����ؼ� ���.
   
select * from department; -- �μ������� �����ϴ� ���̺�
select * from employee;    -- ��������� �����ϴ� ���̺�

-- EQUI JOIn : ����Ŭ���� ���� ���� ����ϴ� JOIN, Oracle������ ��� ����
    -- from �� : ������ ���̺��� " , " �� ó��,
    -- where �� : �� ���̺��� ������ Ű �÷��� " = "�� ó��
        -- and �� : ������ ó��
    -- on �� : �� ���̺��� ������ Ű �÷��� " = " �� ó��
        -- where�� : ������ ó��

-- where�� : ���� Ű �÷��� ó���� ��� 
select *
from employee,department
where department.dno = employee.dno         -- ���� Ű ����
and job = 'MANAGER';                        -- ������ ó��

-- ANSI ȣȯ : [INNER] JOIN         <== ��� SQL���� ��� ������ ���� ���
-- ON �� : ���� Ű �÷��� ó���� ���
    -- ON �� : �� ���̺��� ������ Ű �÷��� " = " �� ó��
        -- where �� : ������ ó��
        
select *
from employee e INNER join department d
on e.dno = d.dno
where job = 'MANAGER';

-- Join�� ���̺� �˸��( ���̺� �̸��� ��Ī���� �ΰ� ���� ���)
select *
from employee e, department d
where e.dno = d.dno
and salary > 1500;

-- select ������ ������ Ű �÷��� ��½ÿ� ��� ���̺��� �÷����� ��� : dno
select eno, job, d.dno, dname
from employee e, department d
where e.dno = d.dno;

-- �� ���̺��� JOiN�ؼ� �μ���[��](dname)�� ������ �ִ밪�� ����� ������.
select dname, count(*), max(salary)
from employee e, department d
where e.dno = d.dno
group by dname;

-- NATURAL JOIN : ORacle 9i ����
    -- EQUI JOIN�� where���� ���� : �� ���̺��� ������ Ű �÷��� ���� " = "
    -- ������ Ű �÷��� Oracle ���������� �ڵ����� �����ؼ� ó��
    -- ���� Ű �÷��� ��Ī �̸��� ����ϸ� ������ �߻�.
    -- �ݵ�� ���� Ű �÷��� ������ Ÿ���� ���ƾ� �Ѵ�.
    -- from ���� natural join Ű���带 ���
    
        
select e.eno, e.ename, d.dname, dno
from employee e natural join department d;

-- ���� : select ���� ����Ű �÷��� ��½� ���̺���� ����ϸ� ���� �߻�.

-- EQUI JOIN vs NATURAL JOIN�� ���� Ű �÷� ó��
    -- EQUI JOIN : select���� �ݵ�� ���� Ű �÷��� ����� �� ���̺���� �ݵ�� ���.
    -- NATURAL JOIN : select���� �ݵ�� ���� Ű �÷��� ����� �� ���̺���� �ݵ�� ������� �ʾƾ� �Ѵ�.

--EQUI
select ename, salary, dname, d.dno      -- e.dno : EQUI JOIN������ ���
from employee e, department d
where e.dno = d.dno
and salary > 2000;

-- NUTURAL
select ename, salary, dname, dno            -- dno : Natural Join ������ ���̺���� ����ϸ� �ȵȴ�.
from employee e natural join department d
where salary > 2000;

-- ANSI : INNER JOIN
select ename, salary, dname, e.dno
from employee e join department d
on e.dno = d.dno
where salary > 2000;

-- non EQUI JOIN  : EQUI JOIN���� where ���� "="�� ������� �ʴ� Join

select * from salgrade; : ������ ����� ǥ�� �ϴ� ���̺�

select ename, salary, grade
from employee, salgrade
where salary between losal and hisal;

-- ���̺� 3�� ����
select ename, dname, salary, grade
from employee e, department d, salgrade s
where e.dno = d.dno 
and salary between losal and hisal;




