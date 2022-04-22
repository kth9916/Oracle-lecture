5���� - ��������

-- Sub Query : Select �� ���� Select ���� �ִ� ����.
    -- where ������ : sub query
    -- having ������ : sub query

Select ename, salary from employee;
select salary from employee where ename = 'SCOTT';

-- SCOTT�� ���� ���� ���ų� ���� ����ڸ� ����϶�. (���� ����)

select ename, salary from employee where salary >= 3000;

select ename, salary
from employee
where salary >= (select salary from employee where ename = 'SCOTT');

-- SCOTT�� ������ �μ��� �ٹ��ϴ� ����� ��� �ϱ�
select ename, dno
from employee
where dno = (select dno from employee where ename = 'SCOTT');

-- �ּ� �޿��� �޴� ����� �̸�, ������, �޿� ��� �ϱ�. (sub query)
select ename, job, salary
from employee
where salary = (select min(salary) from employee);

-- Having ���� Sub query ����ϱ�

-- 30�� �μ�(dno)���� �ּ� ������ �޴� ������� ���� �ּ� ������ �޴� �μ��� ����� �̸��� �μ���ȣ�� ������ ��� �غ�����.
select dno, min(salary), count(dno)
from employee
group by dno
having min(salary) > (select min(salary) from employee where dno=30);

-- ������ ���� ���� : sub query�� ��� ���� �� �ϳ��� ���.
                -- ������ �� ������ : >, =, >=, <, <=, <>, <=
-- ������ ���� ���� : sub query�� ��� ���� ������ ���
                -- ������ �������� ������ : in, ANY, SOME, ALL, EXISTS
                    -- IN : ���� ������ �� ���� ( '=' �����ڷ� ���� ���) �� ���������� ����� �߿� �ϳ��� ��ġ�ϸ� ��
                    -- ANY, SOME : ���� ������ �� ������ ���������� �˻� ����� �ϳ� �̻� ��ġ�ϸ� ��
                    -- ALL : ���� ������ �� ������ ���� ������ �˻� ����� ��� ���� ��ġ�ϸ� ��
                    -- EXIST : ���� ������ �� ������ ���� ������ ����� �߿��� �����ϴ� ���� �ϳ��� �����ϸ� ��.
                    
-- In ������ ����ϱ�
select ename, eno, dno, salary
from employee
order by dno asc;

-- �μ����� �ּ� ������ �޴� ����ڵ� ����ϱ�. (sub query�� �ݵ�� ����ؼ� ���)

select dno, min(salary), count(*)
from employee
group by dno;

select ename, dno, salary
from employee
where salary in (select min(salary) from employee group by dno);

-- ANY ������ ���
    -- ���� ������ ��ȯ�ϴ� ������ ���� ����
    -- ' < any '�� �ִ밪 ���� ������ ��Ÿ��
    -- ' > any '�� �ּҰ� ���� ŭ�� ��Ÿ��
    -- ' = any ' �� IN�� ���� ��.

��) ������ SALESMAN�� �ƴϸ鼭 �޿��� ������ SALESMAN ���� ���� ����� ���.
        -- 1600(�ִ밪) ���� ���� ��� ���(SALESMAN)�� �ƴϰ�)
select eno, ename, job, salary
from employee
where salary < any (select salary from employee where job = 'SALESMAN') and job <> 'SALESMAN';

select ename, job, salary from employee order by job;

-- ALL ������
    -- Sub query �� ��ȯ�ϴ� ��� ���� ��.
    -- ' > all ' : �ִ밪 ���� ŭ�� ��Ÿ��
    -- ' < all ' : �ּҰ� ���� ������ ��Ÿ��.
    
-- ��) ������ SALESMAN�� �ƴϸ鼭 ������ SALESMAN�� ������� �޿��� ���� ����� ��� ���.
            
            -- 1250 (�ּҰ�) ���� ���� ��� (������ SALESMAN�� �ƴ�)
                -- 
select eno, ename, job, salary
from employee
where salary < all (select salary
                    from employee
                    where job = 'SALESMAN')
                    and job <> 'SALESMAN';

-- ��� ������ �м���(ANALYST)�� ������� �޿��� �����鼭 ������ �м����� �ƴ� ����� ���
select ename
from employee
where salary < all(select salary from employee where job = 'ANALYST') and job != 'ANALYST';

-- �޿��� ��� �޿����� ���� ������� �����ȣ�� �̸��� ǥ�� �ϵ� ��� �޿��� ���ؼ� �������� �Ͻÿ�.
select salary,eno, ename
from employee
where salary > all(select avg(salary) from employee)
order by salary asc;
                    
