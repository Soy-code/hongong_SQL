SELECT * FROM member;
SELECT * FROM buy;

SELECT mem_name FROM member ; 
SELECT addr, debut_date "데뷔 일자", mem_name FROM member ; 

SELECT * FROM member WHERE mem_name = "블랙핑크" ; 
SELECT * FROM member WHERE mem_number = 4 ; 

SELECT mem_id, mem_name FROM member WHERE height <= 162 ; 
SELECT mem_name, height, mem_number FROM member WHERE height >= 165 AND mem_number > 6 ; 
SELECT mem_name, height, mem_number FROM member WHERE height >= 165 OR mem_number > 6 ;  
SELECT mem_name, height FROM member WHERE height BETWEEN 163 AND 165 ; -- BETWEEN은 해당 값도 포함.
SELECT mem_name, addr FROM member WHERE addr = '경기' OR addr = '전남' OR addr = '경남' ; 
SELECT mem_name, addr FROM member WHERE addr IN('경기', '전남', '경남') ; 
SELECT * FROM member WHERE mem_name LIKE '우%' ; 
SELECT * FROM member WHERE mem_name LIKE '__핑크' ;
SELECT * FROM member WHERE mem_name LIKE '____' ;

SELECT height FROM member WHERE mem_name = '에이핑크' ; 
SELECT mem_name, height FROM member WHERE height > 164 ; 

SELECT mem_name, height FROM member 
	WHERE height > (SELECT height FROM member WHERE mem_name = '에이핑크') ; 