-- 홈트레이닝 운동기구 블로그 DB 테이블 생성

-- 제품 테이블
CREATE TABLE TBL_PRODUCT (
    pno NUMBER PRIMARY KEY,                    -- 제품번호
    category VARCHAR2(20) NOT NULL,            -- 카테고리 (가슴, 등, 하체, 유산소)
    subcategory VARCHAR2(50) NOT NULL,         -- 하위카테고리 (벤치프레스, 딥스 등)
    site_name VARCHAR2(50) NOT NULL,           -- 사이트명 (이고진, 반석 등)
    product_name VARCHAR2(200) NOT NULL,       -- 제품명
    price NUMBER,                               -- 가격
    review_count NUMBER DEFAULT 0,             -- 후기 개수
    image_path VARCHAR2(500),                  -- 대표 이미지 경로
    detail_images VARCHAR2(2000),             -- 상세 이미지들 (쉼표로 구분)
    buy_link VARCHAR2(500)                     -- 구매 링크
);

-- 시퀀스 생성 (제품번호 자동 증가)
CREATE SEQUENCE SEQ_PRODUCT
START WITH 1
INCREMENT BY 1;

-- 샘플 데이터 삽입
INSERT INTO TBL_PRODUCT VALUES (
    SEQ_PRODUCT.NEXTVAL,
    '가슴',
    '벤치프레스',
    '이고진',
    '이고진 접이식 벤치프레스',
    150000,
    120,
    'images/bench_1.jpg',
    'images/bench_1.jpg,images/bench_2.jpg,images/bench_3.jpg',
    'https://www.igozin.co.kr/product/bench'
);

INSERT INTO TBL_PRODUCT VALUES (
    SEQ_PRODUCT.NEXTVAL,
    '가슴',
    '벤치프레스',
    '반석',
    '반석 프리미엄 벤치프레스',
    200000,
    85,
    'images/bench_2.jpg',
    'images/bench_2_1.jpg,images/bench_2_2.jpg,images/bench_2_3.jpg',
    'https://www.banseok.co.kr/product/bench'
);

INSERT INTO TBL_PRODUCT VALUES (
    SEQ_PRODUCT.NEXTVAL,
    '가슴',
    '딥스',
    '이고진',
    '이고진 딥스 바',
    80000,
    95,
    'images/dips_1.jpg',
    'images/dips_1.jpg,images/dips_2.jpg',
    'https://www.igozin.co.kr/product/dips'
);

INSERT INTO TBL_PRODUCT VALUES (
    SEQ_PRODUCT.NEXTVAL,
    '등',
    '풀업바',
    '반석',
    '반석 천장형 풀업바',
    120000,
    150,
    'images/pullup_1.jpg',
    'images/pullup_1.jpg,images/pullup_2.jpg,images/pullup_3.jpg',
    'https://www.banseok.co.kr/product/pullup'
);

INSERT INTO TBL_PRODUCT VALUES (
    SEQ_PRODUCT.NEXTVAL,
    '하체',
    '스쿼트랙',
    '이고진',
    '이고진 파워랙 스쿼트랙',
    350000,
    200,
    'images/squat_1.jpg',
    'images/squat_1.jpg,images/squat_2.jpg,images/squat_3.jpg,images/squat_4.jpg',
    'https://www.igozin.co.kr/product/squat'
);

INSERT INTO TBL_PRODUCT VALUES (
    SEQ_PRODUCT.NEXTVAL,
    '유산소',
    '러닝머신',
    '반석',
    '반석 접이식 러닝머신',
    500000,
    180,
    'images/running_1.jpg',
    'images/running_1.jpg,images/running_2.jpg,images/running_3.jpg',
    'https://www.banseok.co.kr/product/running'
);

COMMIT;







