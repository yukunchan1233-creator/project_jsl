-- hometraining 프로젝트 테이블 생성 SQL
-- 테이블명: htm_member, htm_blog, htm_mywish, htm_reply (jslhrd와 겹치지 않도록)

-- 회원 테이블
create table htm_member (
    userid varchar2(50) not null,
    writer varchar2(20) not null,
    password varchar2(300),
    phone varchar2(20),
    email varchar2(50) not null,
    constraint htm_mem_pk primary key(userid)
);

-- 블로그 테이블
create table htm_blog (
    bno number not null,
    name varchar2(20) not null,
    title varchar2(100) not null,
    content varchar2(4000) not null,
    imgfile varchar2(500) not null,
    views number default 0,
    regdate date default sysdate,
    constraint htm_blog_pk primary key (bno)
);

create sequence htm_blog_seq;

-- 찜하기 테이블
create table htm_mywish (
    wish_bno number not null,
    blog_bno number not null,
    userid varchar2(50) not null,
    constraint htm_mywish_blog_fk foreign key (blog_bno) references htm_blog (bno) on delete cascade,
    constraint htm_mywish_member_fk foreign key (userid) references htm_member (userid) on delete cascade,
    constraint htm_mywish_pk primary key (wish_bno),
    constraint htm_mywish_unique unique (blog_bno, userid)  --찜1번만 하게 하기
);

create sequence htm_mywish_seq;

-- 댓글 테이블
create table htm_reply (
    bno number not null, --번호
    blog_bno number not null, --블로그번호
    userid varchar2(50) not null, --로그인 글쓴이 정보
    replytext varchar2(4000) not null, --댓글내용
    regdate date default sysdate, --글쓴 날짜
    constraint htm_replyblog_fk foreign key (blog_bno) references htm_blog (bno) on delete cascade,
    constraint htm_replymem_fk foreign key (userid) references htm_member (userid) on delete cascade,
    constraint htm_reply_pk primary key (bno)
);

create sequence htm_reply_seq;

-- 테스트 데이터 (선택사항)
-- INSERT INTO htm_member VALUES('java03', '홍길동', '$2a$10$...', '010-1234-5678', 'test@email.com');
-- select * from htm_member;
-- select * from htm_blog;
-- select * from htm_mywish;
-- select * from htm_reply;




