-- Q1 copies currently available at each branch
select c.branch, b.title, count(*) as available
from copy c
join book b using (isbn)
where c.condition <> 'lost'
  and not exists (select 1 from loan l where l.copy_id = c.copy_id and l.returned_on is null)
group by c.branch, b.title
order by c.branch, b.title;

-- Q2 overdue loans with days overdue
create or replace view overdue_loans as
select l.loan_id, m.first_name || ' ' || m.last_name as member, b.title, l.due_on,
       current_date - l.due_on as days_overdue
from loan l
join member m using (member_id)
join copy c using (copy_id)
join book b using (isbn)
where l.returned_on is null and l.due_on < current_date;

select * from overdue_loans order by days_overdue desc;

-- Q3 members with unpaid fines and the total owed
select m.member_id, m.first_name, m.last_name, sum(f.amount) as owed
from fine f
join loan l using (loan_id)
join member m using (member_id)
where not f.paid
group by m.member_id
order by owed desc;

-- Q4 most borrowed books in the last year
select b.title, count(*) as loans
from loan l
join copy c using (copy_id)
join book b using (isbn)
where l.borrowed_on > current_date - interval '1 year'
group by b.title
order by loans desc
limit 10;
