# IF 문
-- produdure를 만들기 전에 만약 존재하면 없애주기. 
DROP procedure IF EXISTS ifProc1 ; 

-- stored procedure 만들기.
DELIMITER $$  
CREATE PROCEDURE ifProc1() -- ifProc 이라는 프로시져 만들기
BEGIN  
   IF 100 = 100 THEN 
      SELECT '100은 100과 같습니다.' ; 
   END IF ; 
END $$
DELIMITER ;

CALL ifProc1() ; 

# IF ELSE 문
-- ifProc이 존재하면 제거하기  
DROP PROCEDURE IF EXISTS ifProc2 ; 

-- if else문을 이용한 stored procedure 만들기
DELIMITER $$
CREATE PROCEDURE ifProc2() 
BEGIN 
   DECLARE myNum INT ; -- DECLARE를 이용하여 myNum 변수를 선언.
   SET myNum = 200 ; -- SET을 이용하여 변수에 값을 할당. 
   IF myNum = 100 THEN SELECT '100입니다.' ;
   ELSE SELECT '100이 아닙니다.' ; 
   END IF ; 
END $$
DELIMITER ; 

CALL ifProc2() ; 


# IF문의 활용
DROP PROCEDURE IF EXISTS ifProc3 ; 

DELIMITER $$
CREATE PROCEDURE ifProc3()  
BEGIN 
   DECLARE debutDate DATE ;  -- 데뷔일자 변수 생성 
   DECLARE curDate DATE ;  -- 현재날짜 변수 생성
   DECLARE days INT ; -- 활동한 일수 변수 생성
   
   SELECT debut_date INTO debutDate 
      FROM market_db.member 
      WHERE mem_id = 'APN' ;  -- debutDate 변수에 값 할당 (member 테이블에서 찾아서)
      
   SET curDate = CURRENT_DATE() ; -- curDate에 현재날짜 값 할당
   SET days = DATEDIFF(curDate, debutDate)  ; -- days에 날짜 차이값 할당 	
   
   IF (days / 365) >= 5 THEN 
      SELECT CONCAT('데뷔한 지', days, '일이나 지났습니다. 핑순이들 축하합니다!') ;  
   ELSE 
      SELECT '데뷔한 지 ' + days + '일밖에 안되었네요. 핑순이들 파이팅~!' ; 
   END IF ; 
END $$ 
DELIMITER ; 

CALL ifProc3() ; 


# 날짜 관련 함수
SELECT CURRENT_DATE() ; -- 오늘 날짜 출력
SELECT CURRENT_TIMESTAMP() ; -- 오늘 날짜 및 시간 출력
# SELECT DATEDIFF(날짜1, 날짜2) -- 두 날짜 간 차이 일수를 출력, 실행 ㄴ


# CASE 문
DROP PROCEDURE IF EXISTS caseProc ; 

DELIMITER $$
CREATE PROCEDURE caseProc()
BEGIN
   DECLARE point INT ; 
   DECLARE credit CHAR(1) ; 
   SET point = 88 ; 
   
   CASE 
      WHEN point >= 90 THEN 
         SET credit = 'A' ; 
	  WHEN point >= 80 THEN  -- 여기서 BETWEEN으로 안해도 되나? 
         SET credit = 'B' ; 
	  WHEN point >= 70 THEN
         SET credit = 'C' ; 
	  WHEN point >= 60 THEN
         SET credit = 'D' ; 
	  ELSE 
         SET credit = 'F' ; 
   END CASE ;
   
   SELECT CONCAT('취득점수 ===> ', point), CONCAT('학점 ===> ', credit) ; 
END $$ 
DELIMITER ; 

CALL caseProc ; 


# CASE문의 활용
-- 회원별로 구매액 계산하기 
SELECT mem_id, SUM(price * amount) "총구매액" 
   FROM buy 
   GROUP BY mem_id ; 
   
SELECT mem_id, SUM(price * amount) "총구매액" 
   FROM buy 
   GROUP BY mem_id 
   ORDER BY 총구매액 DESC ; 
   
SELECT B.mem_id, M.mem_name, SUM(price * amount) "총구매액"
   FROM buy B
      INNER JOIN member M 
      ON B.mem_id = M.mem_id
   GROUP BY B.mem_id
   ORDER BY 총구매액 DESC ;
   
SELECT M.mem_id, M.mem_name, SUM(price * amount) "총구매액"
   FROM buy B
      RIGHT OUTER JOIN member M 
      ON B.mem_id = M.mem_id
   GROUP BY M.mem_id  -- member 테이블의 회원 ID를 기준으로 해서
   ORDER BY 총구매액 DESC ;
   
SELECT M.mem_id, M.mem_name, SUM(price * amount) "총구매액",  
       CASE    -- 열 의 마지막에 CASE 문을 작성한다
          WHEN (SUM(price * amount) >= 1500) THEN "최우수고객" 
          WHEN (SUM(price * amount) >= 1000) THEN "우수고객" 
          WHEN (SUM(price * amount) >= 1)    THEN "일반고객"
          ELSE "유령고객" 
       END "회원등급"
   FROM buy B
      RIGHT OUTER JOIN member M 
      ON B.mem_id = M.mem_id
   GROUP BY M.mem_id  -- member 테이블의 회원 ID를 기준으로 해서
   ORDER BY 총구매액 DESC ;
   
# WHILE 문
DROP PROCEDURE IF EXISTS whileProc ;
   
DELIMITER $$
CREATE PROCEDURE whileProc() 
BEGIN 
   DECLARE i INT ; 
   DECLARE hap INT ; 
   SET i = 1 ; 
   SET hap = 0 ; 
   
   WHILE (i <= 100) DO
      SET hap = hap + i ; 
      SET i = i + 1 ; 
   END WHILE ; 
   
   SELECT '1부터 100까지의 합 ==>', hap ; 
END $$
DELIMITER ; 

CALL whileProc() ; 


# WHILE 문의 응용
DROP PROCEDURE IF EXISTS whileProc2 ; 

DELIMITER $$ 
CREATE PROCEDURE whileProc2() 
BEGIN
   DECLARE i INT ; 
   DECLARE hap INT ; 
   SET i = 1 ; 
   SET hap = 0 ; 
   
   myWhile:  -- while문을 myWhile이라는 레이블로 지정함 
   WHILE (i <= 100) DO
     IF (i % 4 = 0) THEN  -- 4의 배수인 경우
        SET i = i + 1 ; 
        ITERATE myWhile ; -- 지정한 myWhile로 가서 계속 진행 
	 END IF ; 
     
     SET hap = hap + i ;
     IF (hap > 1000) THEN 
        LEAVE myWhile ;  -- 지정한 myWhile을 떠남. 즉, 종료함
	 END IF ; 
     SET i = i + 1 ; 
   END WHILE ; 
   
   SELECT '1부터 100까지의 합(4의 배수 제외), 1000 넘으면 바로 종료 ==> ', hap ; 
END $$
DELIMITER ; 

CALL whileProc2() ; 


# 동적 SQL 
USE market_db ; 
PREPARE myQuery FROM 'SELECT * FROM member WHERE mem_id = "BLK"' ; 
EXECUTE myQuery ; 
DEALLOCATE PREPARE myQuery ;  -- 지정한 쿼리 해제하기

# 동적 SQL의 응용
DROP TABLE IF EXISTS gate_table ; 
CREATE TABLE gate_table (id INT AUTO_INCREMENT PRIMARY KEY, entry_time DATETIME) ; 
SET @curDATE = CURRENT_TIMESTAMP() ; 

PREPARE myQuery FROM 'INSERT INTO gate_table VALUES(NULL, ?)' ;
EXECUTE myQuery USING @curDATE ; 
DEALLOCATE PREPARE myQuery ; 

SELECT * FROM gate_table ; 