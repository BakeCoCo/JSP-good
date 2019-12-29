CREATE TABLE "CATEGORY" (
  "IDX" NUMBER NOT NULL, 
	"CATEGORY" VARCHAR2(100 BYTE) NOT NULL, 
	"REF" NUMBER, 
	"LEV" NUMBER, 
	"SEQ" NUMBER, 
	PRIMARY KEY ("IDX")
);

delete from category;
drop sequence category_idx_seq;
create sequence category_idx_seq;
commit;

select * from category;
select * from category order by ref desc, seq asc;