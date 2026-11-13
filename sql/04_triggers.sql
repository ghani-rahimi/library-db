create or replace function block_if_fines() returns trigger as $$
declare
    owed numeric;
begin
    select coalesce(sum(f.amount), 0) into owed
    from fine f join loan l using (loan_id)
    where l.member_id = new.member_id and not f.paid;

    if owed > 10 then
        raise exception 'member % owes $% in fines, pay before borrowing', new.member_id, owed;
    end if;
    return new;
end;
$$ language plpgsql;

create trigger loan_fine_check
before insert on loan
for each row execute function block_if_fines();
