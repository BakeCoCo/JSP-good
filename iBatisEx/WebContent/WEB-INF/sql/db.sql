create sequence person_id_seq; -- 자동으로 1씩 증가하는 시퀀스를 만든다.
drop sequence person_id_seq;   -- 자동으로 1씩 증가하는 시퀀스를 제거한다.
-- mysql 에서 자동증가 초기화 방법 : ALTER TABLE 테이블이름 AUTO_INCREMENT = 1;
CREATE TABLE PERSON(
  PER_ID NUMBER (5, 0) NOT NULL,
  PER_FIRST_NAME VARCHAR (40) NOT NULL,
  PER_LAST_NAME VARCHAR (40) NOT NULL,
  PER_BIRTH_DATE DATE ,
  PER_WEIGHT_KG NUMBER (4, 2) NOT NULL,
  PER_HEIGHT_M NUMBER (4, 2) NOT NULL,
  PRIMARY KEY (PER_ID)
);

delete from person;

select * from person;