create sequence memo_idx_seq;
create table memo (
    idx int not null primary key,
    name varchar2(50 char) not null,
    password varchar2(50 char) not null,
    memo varchar2(200 char) not null,
    writeDate TIMESTAMP default SYSDATE
);