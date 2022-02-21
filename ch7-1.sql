USE market_db ;
-- 간단한 STORED PROCEDURE 만들기
DROP PROCEDURE IF EXISTS user_proc ; 
DELIMITER $$
CREATE PROCEDURE user_proc() 
BEGIN 
   SELECT * FROM member ; 
END $$
DELIMITER ; 

-- 호출하기
CALL user_proc() ; 

-- 스토어드 프로시저의 삭제
DROP PROCEDURE user_proc ; 

-- 입력 매개변수가 있는 스토어드 프로시저의 생성
USE market_db ; 
DROP PROCEDURE IF EXISTS user_proc1 ;

DELIMITER $$
CREATE PROCEDURE user_proc1(IN userName VARCHAR(10))
BEGIN 
   SELECT * FROM member WHERE mem_name = userName ;
END $$
DELIMITER ; 

CALL user_proc1('에이핑크') ; 

-- 입력 매개변수가 두 개인 경우의 스토어드 프로시저 
DROP PROCEDURE IF EXISTS user_proc2 ; 

DELIMITER $$
CREATE PROCEDURE user_proc2(IN userNumber INT,
                            IN userHeight INT)
BEGIN 
   SELECT * FROM member 
      WHERE mem_number > userNumber AND height > userHeight ; 
END $$
DELIMITER ; 

CALL user_proc2(6, 165) ; 

-- 출력 매개변수가 있는 스토어드 프로시저 
DROP PROCEDURE IF EXISTS user_proc3 ; 

DELIMITER $$
CREATE PROCEDURE user_proc3(IN txtValue CHAR(10), OUT outValue INT)
BEGIN 
   INSERT INTO noTable VALUES(NULL, txtValue) ; 
   SELECT max(id) INTO outValue FROM noTable ; -- max(id) 값을 outValue에 할당. noTable은 아직 안만듦.
END $$
DELIMITER ; 

-- noTable 만들기
CREATE TABLE IF NOT EXISTS noTable(
   id INT AUTO_INCREMENT PRIMARY KEY, 
   txt CHAR(10) 
) ; 

-- 스토어드 프로시저 호출
CALL user_proc3('테스트1', @myvalue) ; 
SELECT CONCAT('입력된 id 값: ', @myvalue) '입력된 ID 값' ; 

-- SQL 프로그래밍의 활용
-- IFELSE문 프로시저
DROP PROCEDURE IF EXISTS ifelse_proc ; 
DELIMITER $$
CREATE PROCEDURE ifelse_proc(IN memName VARCHAR(10))
BEGIN 
   DECLARE debutYear INT ; -- 변수 선언 
   SELECT YEAR(debut_date) INTO debutYear FROM member WHERE mem_name = memName ;
   IF (debutYear >= 2015) THEN SELECT '신인 가수' AS '메세지' ; -- 여기선 as 안쓰면 메세지가 열이름으로 안들어가네.
   ELSE SELECT '고참 가수' AS '메세지' ; 
   END IF ; 
END $$
DELIMITER ; 

CALL ifelse_proc('오마이걸') ;
CALL ifelse_proc('소녀시대') ;  

-- WHILE 문 이용 프로시저
DROP PROCEDURE IF EXISTS while_proc ; 
DELIMITER $$
CREATE PROCEDURE while_proc() 
BEGIN
   DECLARE hap INT ; -- 합계
   DECLARE num INT ; -- 1부터 100까지 증가하는 숫자
   SET hap = 0 ; 
   SET num = 1 ; 
   
   WHILE (num <= 100) DO 
      SET hap = hap + num ;
      SET num = num + 1; 
   END WHILE ; 
   
   SELECT hap AS '1부터 100까지의 합' ; 
END $$
DELIMITER ; 

CALL while_proc() ; 

-- 동적 SQL 프로시저
DROP PROCEDURE IF EXISTS dynamic_proc ; 
DELIMITER $$
CREATE PROCEDURE dynamic_proc (IN tableName VARCHAR(20))
BEGIN 
   SET @sqlQuery = CONCAT('SELECT * FROM ', tableName) ; -- 넘겨받은 테이블 이름을 이용하여  SELECT 문 완성
   PREPARE myQuery FROM @sqlQuery ; -- SELECT 문자열을 받아서 쿼리문 실행 준비
   EXECUTE myQuery ; -- 쿼리문 실행
   DEALLOCATE PREPARE myQuery ; -- 사용한 myQuery 해제 
END $$
DELIMITER ; 

CALL dynamic_proc('member') ; 
CALL dynamic_proc('buy') ; 

