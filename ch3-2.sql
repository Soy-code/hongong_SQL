SELECT * FROM member ; 
SELECT * FROM buy ; 

-- debut_date가 빠른 순으로 정렬
SELECT mem_id, mem_name, debut_date FROM member ORDER BY debut_date ; 
SELECT mem_id, mem_name, debut_date FROM member ORDER BY debut_date DESC ; 

-- SQL 구문의 순서가 틀린 경우
SELECT mem_id, mem_name, debut_date, height 
	FROM member 
    ORDER BY height DESC 
    WHERE height >= 164 ; -- 오류가 발생함

-- SQL 구문의 순서가 맞는 경우
SELECT mem_id, mem_name, debut_date, height 
	FROM member 
    WHERE height >= 164 
    ORDER BY height DESC  ;
    
SELECT mem_id, mem_name, debut_date, height
   FROM member
   WHERE height >= 164
   ORDER BY height DESC, debut_date ; 
   
-- LIMIT 절
SELECT * FROM member ; 
SELECT * FROM member LIMIT 3 ; 
SELECT * FROM member LIMIT 0, 3 ; -- :LIMIT 시작, 개수  
SELECT * FROM member LIMIT 5, 10 ; 
SELECT * FROM member LIMIT 10 OFFSET 5 ; -- 위 구문과 동일

SELECT mem_name, height 
  FROM member
  ORDER BY height DESC 
  LIMIT 3, 2; 
  
SELECT mem_name, height
  FROM member 
  ORDER BY height DESC
  LIMIT 2 OFFSET 3 ; 
  
  
-- DISTINCT 절
SELECT addr FROM member ; 
SELECT addr FROM member ORDER BY addr ; 
SELECT DISTINCT addr FROM member ORDER BY addr ; 


-- GROUP BY
SELECT * FROM buy ; 
SELECT mem_id, amount FROM buy ORDER BY mem_id ; 
SELECT mem_id, SUM(amount) FROM buy GROUP BY mem_id ; 
SELECT mem_id "회원 아이디", SUM(amount) "총 구매 개수" FROM buy GROUP BY mem_id ; 
SELECT mem_id "회원 아이디", SUM(amount * price) "총 구매금액" FROM buy GROUP BY mem_id ; 

SELECT AVG(amount) FROM buy ;
SELECT mem_id, AVG(amount) 
   FROM buy 
   GROUP BY mem_id ; 
SELECT COUNT(*) FROM member ; -- member 테이블의 총 데이터 수 (행 개수)
SELECT * FROM member ;
SELECT COUNT(phone1) FROM member ; 

-- mem_id 별로 총 구매금액 출력
SELECT mem_id, SUM(amount * price) 
  FROM buy 
  GROUP BY mem_id ; 
-- 총 구매금액이 1000이 넘는 데이터만 출력
SELECT mem_id, SUM(amount * price) 
  FROM buy
  WHERE SUM(amount * price) > 1000 
  GROUP BY mem_id ; -- error 발생 
-- HAVING 절에 집계함수 사용
SELECT mem_id, SUM(amount * price) 
  FROM buy
  GROUP BY mem_id 
  HAVING SUM(amount * price) > 1000 ; 
SELECT mem_id, SUM(amount * price) 
  FROM buy
  GROUP BY mem_id
  HAVING SUM(amount * price) > 1000
  ORDER BY SUM(amount * price) DESC ; 
