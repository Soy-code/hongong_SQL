SET GLOBAL log_bin_trust_function_creators = 1; 

USE market_db ; 
DROP FUNCTION IF EXISTS sumFunc ; -- function 이미 존재하면 삭제

-- 스토어드 함수 만들기 (두 수를 더하는 함수)
DELIMITER $$
CREATE FUNCTION sumFunc(number1 INT, number2 INT) 
  RETURNS INT -- 반환형식
BEGIN 
  RETURN number1 + number2 ; 
END $$ 
DELIMITER ; 

-- 결과 출력하기
SELECT sumFunc(100, 200) AS 합계 ; 


DROP FUNCTION IF EXISTS calcYearFunc ; 
-- 활동기간 반환하는 스토어드 함수 만들기
DELIMITER $$
CREATE FUNCTION calcYearFunc(dYear INT)
  RETURNS INT
BEGIN 
  DECLARE runYear INT ; -- 로컬 변수 선언
  SET runYear = YEAR(CURDATE()) - dYear ; -- 변수 초기화 
  RETURN runYear ; 
END $$
DELIMITER ; 

-- 결과 출력하기
SELECT calcYearFunc(2000) AS '활동 햇수' ; 

-- 함수 반환값 이용
SELECT calcYearFunc(2007) INTO @debut2007 ; -- 변수 지정 
SELECT calcYearFunc(2013) INTO @debut2013 ; 
SELECT @debut2007 - @debut2013 AS '2007과 2013의 차이' ; 

-- 각 가수의 활동햇수 구하기 
SELECT mem_id, mem_name, calcYearFunc(YEAR(debut_date)) as '활동 햇수' FROM member ;

-- 스토어드 함수 확인하기 
SHOW CREATE FUNCTION calcYearFunc ;  
DROP FUNCTION calcYearFunc ; 

# 커서의 단계별 실습 (최종적으로 스토어드 프로시저 안에 들어갈 쿼리문으로, 아래 쿼리를 그냥 실행하면 에러 남.) 
-- 0. 변수 준비하기
DECLARE memNumber INT ; 
DECLARE cnt INT DEFAULT 0 ; 
DECLARE totNumber INT DEFAULT 0 ;
DECLARE endOfRow BOOLEAN DEFAULT FALSE ; 

-- 1. 커서 선언하기
DECLARE memberCursor CURSOR FOR SELECT mem_number FROM member ; 

-- 2. 반복 조건 선언하기
DECLARE CONTINUE HANDLER FOR NOT FOUND SET endOfRow = TRUE ; 

-- 3. 커서 열기 
OPEN memberCursor ; 

-- 4,5. 행 반복하기
cursor_loop: LOOP
   FETCH memberCursor INTO member ; 
   
   IF endOfRow THEN 
      LEAVE cursor_loop ; 
   END IF  ; 
   
   SET cnt = cnt + 1 ;
   SET totNumber = totNumber + memNumber ; 
END LOOP cursor_loop ; 

SELECT (totNumber / cnt) AS '회원의 평균 인원 수' ; 

-- 6. 커서 닫기
CLOSE memberCursor ; 

-- 커서의 통합 코드 
USE market_db ; 
DROP PROCEDURE IF EXISTS cursor_proc ; 
DELIMITER $$
CREATE PROCEDURE cursor_proc() 
BEGIN 
   -- 0. 변수 준비하기
   DECLARE memNumber INT ; 
   DECLARE cnt INT DEFAULT 0 ; 
   DECLARE totNumber INT DEFAULT 0 ;
   DECLARE endOfRow BOOLEAN DEFAULT FALSE ; 
   -- 1. 커서 선언하기
   DECLARE memberCursor CURSOR FOR SELECT mem_number FROM member ; 
   -- 2. 반복 조건 선언하기
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET endOfRow = TRUE ; 
   -- 3. 커서 열기 
   OPEN memberCursor ; 
   -- 4,5. 행 반복하기
   cursor_loop: LOOP
      FETCH memberCursor INTO memNumber ; 
      IF endOfRow THEN LEAVE cursor_loop ; 
      END IF ; 
      SET cnt = cnt + 1 ;
      SET totNumber = totNumber + memNumber ; 
   END LOOP cursor_loop ; 
   SELECT (totNumber / cnt) AS '회원의 평균 인원 수' ; 
   -- 6. 커서 닫기
   CLOSE memberCursor ; 
END $$ 
DELIMITER ; 

-- 스토어드 프로시저 실행 
CALL cursor_proc() ;




