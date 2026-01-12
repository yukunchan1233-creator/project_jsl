-- ============================================
-- 홈트레이닝 프로젝트 테이블 삭제 스크립트
-- ============================================
-- 주의: 이 스크립트는 모든 테이블과 데이터를 삭제합니다!
-- ============================================

-- 외래키 때문에 순서가 중요합니다 (자식 테이블 먼저 삭제)

-- 1. 댓글 테이블 삭제
DROP TABLE htm_reply CASCADE CONSTRAINTS;
DROP SEQUENCE htm_reply_seq;

-- 2. 찜하기 테이블 삭제
DROP TABLE htm_mywish CASCADE CONSTRAINTS;
DROP SEQUENCE htm_mywish_seq;

-- 3. 블로그 테이블 삭제
DROP TABLE htm_blog CASCADE CONSTRAINTS;
DROP SEQUENCE htm_blog_seq;

-- 4. 회원 테이블 삭제
DROP TABLE htm_member CASCADE CONSTRAINTS;

-- 5. 상품 테이블 삭제
DROP TABLE TBL_PRODUCT CASCADE CONSTRAINTS;
DROP SEQUENCE SEQ_PRODUCT;

-- 6. 인덱스 삭제 (테이블 삭제 시 자동 삭제되지만 명시적으로)
-- DROP INDEX IDX_PRODUCT_USERID;  -- 테이블 삭제 시 자동 삭제됨

COMMIT;

-- 확인: 테이블이 삭제되었는지 확인
-- SELECT * FROM USER_TABLES WHERE TABLE_NAME IN ('TBL_PRODUCT', 'HTM_MEMBER', 'HTM_BLOG', 'HTM_MYWISH', 'HTM_REPLY');
