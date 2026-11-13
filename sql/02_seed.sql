insert into member (first_name, last_name, email) values
    ('Mia', 'Nguyen', 'mia.n@example.com'),
    ('Jack', 'Thompson', 'jackt@example.com'),
    ('Leila', 'Karimi', 'leila.k@example.com');

insert into author (name) values ('Tim Winton'), ('Markus Zusak'), ('Liane Moriarty');

insert into book values
    ('9780143567998', 'Cloudstreet', 1991),
    ('9780330423304', 'The Book Thief', 2005),
    ('9781405919357', 'Big Little Lies', 2014);

insert into book_author values ('9780143567998', 1), ('9780330423304', 2), ('9781405919357', 3);

insert into copy (isbn, branch) values
    ('9780143567998', 'Parramatta'), ('9780143567998', 'Penrith'),
    ('9780330423304', 'Parramatta'), ('9781405919357', 'Campbelltown');

insert into loan (copy_id, member_id, borrowed_on, due_on, returned_on) values
    (1, 1, current_date - 40, current_date - 19, null),
    (3, 2, current_date - 10, current_date + 11, null),
    (4, 3, current_date - 60, current_date - 39, current_date - 30);

insert into fine (loan_id, amount) values (3, 4.50);
