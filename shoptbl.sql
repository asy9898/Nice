create table shop_member(
	userid varchar2(30) not null primary key,
	password varchar2(50) not null,
	username varchar2(20) not null,
	gender varchar2(6) not null,
	email varchar2(50) not null,
	phone varchar2(30) not null,
	address varchar2(100)
);
drop table shop_member;

insert into shop_member values
('user1','pw1','유저1','남','asdasd@naver.com','010-2314-3244','서울시 서울군 서울동 서울읍 서울면 서울-10번지');

select * from shop_member;




create table shop_product(
	pno number(8) not null primary key,
	userid varchar2(30) not null,
	size varchar2(10) not null,
	producttype varchar2(50) not null,  -- 의류, 신발, 용품(양말,공,가방 등등),전체   4분류
	productname varchar2(100) not null,
	gender varchar2(6),
	explanation varchar2(500) not null,
	price number(10) not null,
	inventory number(4) not null,
	brand varchar2(20) not null,
	size varchar2(10),
	regdate date default sysdate
);
create sequence seq_shop;
insert into shop_product(pno, producttype, productname, gender, main_image, explanation, price, inventory, brand) values
(seq_shop.nextval,'텀블러','나이키 텀블러','공용','귀여운 나이키 텀블러!',12000,129,'Nike');

select * from shop_product;
select * from shop_product where pno=8;


drop table shop_product;




create table shop_image(
uuid varchar2(100) not null,
uploadPath varchar2(200) not null,
fileName varchar2(100) not null,
pno number(8),
	constraint fk_image foreign key(pno) references shop_product(pno)
);

drop table shop_image;

select * from shop_image;

create table shop_cart(
	cartid number(8) not null primary key,
	size varchar2(10) not null,
	userid varchar2(30) not null,
	pno number(8) not null,
	amount number(4) not null,
	constraint fk_pno foreign key(pno) references shop_product(pno)
);
create sequence seq_cart;
insert into shop_cart values(seq_cart.nextval,'user1',11,3);

select * from shop_cart;

drop table shop_cart;
select * from shop_product where producttype like '%%' or productname like '%%' or brand like '%%' order by regdate desc;
select * from (select /*+INDEX_DESC(shop_product SYS_C0011489)*/
		rownum rn,pno,producttype,productname,gender,explanation,price,inventory,brand
		from shop_product where pno>0 and rownum<=(1*10))
where rn>=((1-1)*#{10}) order by regdate desc
select count(*) from shop_product;


