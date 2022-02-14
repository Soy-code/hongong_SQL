USE market_db ; 
SELECT * FROM member ; 
SELECT mem_id, mem_name, addr FROM member ;

-- 뷰 생성 
CREATE VIEW v_member
AS
   SELECT mem_id, mem_name, addr FROM member ; 

SELECT * FROM v_member ;    
SELECT mem_name, addr FROM v_member 
   WHERE addr IN('서울', '경기') ; 
   
-- VIEW를 이용한 간단한 쿼리문
SELECT B.mem_id, M.mem_name, B.prod_name, M.addr, CONCAT(M.phone1, M.phone2) '연락처' 
   FROM buy B
      INNER JOIN member M
      ON B.mem_id = M.mem_id ; 

CREATE VIEW v_memberbuy 
AS 
   SELECT B.mem_id, M.mem_name, B.prod_name, M.addr, CONCAT(M.phone1, M.phone2) '연락처' 
      FROM buy B
         INNER JOIN member M
         ON B.mem_id = M.mem_id ;          
SELECT * FROM v_memberbuy ; 
SELECT * FROM v_memberbuy WHERE mem_name = '블랙핑크' ; 

-- 뷰 생성
USE market_db ; 
CREATE VIEW v_viewtest1 
AS 
   SELECT B.mem_id 'member id', M.mem_name AS 'member name', -- 여기서의 as 는 형식상임. 생략 가능 
          B.prod_name "product name", CONCAT(M.phone1, M.phone2) AS 'office phone' 
   FROM buy B  
      INNER JOIN member M 
      ON B.mem_id = M.mem_id ; 
      
SELECT * FROM v_viewtest1 ; 
SELECT DISTINCT `member id`, `member name` FROM v_viewtest1 ; -- 여기서 작은 따옴표가 아니라 백틱(`) 사용하는 거 헷갈리지 말기!

-- 뷰 수정
ALTER VIEW v_viewtest1 
AS
   SELECT B.mem_id '회원 아이디', M.mem_name AS '회원 이름', 
          B.prod_name '제품 이름', CONCAT(M.phone1, M.phone2) AS '연락처'
   FROM buy B 
      INNER JOIN member M 
	  ON B.mem_id = M.mem_id ; 
      
SELECT * FROM v_viewtest1 ; 
SELECT DISTINCT `회원 아이디`, `회원 이름` FROM v_viewtest1 ; 

-- 뷰의 삭제
DROP VIEW v_viewtest1 ; 

-- 뷰의 정보
USE market_db ; 
CREATE OR REPLACE VIEW v_viewtest2 
AS 
   SELECT mem_id, mem_name, addr FROM member ; 
DESCRIBE v_viewtest2 ; 

-- 데이터의 수정
SELECT * FROM v_member ; 
UPDATE v_member SET addr = '부산' WHERE mem_id = 'BLK' ; 
SELECT * FROM v_member ; 

INSERT INTO v_member(mem_id, mem_name, addr) VALUES('BTS', '방탄소년단', '경기') ; -- 에러발생

-- 뷰를 통한 데이터의 입력
CREATE VIEW v_height167 
AS 
   SELECT * FROM member WHERE height >= 167 ; 

SELECT * FROM v_height167 ; 
DELETE FROM v_height167 WHERE height < 167 ; -- 해당 데이터가 없으므로 뷰는 그대로
INSERT INTO v_height167 VALUES('TRA', '티아라', 6, '서울', NULL, NULL, 159, '2005-01-01') ; -- height이 167보다 작은 데이터 입력
SELECT * FROM v_height167 ; 

ALTER VIEW v_height167 
AS
   SELECT * FROM member WHERE height >= 167 WITH CHECK OPTION ; 
   
INSERT INTO v_height167 VALUES('TRA', '티아라', 6, '서울', NULL, NULL, 159, '2005-01-01') ; -- 이번에는 에러 발생

-- 복합뷰
CREATE VIEW v_complex 
AS
   SELECT B.mem_id, M.mem_name, B.prod_name, M.addr
      FROM buy B 
	     INNER JOIN member M
         ON B.mem_id = M.mem_id ; 

SELECT * FROM v_complex ; 

-- 뷰가 참조하는 테이블의 삭제
DROP TABLE IF EXISTS buy, member ;
SELECT * FROM v_height167 ;  
CHECK TABLE v_height167 ; 