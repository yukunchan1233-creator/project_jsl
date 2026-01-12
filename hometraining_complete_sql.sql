-- ============================================
-- 홈트레이닝 프로젝트 전체 SQL 스크립트
-- ============================================
-- 실행 순서: 이 파일을 순서대로 실행하세요
-- ============================================

-- ============================================
-- 1. 상품 테이블 (TBL_PRODUCT)
-- ============================================
-- 기존 테이블이 있으면 삭제 (주의: 데이터가 모두 삭제됩니다!)
-- 먼저 drop_all_tables.sql을 실행하거나 아래 주석을 해제하세요
/*
DROP TABLE TBL_PRODUCT CASCADE CONSTRAINTS;
DROP SEQUENCE SEQ_PRODUCT;
*/

-- 상품 테이블 생성 (userid, regdate 포함)
CREATE TABLE TBL_PRODUCT (
    pno NUMBER PRIMARY KEY,                    -- 제품번호
    category VARCHAR2(20) NOT NULL,              -- 카테고리 (유산소, 근력운동)
    subcategory VARCHAR2(50) NOT NULL,           -- 하위카테고리 (런닝머신, 벤치프레스 등)
    site_name VARCHAR2(50) NOT NULL,              -- 브랜드명 (이고진, 반석 등)
    product_name VARCHAR2(200) NOT NULL,          -- 제품명
    price NUMBER,                                 -- 가격
    review_count NUMBER DEFAULT 0,                -- 후기 개수
    image_path VARCHAR2(500),                    -- 대표 이미지 경로
    detail_images VARCHAR2(2000),                 -- 상세 이미지들 (쉼표로 구분)
    buy_link VARCHAR2(500),                       -- 구매 링크 (공홈go URL)
    userid VARCHAR2(50),                          -- 등록자 아이디 (관리자)
    regdate DATE DEFAULT SYSDATE                  -- 등록일
);

-- 상품 번호 시퀀스 생성
CREATE SEQUENCE SEQ_PRODUCT
START WITH 1
INCREMENT BY 1;

-- userid 인덱스 생성 (조회 성능 향상)
CREATE INDEX IDX_PRODUCT_USERID ON TBL_PRODUCT(userid);

-- ============================================
-- 2. 회원 테이블 (htm_member)
-- ============================================
-- 기존 테이블이 있으면 삭제 (주의!)
-- 먼저 drop_all_tables.sql을 실행하거나 아래 주석을 해제하세요
/*
DROP TABLE htm_member CASCADE CONSTRAINTS;
*/

CREATE TABLE htm_member (
    userid VARCHAR2(50) NOT NULL,                -- 아이디
    writer VARCHAR2(20) NOT NULL,                 -- 이름
    password VARCHAR2(300),                      -- 비밀번호 (Bcrypt 암호화)
    phone VARCHAR2(20),                           -- 전화번호
    email VARCHAR2(50) NOT NULL,                 -- 이메일
    CONSTRAINT htm_mem_pk PRIMARY KEY(userid)
);

-- ============================================
-- 3. 블로그 테이블 (htm_blog)
-- ============================================
-- 기존 테이블이 있으면 삭제 (주의!)
-- 먼저 drop_all_tables.sql을 실행하거나 아래 주석을 해제하세요
/*
DROP TABLE htm_blog CASCADE CONSTRAINTS;
DROP SEQUENCE htm_blog_seq;
*/

CREATE TABLE htm_blog (
    bno NUMBER NOT NULL,                        -- 블로그 번호
    name VARCHAR2(20) NOT NULL,                  -- 작성자 이름
    title VARCHAR2(100) NOT NULL,                 -- 제목
    content VARCHAR2(4000) NOT NULL,            -- 내용
    imgfile VARCHAR2(500) NOT NULL,              -- 이미지 파일
    views NUMBER DEFAULT 0,                      -- 조회수
    regdate DATE DEFAULT SYSDATE,                -- 등록일
    CONSTRAINT htm_blog_pk PRIMARY KEY (bno)
);

CREATE SEQUENCE htm_blog_seq;

-- ============================================
-- 4. 찜하기 테이블 (htm_mywish)
-- ============================================
-- 기존 테이블이 있으면 삭제 (주의!)
-- 먼저 drop_all_tables.sql을 실행하거나 아래 주석을 해제하세요
/*
DROP TABLE htm_mywish CASCADE CONSTRAINTS;
DROP SEQUENCE htm_mywish_seq;
*/

CREATE TABLE htm_mywish (
    wish_bno NUMBER NOT NULL,                    -- 찜 번호
    blog_bno NUMBER NOT NULL,                     -- 블로그 번호
    userid VARCHAR2(50) NOT NULL,                -- 사용자 아이디
    CONSTRAINT htm_mywish_blog_fk FOREIGN KEY (blog_bno) REFERENCES htm_blog (bno) ON DELETE CASCADE,
    CONSTRAINT htm_mywish_member_fk FOREIGN KEY (userid) REFERENCES htm_member (userid) ON DELETE CASCADE,
    CONSTRAINT htm_mywish_pk PRIMARY KEY (wish_bno),
    CONSTRAINT htm_mywish_unique UNIQUE (blog_bno, userid)  -- 찜 1번만 하게 하기
);

CREATE SEQUENCE htm_mywish_seq;

-- ============================================
-- 5. 댓글 테이블 (htm_reply)
-- ============================================
-- 기존 테이블이 있으면 삭제 (주의!)
-- 먼저 drop_all_tables.sql을 실행하거나 아래 주석을 해제하세요
/*
DROP TABLE htm_reply CASCADE CONSTRAINTS;
DROP SEQUENCE htm_reply_seq;
*/

CREATE TABLE htm_reply (
    bno NUMBER NOT NULL,                         -- 댓글 번호
    blog_bno NUMBER NOT NULL,                    -- 블로그 번호
    userid VARCHAR2(50) NOT NULL,                -- 작성자 아이디
    replytext VARCHAR2(4000) NOT NULL,           -- 댓글 내용
    regdate DATE DEFAULT SYSDATE,                -- 등록일
    CONSTRAINT htm_replyblog_fk FOREIGN KEY (blog_bno) REFERENCES htm_blog (bno) ON DELETE CASCADE,
    CONSTRAINT htm_replymem_fk FOREIGN KEY (userid) REFERENCES htm_member (userid) ON DELETE CASCADE,
    CONSTRAINT htm_reply_pk PRIMARY KEY (bno)
);

CREATE SEQUENCE htm_reply_seq;

-- ============================================
-- 6. 관리자 계정 생성 (admin)
-- ============================================
-- 비밀번호: admin (Bcrypt 암호화 필요)
-- 실제 비밀번호는 Java 코드에서 Bcrypt로 암호화해서 저장해야 합니다.
-- 여기서는 예시로 '$2a$10$...' 형태의 해시값이 필요합니다.
-- 
-- 관리자 계정은 회원가입 페이지에서 직접 만들거나,
-- 아래 SQL로 직접 만들 수 있습니다 (비밀번호는 암호화된 값으로 변경 필요)

-- INSERT INTO htm_member (userid, writer, password, phone, email) 
-- VALUES ('admin', '관리자', '$2a$10$암호화된비밀번호', '010-0000-0000', 'admin@hometraining.com');

-- ============================================
-- 7. 샘플 데이터 (선택사항)
-- ============================================

-- 샘플 상품 데이터
INSERT INTO TBL_PRODUCT VALUES (
    SEQ_PRODUCT.NEXTVAL,
    '유산소',
    '런닝머신',
    '반석',
    '반석 접이식 러닝머신',
    500000,
    180,
    'images/running_1.jpg',
    'images/running_1.jpg,images/running_2.jpg,images/running_3.jpg',
    'https://www.banseok.co.kr/product/running',
    'admin',
    SYSDATE
);

INSERT INTO TBL_PRODUCT VALUES (
    SEQ_PRODUCT.NEXTVAL,
    '근력운동',
    '벤치프레스',
    '이고진',
    '이고진 접이식 벤치프레스',
    150000,
    120,
    'images/bench_1.jpg',
    'images/bench_1.jpg,images/bench_2.jpg,images/bench_3.jpg',
    'https://www.igozin.co.kr/product/bench',
    'admin',
    SYSDATE
);

INSERT INTO TBL_PRODUCT VALUES (
    SEQ_PRODUCT.NEXTVAL,
    '근력운동',
    '벤치프레스',
    '반석',
    '반석 프리미엄 벤치프레스',
    200000,
    85,
    'images/bench_2.jpg',
    'images/bench_2_1.jpg,images/bench_2_2.jpg,images/bench_2_3.jpg',
    'https://www.banseok.co.kr/product/bench',
    'admin',
    SYSDATE
);

INSERT INTO TBL_PRODUCT VALUES (
    SEQ_PRODUCT.NEXTVAL,
    '유산소',
    '사이클',
    '이고진',
    '이고진 실내 자전거',
    300000,
    95,
    'images/cycle_1.jpg',
    'images/cycle_1.jpg,images/cycle_2.jpg',
    'https://www.igozin.co.kr/product/cycle',
    'admin',
    SYSDATE
);

INSERT INTO TBL_PRODUCT VALUES (
    SEQ_PRODUCT.NEXTVAL,
    '근력운동',
    '덤벨',
    '반석',
    '반석 조절식 덤벨 세트',
    250000,
    150,
    'images/dumbel_1.jpg',
    'images/dumbel_1.jpg,images/dumbel_2.jpg',
    'https://www.banseok.co.kr/product/dumbel',
    'admin',
    SYSDATE
);

-- ============================================
-- 8. 커밋
-- ============================================
COMMIT;

-- ============================================
-- 9. 확인 쿼리
-- ============================================
-- SELECT * FROM TBL_PRODUCT;
-- SELECT * FROM htm_member;
-- SELECT * FROM htm_blog;
-- SELECT * FROM htm_mywish;
-- SELECT * FROM htm_reply;
