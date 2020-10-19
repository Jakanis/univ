create table hibernate_sequence
(
    next_val bigint
);
insert into hibernate_sequence
values (69);
create table company_service
(
    id bigint not null,
    negotiated bit not null,
    price integer,
    company_id bigint,
    service_id bigint,
    primary key (id)
);
create table feedback_grade
(
    id bigint not null,
    feedback varchar(255),
    grade tinyint,
    company_id bigint,
    user_id bigint,
    primary key (id)
);
create table hist
(
    id bigint not null,
    company_comment varchar(255),
    done bit not null,
    price integer,
    user_comment varchar(255),
    company_service_id bigint,
    user_id bigint,
    primary key (id)
);
create table my_service
(
    id bigint not null,
    description varchar(255),
    description_ua varchar(255),
    name varchar(255),
    name_ua varchar(255),
    proved bit not null,
    primary key (id)
);
create table user_role
(
    user_id bigint not null,
    roles varchar(255)
);
create table usr
(
    id bigint not null,
    activation_code varchar(255),
    active bit not null,
    email varchar(255),
    password varchar(255),
    username varchar(255),
    primary key (id)
);
alter table company_service
    add constraint company_service_company_fk
        foreign key (company_id) references usr (id);
alter table company_service
    add constraint company_service_service_fk
        foreign key (service_id) references my_service (id);
alter table feedback_grade
    add constraint feedback_grade_company_fk
        foreign key (company_id) references usr (id);
alter table feedback_grade
    add constraint feedback_grade_user_fk
        foreign key (user_id) references usr (id);
alter table hist
    add constraint hist_company_service_kf
        foreign key (company_service_id) references company_service (id);
alter table hist
    add constraint hist_user_fk
        foreign key (user_id) references usr (id);
alter table user_role
    add constraint user_role_user_fk
        foreign key (user_id) references usr (id);
