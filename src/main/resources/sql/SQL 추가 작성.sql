use team4;
COMMIT;

############################
#시퀀스(sequence) 생성 방법
############################
CREATE TABLE sequences ( name varchar(32), currval BIGINT UNSIGNED ) ENGINE=InnoDB;


DELIMITER $$
CREATE PROCEDURE `create_sequence`(IN the_name text)
MODIFIES SQL DATA
DETERMINISTIC
BEGIN
    DELETE FROM sequences WHERE name=the_name;
    INSERT INTO sequences VALUES (the_name, 0);
END$$
DELIMITER ;

 DELIMITER $$ 
 CREATE FUNCTION `nextval`(the_name varchar(32))
 RETURNS BIGINT UNSIGNED
 MODIFIES SQL DATA
 DETERMINISTIC
 BEGIN
     DECLARE ret BIGINT UNSIGNED;
     UPDATE sequences SET currval=currval+1 WHERE name=the_name;
     SELECT currval INTO ret FROM sequences WHERE name=the_name limit 1;
     RETURN ret;
 END$$
 DELIMITER ;
 
 INSERT INTO sequences VALUES ('member_seq', 0);
 
 select nextval('member_seq') as member_seq from dual;
 
############################
# Table 조회
############################
 select * from member;
 select * from mem_detail;
 select * from buis_detail;
 select * from product;
 
 select * from event;
 select * from event;
 select * from event;
 
 
 
select * from event;
select * from notice;
select * from product;
select * from service_board;
select * from product_review;
 
 
 
 
 
 
 
 
############################
#아이디 찾기
############################
select * from mem_detail;
select * from member;

INSERT INTO buis_detail (buis_count, mem_num, buis_num, ceo_name, buis_name, buis_item, opening_date, buis_zipcode, buis_address1, buis_address2)
values((select * from (select max(buis_count)+1 from buis_detail) next), 3, 1, '기쁨이', '기쁨이', '가구', '2021-03-15', '02529', '서울 동대문구 답십리로 237', '123455');

## 같은 정보 오류 발생 (시퀀스값 0일경우 발생) ##
INSERT INTO cart(cart_num, prod_num, mem_num, cart_quan)
values((select * from (select max(cart_num)+1 from cart) next), 1, 1, 1);

## 아래 데이터로 등록 진행##
INSERT INTO cart(cart_num, prod_num, mem_num, cart_quan)
select case count(*) when 0 then 1 else max(cart_num) + 1 end, 1, 1, 1 from cart;

INSERT INTO event (event_num,event_title,event_content,event_type,event_day,event_hits,event_reg_date,event_modi,mem_num,event_filename,event_photo) 
values((select * from (select max(cart_num)+1 from cart) next),'기쁨이','기쁨이','진행중','2021-10-31',1,now(),now(), 3, '1.png', '333333');

INSERT INTO event (event_num,event_title,event_content,event_type,event_day,event_hits,event_reg_date,event_modi,mem_num,event_filename,event_photo) 
select case count(*) when 0 then 1 else max(event_num) + 1 end,'기쁨이','기쁨이','진행중','2021-10-31',1,now(),now(), 3, '1.png', '333333' from event;

INSERT INTO comments (comm_num, comm_content, event_num, mem_num) 
values((select * from (select max(comm_num)+1 from comments) next),'경미', 1, 1);

INSERT INTO comments (comm_num, comm_content, event_num, mem_num) 
select case count(*) when 0 then 1 else max(comm_num) + 1 end,'경미',1, 1 from comments;

INSERT INTO product (prod_num, prod_name, prod_price, delive_price, delive_type, selec_product, prod_option1, prod_option2, prod_option3, prod_option4, prod_option5, prod_option6, prod_option7, prod_option8, prod_option9, prod_option10, prod_content, thumbnail_img, thumbnail_filename, prod_quan, prod_keyword, mem_num, prod_cate) 
select case count(*) when 0 then 1 else max(prod_num) + 1 end, '에이스 가구', 20000, 2500, '무료배송', '상품은좋아요', '', '', '', '', '', '', '', '', '', '', '상품설명', 'none.png', 'none.png', 3, '가구', '2', '2' from product;

delete from product where prod_num = 5;

SELECT * FROM member m JOIN mem_detail d ON m.mem_num=d.mem_num ORDER BY m.mem_num DESC;

SELECT * FROM (SELECT @rownum:=@rownum+1 rnum, a.* FROM (SELECT 
m.mem_num, m.mem_id, m.mem_auth, d.mem_name, d.passwd, d.nickname, d.email, d.phone, d.zipcode, d.address1, d.address2, d.reg_date, d.profile, d.profile_filename, d.point
FROM member m LEFT JOIN mem_detail d ON m.mem_num=d.mem_num) a, (SELECT @ROWNUM := 0) R WHERE 1=1) list WHERE rnum>=1 AND rnum <=5;

select * from member;
select * from comments;
SELECT * FROM (SELECT @rownum:=@rownum+1 rnum, a.* FROM (SELECT * FROM notice ORDER BY notice_reg_date DESC) a, (SELECT @ROWNUM := 0) R WHERE 1=1) list WHERE rnum >= 1 AND rnum <= 5;

select * from mem_detail;

select * from house_board;
INSERT INTO `team4`.`comments`(`comm_num`,`comm_reg_date`,`comm_modi`,`comm_content`,`mem_num`,`house_num`,`event_num`) select case count(*) when 0 then 1 else max(comm_content) + 1 end, now(),now(),'1',1,1,6 from comments;

select * from orders;
INSERT INTO orders(order_num, order_date, order_zipcode, order_address1, order_address2, receiver_name, receiver_phone, mem_num, prod_num, pay_quan, pay_price, buis_name, receiver_email)
			select case count(*) when 0 then 1 else max(order_num) + 1 end, now(), '1234', 'dd', 'dd','개똥이', '1234-1234', 1, 6, 1, 1200, '삼성전자', 's@ss' from orders;
            
INSERT INTO qna_list (qna_num, qna_category, qna_content, qna_reply, mem_num) select case count(*) when 0 then 1 else max(qna_num) + 1 end, 'w', 'w', 'w', 1 from qna_list;

select * from qna_list;
delete from qna_list where qna_num = 2;

SELECT * FROM qna_list WHERE qna_num = 1;

select * from house_board;
SELECT * FROM (SELECT @rownum:=@rownum+1 rnum, a.* FROM (SELECT b.house_num, b.house_title, b.house_area FROM house_board b JOIN mem_detail m ON b.mem_num = m.mem_num like b.house_area = '%30평%' ORDER BY b.house_num DESC) a, (SELECT @ROWNUM := 0) R WHERE 1=1) list WHERE rnum >=1 AND rnum <= 20;

select * from event;
select * from notice;
select * from product;
select * from service_board;
select * from product_review;
SELECT rev_filename, rev_img, p.thumbnail_img, p.thumbnail_filename FROM product_review r, 
product p WHERE r.prod_num=p.prod_num AND rev_num = 1;
delete from service_board where service_num=1;
delete from product where prod_num=5;
create table `team4`.product like `111`.product;
insert into `team4`.notice select * from `111`.notice;
create table if not exists `product1` select * from `product`;
rename table current_111.table_product to other_team4.table_product;
COMMIT;