USE market_db ; 
SELECT * FROM buy ; 
SELECT * FROM member ; 
DESC member ; 

-- GRL이라는 아이디를 가진 사람의 구매 내역과 휴대전화 및 주소 정보
SELECT * 
   FROM buy
      INNER JOIN member
      ON buy.mem_id = member.mem_id
   WHERE buy.mem_id = 'GRL' ; 
   
-- 만약 where 조건이 없다면?
SELECT * 
   FROM buy 
      INNER JOIN member 
      ON buy.mem_id = member.mem_id ; 

-- 필요한 열만 추출
SELECT buy.mem_id, mem_name, prod_name, addr, CONCAT(phone1, phone2) '연락처'
   FROM buy
      INNER JOIN member 
      ON buy.mem_id = member.mem_id ;
      
-- 데이터 테이블 별칭 주기
SELECT B.mem_id, M.mem_name, B.prod_name, M.addr, CONCAT(M.phone1, M.phone2) '연락처'
   FROM buy B 
      INNER JOIN member M 
      ON B.mem_id = M.mem_id ;
      
-- 전체 회원의 구매 내역과 휴대전화 및 주소 정보
-- M.mem_id로 열을 지정한 것을 확인
SELECT M.mem_id, M.mem_name, B.prod_name, M.addr
   FROM buy B 
      INNER JOIN member M
	  ON B.mem_id = M.mem_id 
   ORDER BY M.mem_id ; 
   
-- 중복된 결과 1개만 출력하기
SELECT DISTINCT M.mem_id, M.mem_name, M.addr
   FROM buy B 
     INNER JOIN member M 
     ON B.mem_id = M.mem_id 
   ORDER BY M.mem_id ; 
   
-- 외부조인 
SELECT M.mem_id, M.mem_name, B.prod_name, M.addr 
   FROM member M 
     LEFT OUTER JOIN buy B -- 왼쪽에 있는 M 테이블을 기준으로 outer join
     ON M.mem_id = B.mem_id 
   ORDER BY M.mem_id ; 
   
SELECT M.mem_id, M.mem_name, B.prod_name, M.addr
   FROM buy B 
      RIGHT OUTER JOIN member M 
      ON M.mem_id = B.mem_id 
   ORDER BY M.mem_id ; 
   
-- 회원 가입 후, 구매이력이 한번도 없는 회원 추출
SELECT DISTINCT M.mem_id, B.prod_name, M.mem_name, M.addr
   FROM member M
     LEFT OUTER JOIN buy B 
       ON M.mem_id = B.mem_id 
	 WHERE b.prod_name IS NULL  -- prod name이 null인 경우만 출력 
     ORDER BY M.mem_id ; 
     
-- CROSS JOIN 
SELECT * 
   FROM buy 
      CROSS JOIN member ; 
      
-- 상호조인을 통한 대용량테이블 생성
-- world DB의 city 테이블과 sakila DB의 inventory 테이블을 cross join
SELECT COUNT(*) "데이터 개수" 
   FROM sakila.inventory
      CROSS JOIN world.city ; 
      
-- 대용량 테이블 만들기
CREATE TABLE cross_table 
   SELECT * 
      FROM sakila.actor 
         CROSS JOIN world.country ; 
         
SELECT * FROM cross_table LIMIT 5 ; 


-- 자체조인(self join)
USE market_db ; 
CREATE TABLE emp_table (emp CHAR(4), manager CHAR(4), phone VARCHAR(8)) ; 

INSERT INTO emp_table VALUES('대표', NULL, '0000') ; 
INSERT INTO emp_table VALUES('영업이사', '대표', '1111') ; 
INSERT INTO emp_table VALUES('관리이사', '대표', '2222') ; 
INSERT INTO emp_table VALUES('정보이사', '대표', '3333') ; 
INSERT INTO emp_table VALUES('영업과장', '영업이사', '1111-1'); 
INSERT INTO emp_table VALUES('경리부장', '관리이사', '2222-1'); 
INSERT INTO emp_table VALUES('인사부장', '관리이사', '2222-2'); 
INSERT INTO emp_table VALUES('개발팀장', '정보이사', '3333-1'); 
INSERT INTO emp_table VALUES('개발주임', '정보이사', '3333-1-1'); 

SELECT * FROM emp_table ; 



