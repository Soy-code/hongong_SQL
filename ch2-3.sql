## 인덱스 (index)
# member_name이 아이유인 모든 행을 출력
select * from member where member_name = "아이유" ; 

# 회원 테이블에 인덱스 만들기 
# on member(member_name) : member 테이블의 member_name의 열에 인덱스를 지정하라는 의미
create index idx_member_name on member(member_name) ;

# 인덱스를 만든 후에, 같은 데이터 출력 
# Key lookup : 인덱스를 통해 결과를 찾아냈다고 보면 됨. 이런 방법을 인덱스 검색(Index scan)이라고 함. 
select * from member where member_name = "아이유" ; 


## 뷰(view)
# member_view 만들기 
create view member_view 
as select * from member ; 

# 회원 테이블이 아닌 member_view에 접근 
select * from member_view ; 


## 스토어드 프로시저 (Stored procedure)
# 아래의 두 쿼리문이 계속 반복되는 문이라고 가정. 
select * from member where member_name = "나훈아" ;
select * from product where product_name = "삼각김밥" ; 

# 스토어드 프로시저 만들기
delimiter //
create procedure myProc() 
begin 
	select * from member where member_name = "나훈아" ; 
    select * from product where product_name =  "삼각김밥" ; 
end  //
delimiter ;

# 만든 procedure 호출하기
call myProc() ; 