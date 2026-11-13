create table member (
    member_id   serial primary key,
    first_name  varchar(50)  not null,
    last_name   varchar(50)  not null,
    email       varchar(120) unique,
    joined_on   date not null default current_date
);

create table author (
    author_id  serial primary key,
    name       varchar(120) not null
);

create table book (
    isbn       char(13) primary key,
    title      varchar(200) not null,
    published  smallint check (published between 1450 and 2100)
);

create table book_author (
    isbn       char(13) references book (isbn),
    author_id  int references author (author_id),
    primary key (isbn, author_id)
);

create table copy (
    copy_id    serial primary key,
    isbn       char(13) not null references book (isbn),
    branch     varchar(50) not null,
    condition  varchar(10) not null default 'good' check (condition in ('good', 'worn', 'damaged', 'lost'))
);

create table loan (
    loan_id      serial primary key,
    copy_id      int not null references copy (copy_id),
    member_id    int not null references member (member_id),
    borrowed_on  date not null default current_date,
    due_on       date not null default current_date + 21,
    returned_on  date,
    check (returned_on is null or returned_on >= borrowed_on)
);

-- only one open loan per copy
create unique index one_open_loan_per_copy on loan (copy_id) where returned_on is null;

create table hold (
    hold_id    serial primary key,
    isbn       char(13) not null references book (isbn),
    member_id  int not null references member (member_id),
    placed_on  timestamp not null default now(),
    unique (isbn, member_id)
);

create table fine (
    fine_id   serial primary key,
    loan_id   int not null references loan (loan_id),
    amount    numeric(6, 2) not null check (amount > 0),
    paid      boolean not null default false
);
