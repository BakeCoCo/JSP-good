CREATE TABLE "MVCBOARD" (
  "IDX" NUMBER NOT NULL, 
	"NAME" CHAR(20 BYTE) NOT NULL, 
	"SUBJECT" VARCHAR2(200 BYTE) NOT NULL, 
	"CONTENT" VARCHAR2(1000 BYTE) NOT NULL, 
	"REF" NUMBER, 
	"LEV" NUMBER, 
	"SEQ" NUMBER, 
	"HIT" NUMBER DEFAULT 0, 
	"WRITEDATE" TIMESTAMP (6) DEFAULT sysdate, 
	PRIMARY KEY ("IDX")
);

delete from mvcboard;
drop sequence mvcboard_idx_seq;
create sequence mvcboard_idx_seq;
commit;

select * from mvcboard order by idx desc;
select * from mvcboard order by ref desc, seq asc;
select count(*) from mvcboard;

insert into mvcboard (idx, name, subject, content, ref, lev, seq) 
values (mvcboard_idx_seq.nextval, 'ȫ�浿', '1��', '1�� �Դϴ�.', mvcboard_idx_seq.currval, 0, 0);
insert into mvcboard (idx, name, subject, content, ref, lev, seq) 
values (mvcboard_idx_seq.nextval, '�Ӳ���', '2��', '2�� �Դϴ�.', mvcboard_idx_seq.currval, 0, 0);
insert into mvcboard (idx, name, subject, content, ref, lev, seq) 
values (mvcboard_idx_seq.nextval, '����', '3��', '3�� �Դϴ�.', mvcboard_idx_seq.currval, 0, 0);
insert into mvcboard (idx, name, subject, content, ref, lev, seq) 
values (mvcboard_idx_seq.nextval, '������', '4��', '4�� �Դϴ�.', mvcboard_idx_seq.currval, 0, 0);
insert into mvcboard (idx, name, subject, content, ref, lev, seq) 
values (mvcboard_idx_seq.nextval, '������', '5��', '5�� �Դϴ�.', mvcboard_idx_seq.currval, 0, 0);

insert into mvcboard (idx, name, subject, content, ref, lev, seq) 
values (mvcboard_idx_seq.nextval, '������', '����', '�̳��� ������', 672, 1, 1);
delete from mvcboard where idx = 673;
