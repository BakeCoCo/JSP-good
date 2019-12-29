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
values (mvcboard_idx_seq.nextval, '홍길동', '1등', '1등 입니다.', mvcboard_idx_seq.currval, 0, 0);
insert into mvcboard (idx, name, subject, content, ref, lev, seq) 
values (mvcboard_idx_seq.nextval, '임꺽정', '2등', '2등 입니다.', mvcboard_idx_seq.currval, 0, 0);
insert into mvcboard (idx, name, subject, content, ref, lev, seq) 
values (mvcboard_idx_seq.nextval, '장길산', '3등', '3등 입니다.', mvcboard_idx_seq.currval, 0, 0);
insert into mvcboard (idx, name, subject, content, ref, lev, seq) 
values (mvcboard_idx_seq.nextval, '일지매', '4등', '4등 입니다.', mvcboard_idx_seq.currval, 0, 0);
insert into mvcboard (idx, name, subject, content, ref, lev, seq) 
values (mvcboard_idx_seq.nextval, '류지태', '5등', '5등 입니다.', mvcboard_idx_seq.currval, 0, 0);

insert into mvcboard (idx, name, subject, content, ref, lev, seq) 
values (mvcboard_idx_seq.nextval, '류지태', '졸려', '겁나게 졸려요', 672, 1, 1);
delete from mvcboard where idx = 673;
