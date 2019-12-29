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
select count(*) from guestbook where memo like '%1등%';
select count(*) from guestbook where name like '%길%';
select count(*) from guestbook where name like '%둘%' or memo like '%둘%';
select * from guestbook where name like '%둘%' or memo like '%둘%';

delete from guestbook;
drop sequence guestbook_idx_seq;
create sequence guestbook_idx_seq;

insert into guestbook (idx, name, password, memo, ip) 
values (guestbook_idx_seq.nextval, '홍길동', '1111', '1등 입니다.', '192.168.100.101');
insert into guestbook (idx, name, password, memo, ip) 
values (guestbook_idx_seq.nextval, '임꺽정', '2222', '2등 입니다.', '192.168.100.102');
insert into guestbook (idx, name, password, memo, ip) 
values (guestbook_idx_seq.nextval, '장길산', '3333', '3등 입니다.', '192.168.100.103');
insert into guestbook (idx, name, password, memo, ip) 
values (guestbook_idx_seq.nextval, '일지매', '4444', '4등 입니다.', '192.168.100.104');

-- 디벨로퍼에서 작업한 결과는 jsp에 바로 적용되지 않는다. => 반드시 작업 완료 후 commit 명령을 실행해야 적용된다.
commit;

select * from (
  select rownum rnum, GG.* from (
    select * from guestbook order by idx desc
  ) GG where rownum <= 20
) where rnum >= 11;
