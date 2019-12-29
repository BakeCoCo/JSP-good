CREATE TABLE `javaam`.`memoList`(  
  `idx` INT NOT NULL AUTO_INCREMENT,
  `name` CHAR(20) NOT NULL,
  `password` CHAR(20) NOT NULL,
  `memo` VARCHAR(500) NOT NULL,
  `writeDate` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idx`)
) CHARSET=utf8;

ALTER TABLE `javaam`.`memolist`   
  CHANGE `writeDate` `writeDate` TIMESTAMP DEFAULT CURRENT_TIMESTAMP  NULL,
  ADD COLUMN `ip` CHAR(15) NULL AFTER `writeDate`;
  
SELECT * FROM memoList ORDER BY idx DESC;
SELECT * FROM memoList ORDER BY idx DESC LIMIT 10, 10;

DELETE FROM memoList;

INSERT INTO memoList (NAME, PASSWORD, memo, ip) VALUES ('홍길동', '1111', '1등입니다.', '192.168.100.1');
INSERT INTO memoList (NAME, PASSWORD, memo, ip) VALUES ('임꺽정', '2222', '2등입니다.', '192.168.100.2');
INSERT INTO memoList (NAME, PASSWORD, memo, ip) VALUES ('장길산', '3333', '3등입니다.', '192.168.100.3');
INSERT INTO memoList (NAME, PASSWORD, memo, ip) VALUES ('일지매', '4444', '4등입니다.', '192.168.100.4');

SELECT COUNT(*) FROM memoList;