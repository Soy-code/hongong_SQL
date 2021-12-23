# shop_db 내의 member 테이블의 모든 데이터를 불러들이기
select * from member ; 

# member 테이블의 member_name과 member_addr column만 출력
select member_name, member_addr from member ; 

# member 테이블의 모든 열을 불러들이지만, member_name이 아이유인 경우만 출력
select * from member where member_name = "아이유" ; 