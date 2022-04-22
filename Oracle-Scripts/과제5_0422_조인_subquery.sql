subquery ����. 

Join ����.
�Ϸ� �ð� : 6:20�б���. 
select * from employee;
7. SELF JOIN�� ����Ͽ� ����� �̸� �� �����ȣ�� ������ �̸� �� ������ ��ȣ�� �Բ� ��� �Ͻÿ�. 
 	������ ��Ī���� �ѱ۷� �����ÿ�. 

select e.ename as "����� �̸�", e.eno as �����ȣ, m.ename as "������ �̸�", e.manager as "������ ��ȣ"
from employee e, employee m
where e.manager = m.eno;


8. OUTER JOIN, SELF JOIN�� ����Ͽ� �����ڰ� ���� ����� �����Ͽ� �����ȣ�� �������� �������� �����Ͽ� ��� �Ͻÿ�. 

select e.ename, m.ename
from employee e left outer join employee m
on e.manager = m.eno
order by e.eno;

9. SELF JOIN�� ����Ͽ� ������ ���('SCOTT')�� �̸�, �μ���ȣ, ������ ����� ������ �μ����� �ٹ��ϴ� ����� ����Ͻÿ�. 
   ��, �� ���� ��Ī�� �̸�, �μ���ȣ, ����� �Ͻÿ�. 

select e.ename as "���� ��� �̸�", e.dno as "���� ��� �μ���ȣ", m.ename as "���Ϻμ� �������"
from employee e, employee m
where e.ename = 'SCOTT' and e.dno = m.dno;

10. SELF JOIN�� ����Ͽ� WARD ������� �ʰ� �Ի��� ����� �̸��� �Ի����� ����Ͻÿ�. 

select m.ename, m.hiredate
from employee e, employee m
where e.ename = 'WARD' and e.hiredate < m.hiredate;

11. SELF JOIN�� ����Ͽ� ������ ���� ���� �Ի��� ��� ����� �̸� �� �Ի����� ������ �̸� �� �Ի��ϰ� �Բ� ����Ͻÿ�. 
    ��, �� ���� ��Ī�� �ѱ۷� �־ ��� �Ͻÿ�. 
select e.ename, e.hiredate, m.ename, m.hiredate
from employee e, employee m
where e.manager = m.eno and e.hiredate < m.hiredate;

<<�Ʒ� ������ ��� Subquery�� ����Ͽ� ������ Ǫ����.>>

1. �����ȣ�� 7788�� ����� ��� ������ ���� ����� ǥ��(����̸� �� ������) �Ͻÿ�.  

select ename, job
from employee
where job = (select job from employee where eno = 7788);

2. �����ȣ�� 7499�� ������� �޿��� ���� ����� ǥ�� (����̸� �� ������) �Ͻÿ�. 

select ename, job
from employee
where salary > (select salary from employee where eno = 7499);

3. �ּ� �޿��� �޴� ���޺� ����� �̸�, ��� ���� �� �޿��� ǥ�� �Ͻÿ�(�׷� �Լ� ���)

select ename, job, salary
from employee
where salary in (select min(salary) from employee group by job );

4. ���޺� �޿� ��� �߿� ���� ���� ����� ���� ���޿��� ���� ���� �޿��� ���� ��� ���

select ename
from employee
where salary = (select min(salary) from employee group by job having avg(salary) <= all(select avg(salary) from employee group by job))

5. �� �μ��� �ּ� �޿��� �޴� ����� �̸�, �޿�, �μ���ȣ�� ǥ���Ͻÿ�.

select ename,salary, dno
from employee
where salary in (select min(salary) from employee group by dno );

6. ��� ������ �м���(ANALYST) �� ������� �޿��� �����鼭 ������ �м����� �ƴ� ������� ǥ�� (�����ȣ, �̸�, ������, �޿�) �Ͻÿ�.

select eno, ename, job, salary
from employee
where salary < (select min(salary) from employee where job = 'ANALYST') and job != 'ANALYST';

7. ���������� ���� ����� �̸��� ǥ�� �Ͻÿ�. 

select ename
from employee
where ename not in (select m.ename from employee e, employee m where e.manager = m.eno group by m.ename)

8. ���������� �ִ� ����� �̸��� ǥ�� �Ͻÿ�. 

select ename
from employee
where ename in (select m.ename from employee e, employee m where e.manager = m.eno group by m.ename)

9. BLAKE �� ������ �μ��� ���� ����� �̸��� �Ի����� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�(��, BLAKE �� ����). 

select ename, hiredate
from employee
where dno = (select dno from employee where ename = 'BLAKE');

10. �޿��� ��պ��� ���� ������� �����ȣ�� �̸��� ǥ���ϵ� ����� �޿��� ���ؼ� ���� �������� ���� �Ͻÿ�. 

select eno, ename
from employee
where salary > (select avg(salary) from employee)
order by salary asc;

11. �̸��� K �� ���Ե� ����� ���� �μ����� ���ϴ� ����� �����ȣ�� �̸��� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�. 

select eno, ename
from employee
where dno in (select dno from employee where ename like '%K%')

12. �μ� ��ġ�� DALLAS �� ����� �̸��� �μ� ��ȣ �� ��� ������ ǥ���Ͻÿ�. 
select * from department
select * from employee;

select ename, e.dno, job, loc
from employee e, department d
where e.dno = d.dno
and loc = 'DALLAS';

13. KING���� �����ϴ� ����� �̸��� �޿��� ǥ���Ͻÿ�. 

select ename, salary
from employee
where manager = (select eno from employee where ename = 'KING');

14. RESEARCH �μ��� ����� ���� �μ���ȣ, ����̸� �� ��� ������ ǥ�� �Ͻÿ�. 

select dno, ename, job
from employee
where dno = (select dno from department where dname = 'RESEARCH');

15. ��� �޿����� ���� �޿��� �ް� �̸��� M�� ���Ե� ����� ���� �μ����� �ٹ��ϴ� ����� �����ȣ, �̸�, �޿��� ǥ���Ͻÿ�. 

select eno, ename, salary
from employee
where (dno in (select dno from employee where ename like '%M%')) and (salary > (select avg(salary) from employee))

16. ��� �޿��� ���� ���� ������ ã���ÿ�. 

select job, round(avg(salary))
from employee
group by job
having avg(salary) <= all(select avg(salary) from employee group by job);

17. �������� MANAGER�� ����� �Ҽӵ� �μ��� ������ �μ��� ����� ǥ���Ͻÿ�. 

select e.ename, dname
from employee e, department d
where e.dno = d.dno
and e.dno in (select dno from employee where job = 'MANAGER')