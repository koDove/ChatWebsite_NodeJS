create database YKS;
use YKS;

create table user(
idx int not null auto_increment primary key,
userid varchar(15) not null,
password char(64) not null,
nickname varchar(15) not null,
name varchar(10) not null,
email varchar(50) not null,
phone_number varchar(15) not null
);

create table address(
id int not null auto_increment primary key,
nickname varchar(50) not null,
phone_number varchar(15) not null,	
email varchar(50) not null,
owner varchar(15) not null
);

create table chatRoom(
roomidx varchar(50) not null primary key
);

create table chatRoomAttendant(
roomidx varchar(50) not null,
userid varchar(50) not null,
FOREIGN KEY (roomidx) REFERENCES chatRoom(roomidx)
);

create table messages(
roomidx varchar(50) not null,
datedata varchar(60) not null,
sender varchar(50) not null,
message varchar(1000),
FOREIGN KEY (roomidx) REFERENCES chatRoom(roomidx)
);

insert into user(userid, password,nickname, name,email, phone_number) values('guest','03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4','게스트','게스트','guest@naver.com','01012345678');
insert into user(userid, password,nickname, name,email, phone_number) values('box','464c7a646393b68d1a42076c010b5aae418d8d322f233ca0b8cd8e2c6bcd9676','박스헤드','박스','box@naver.com','01022311213');
insert into user(userid, password,nickname, name,email, phone_number) values('dove','03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4','나는비둘기','비둘기','dove@naver.com','01012345656');
insert into user(userid, password,nickname, name,email, phone_number) values('paper','03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4','나는종이','종이','paper@naver.com','01011112222');
insert into user(userid, password,nickname, name,email, phone_number) values('bird','03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4','나는새','새','bird@naver.com','01033332222');
insert into user(userid, password,nickname, name,email, phone_number) values('cat','03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4','나는고양이','고양이','cat@naver.com','01054221111');
insert into user(userid, password,nickname, name,email, phone_number) values('dbrudtjr99','03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4','YKS','유경석','cat@naver.com','01066162484');

insert into address(nickname, phone_number, email, owner) values('YKS', '01066162484', 'dbrudtjr99@naver.com', 'guest');
insert into address(nickname, phone_number, email, owner) values('나는비둘기', '01012345656', 'dove@naver.com', 'guest');
insert into address(nickname, phone_number, email, owner) values('나는종이', '01011112222', 'paper@naver.com', 'guest');
insert into address(nickname, phone_number, email, owner) values('나는새', '01033332222', 'bird@naver.com', 'guest');
insert into address(nickname, phone_number, email, owner) values('나는고양이', '01054221111', 'cat@naver.com', 'guest');
insert into address(nickname, phone_number, email, owner) values('박스헤드', '01022311213', 'box@naver.com', 'guest');
insert into address(nickname, phone_number, email, owner) values('김종국', '01022223333', 'kjg@naver.com', 'guest');

insert into address(nickname, phone_number, email, owner) values('나는종이', '01011112222', 'paper@naver.com', 'box');
insert into address(nickname, phone_number, email, owner) values('나는고양이', '01054221111', 'cat@naver.com', 'box');
insert into address(nickname, phone_number, email, owner) values('게스트', '01012345678', 'guest@naver.com', 'box');
insert into address(nickname, phone_number, email, owner) values('YKS', '01066162484', 'dbrudtjr99@naver.com', 'box');
insert into address(nickname, phone_number, email, owner) values('나는새', '01033332222', 'bird@naver.com', 'box');
insert into address(nickname, phone_number, email, owner) values('나는비둘기', '01012345656', 'dove@naver.com', 'box');
insert into address(nickname, phone_number, email, owner) values('김종국', '01022223333', 'kjg@naver.com', 'box');


insert into chatRoom(roomidx) values('770105433');

insert into chatRoomAttendant(roomidx,userid) values('770105433','guest');
insert into chatRoomAttendant(roomidx,userid) values('770105433','box');




select * from user;
select * from address;
select * from messages;

#set sql_safe_updates=0;
