--
-- schema.sql
--

drop table if exists site;
drop table if exists system;
drop table if exists top500;
drop table if exists attributes;
drop table if exists specification;

create table site (
    lid integer not null primary key,
    name text not null,
    county text not null,
    continent text not null
);

create table system (
    sid integer not null primary key,
    name text not null,
    lid integer references site(id)
);

create table top500 (
    tid integer not null primary key,
    time char(6) not null,
    pos integer not null,
    sid integer references system(sid),
    unique(time, pos)
);

create table attributes (
    aid integer not null primary key,
    name text,
    dtype integer not null, -- 0: numeric, 1: text
    unique(name)
);

create table specification (
    id integer not null primary key,
    sid integer references system(sid),
    aid integer references attributes(aid),
    nval float,
    sval text,
    unique(sid, aid)
);

