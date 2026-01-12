-- TBL_PRODUCT 테이블에 userid와 regdate 필드 추가
-- java02 계정이 등록한 제품들을 관리하기 위한 필드

-- userid 필드 추가 (등록자 아이디)
ALTER TABLE TBL_PRODUCT ADD userid VARCHAR2(50);

-- regdate 필드 추가 (등록일)
ALTER TABLE TBL_PRODUCT ADD regdate DATE DEFAULT SYSDATE;

-- 기존 데이터에 java02 계정 설정 (관리자 계정)
UPDATE TBL_PRODUCT SET userid = 'java02', regdate = SYSDATE WHERE userid IS NULL;

-- userid에 인덱스 추가 (조회 성능 향상)
CREATE INDEX IDX_PRODUCT_USERID ON TBL_PRODUCT(userid);

COMMIT;
