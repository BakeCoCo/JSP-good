# INSERT INTO 테이블명(필드명) VALUES (데이터);
INSERT INTO memo(NAME,PASSWORD,memo) VALUES ("강아지","111","멍멍");
INSERT INTO memo(NAME,PASSWORD,memo) VALUES ("고양이",PASSWORD("222"),"야옹야옹");
INSERT INTO memo(NAME,PASSWORD,memo) VALUES ("메뚜기",PASSWORD("333"),"메뚝메뚝");
# PASSWORD() : 괄호 안의 내용을 암호화 해서 저장한다. 필드 크기를 45정도로 지정한다.
# AUTO_INCREMENT 초기화 방법
ALTER TABLE memo AUTO_INCREMENT = 1;

# SELETE 필드명 FROM 테이블명 [WHERE 조건식] [ORDER BY 정렬기준];
SELECT * FROM memo; # ★★★★★ 전체 보기, "*"은 모든 필드를 의미한다.
SELECT NAME AS "별명" FROM memo; # 필드명에 별명 지정
SELECT COUNT(*) FROM memo; # ★★★★★ 전체 레코드의 개수
SELECT COUNT(*) AS "인원수" FROM memo;
SELECT SUM(idx) AS "합계" FROM memo; # 합계
SELECT AVG(idx) AS "평균" FROM memo; # 평균
SELECT MAX(idx) AS "최대값" FROM memo; # 최대값
SELECT MIN(idx) AS "최소값" FROM memo; # 최소값
SELECT DISTINCT NAME FROM memo; # 중복되는 내용은 1번만 출력한다.
SELECT COUNT(DISTINCT NAME) AS "전체 동물수" FROM memo;
SELECT * FROM memo WHERE NAME = "메뚜기"; # 단순조건
SELECT * FROM memo WHERE PASSWORD = "111"; 
SELECT * FROM memo WHERE PASSWORD = PASSWORD("222");  # ★★★★★
SELECT * FROM memo WHERE NAME = "강아지" OR NAME = "고양이"; # OR 조건
SELECT * FROM memo WHERE NAME = "강아지" || NAME = "고양이"; # OR 조건
SELECT * FROM memo WHERE NAME IN ("강아지","메뚜기"); # OR 조건가 같은 IN 연산자
SELECT * FROM memo WHERE NOT(NAME = "강아지" OR NAME = "고양이"); # OR 조건의 부정
SELECT * FROM memo WHERE NAME NOT IN ("강아지","메뚜기"); # NOT IN 연산자
SELECT * FROM memo WHERE idx >= 10 AND idx <= 20; # AND 조건
SELECT * FROM memo WHERE idx >= 10 && idx <= 20; # AND 조건
SELECT * FROM memo WHERE idx BETWEEN 10 AND 15; # AND 조건과 같은 BETWEEN 연산자
# 부분일치 연산자 : LIKE
# 부분일치 연산은 와일드(대체) 카드 문자와 같이 사용된다.
# 와일드 카드 문자 : %(여러 문자), _(1문자)
SELECT * FROM memo WHERE NAME LIKE "고%"; # "고"로 시작하는
SELECT * FROM memo WHERE NAME LIKE "%지"; # "지"로 끝나는
SELECT * FROM memo WHERE NAME LIKE "%뚜%"; # ★★★★★ "뚜"를 포함하는
SELECT * FROM memo WHERE NAME LIKE "_아_"; # 3글자 중에서 2번째 글자가 "아"인
SELECT * FROM memo ORDER BY NAME; # 이름의 오름차순 정렬, ASC를 생략해도 오름차순
SELECT * FROM memo ORDER BY idx ASC; # 글번호의 오름차순 정렬
SELECT * FROM memo ORDER BY idx DESC; # 글번호의 내림차순 정렬
SELECT * FROM memo ORDER BY NAME, idx DESC;
# 이름의 오름차순 정렬, 이름이 같으면 글번호의 내림차순 정렬
SELECT * FROM memo ORDER BY idx LIMIT 0, 10; # 0번 글 부터 10개를 출력
SELECT * FROM memo ORDER BY idx DESC LIMIT 0, 10; # ★★★★★ 0번 글 부터 10개를 출력

# DELETE FROM 테이블명 [WHERE 조건식];
DELETE FROM memo; # 조건식을 안적으면 모든 데이터가 삭제됨에 주의하자
DELETE FROM memo WHERE idx = 5;

# UPDATE 테이블명 SET 수정할 내용 [WHERE 조건식];
UPDATE memo SET PASSWORD = "777"; # 조건식을 안적으면 모든 데이터가 수정됨에 주의하자
UPDATE memo SET memo = "음메음메" WHERE NAME = "강아지";