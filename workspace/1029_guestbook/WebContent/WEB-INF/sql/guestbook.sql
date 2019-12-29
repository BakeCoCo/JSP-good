CREATE TABLE "GUESTBOOK" (
  "IDX" NUMBER(*,0) NOT NULL, 
	"NAME" CHAR(20 BYTE) NOT NULL, 
	"PASSWORD" CHAR(20 BYTE) NOT NULL, 
	"MEMO" VARCHAR2(500 BYTE) NOT NULL, 
	"WRITEDATE" TIMESTAMP (6) DEFAULT sysdate, 
	"IP" CHAR(15 BYTE), 
	 PRIMARY KEY ("IDX")
);

select * from guestbook order by idx desc;
select count(*) from guestbook;
select count(*) from guestbook where memo like '%1��%';
select count(*) from guestbook where name like '%��%';
select count(*) from guestbook where name like '%��%' or memo like '%��%';
select * from guestbook where name like '%��%' or memo like '%��%';

delete from guestbook;
drop sequence guestbook_idx_seq;
create sequence guestbook_idx_seq;

insert into guestbook (idx, name, password, memo, ip) 
values (guestbook_idx_seq.nextval, 'ȫ�浿', '1111', '1�� �Դϴ�.', '192.168.100.101');
insert into guestbook (idx, name, password, memo, ip) 
values (guestbook_idx_seq.nextval, '�Ӳ���', '2222', '2�� �Դϴ�.', '192.168.100.102');
insert into guestbook (idx, name, password, memo, ip) 
values (guestbook_idx_seq.nextval, '����', '3333', '3�� �Դϴ�.', '192.168.100.103');
insert into guestbook (idx, name, password, memo, ip) 
values (guestbook_idx_seq.nextval, '������', '4444', '4�� �Դϴ�.', '192.168.100.104');

-- �𺧷��ۿ��� �۾��� ����� jsp�� �ٷ� ������� �ʴ´�. => �ݵ�� �۾� �Ϸ� �� commit ����� �����ؾ� ����ȴ�.
commit;

select * from (
  select rownum rnum, GG.* from (
    select * from guestbook order by idx desc
  ) GG where rownum <= 20
) where rnum >= 11;
