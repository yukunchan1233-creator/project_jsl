-- ============================================
-- 홈트레이닝 프로젝트 - 필요한 테이블만 생성
-- ============================================
-- 기존 데이터를 보존하면서 없는 테이블만 생성합니다
-- ============================================

-- ============================================
-- 1. 상품 테이블 (TBL_PRODUCT) - 이미 생성됨
-- ============================================
-- TBL_PRODUCT는 이미 생성되어 있으므로 스킵
-- 만약 userid, regdate 컬럼이 없다면 추가해야 함

-- userid 컬럼이 있는지 확인 후 없으면 추가
BEGIN
    EXECUTE IMMEDIATE 'ALTER TABLE TBL_PRODUCT ADD userid VARCHAR2(50)';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -1430 THEN  -- 컬럼이 이미 존재하는 경우
            NULL;  -- 무시하고 계속
        ELSE
            RAISE;
        END IF;
END;
/

-- regdate 컬럼이 있는지 확인 후 없으면 추가
BEGIN
    EXECUTE IMMEDIATE 'ALTER TABLE TBL_PRODUCT ADD regdate DATE DEFAULT SYSDATE';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -1430 THEN  -- 컬럼이 이미 존재하는 경우
            NULL;  -- 무시하고 계속
        ELSE
            RAISE;
        END IF;
END;
/

-- 인덱스가 없으면 생성
BEGIN
    EXECUTE IMMEDIATE 'CREATE INDEX IDX_PRODUCT_USERID ON TBL_PRODUCT(userid)';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -955 THEN  -- 인덱스가 이미 존재하는 경우
            NULL;  -- 무시하고 계속
        ELSE
            RAISE;
        END IF;
END;
/

-- ============================================
-- 2. 회원 테이블 (htm_member)
-- ============================================
-- 테이블이 없으면 생성
BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE htm_member (
        userid VARCHAR2(50) NOT NULL,
        writer VARCHAR2(20) NOT NULL,
        password VARCHAR2(300),
        phone VARCHAR2(20),
        email VARCHAR2(50) NOT NULL,
        CONSTRAINT htm_mem_pk PRIMARY KEY(userid)
    )';
    DBMS_OUTPUT.PUT_LINE('htm_member 테이블 생성 완료');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -955 THEN  -- 테이블이 이미 존재하는 경우
            DBMS_OUTPUT.PUT_LINE('htm_member 테이블은 이미 존재합니다');
        ELSE
            RAISE;
        END IF;
END;
/

-- ============================================
-- 3. 블로그 테이블 (htm_blog)
-- ============================================
BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE htm_blog (
        bno NUMBER NOT NULL,
        name VARCHAR2(20) NOT NULL,
        title VARCHAR2(100) NOT NULL,
        content VARCHAR2(4000) NOT NULL,
        imgfile VARCHAR2(500) NOT NULL,
        views NUMBER DEFAULT 0,
        regdate DATE DEFAULT SYSDATE,
        CONSTRAINT htm_blog_pk PRIMARY KEY (bno)
    )';
    DBMS_OUTPUT.PUT_LINE('htm_blog 테이블 생성 완료');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -955 THEN
            DBMS_OUTPUT.PUT_LINE('htm_blog 테이블은 이미 존재합니다');
        ELSE
            RAISE;
        END IF;
END;
/

-- 시퀀스 생성
BEGIN
    EXECUTE IMMEDIATE 'CREATE SEQUENCE htm_blog_seq';
    DBMS_OUTPUT.PUT_LINE('htm_blog_seq 시퀀스 생성 완료');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -955 THEN
            DBMS_OUTPUT.PUT_LINE('htm_blog_seq 시퀀스는 이미 존재합니다');
        ELSE
            RAISE;
        END IF;
END;
/

-- ============================================
-- 4. 찜하기 테이블 (htm_mywish)
-- ============================================
BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE htm_mywish (
        wish_bno NUMBER NOT NULL,
        blog_bno NUMBER NOT NULL,
        userid VARCHAR2(50) NOT NULL,
        CONSTRAINT htm_mywish_blog_fk FOREIGN KEY (blog_bno) REFERENCES htm_blog (bno) ON DELETE CASCADE,
        CONSTRAINT htm_mywish_member_fk FOREIGN KEY (userid) REFERENCES htm_member (userid) ON DELETE CASCADE,
        CONSTRAINT htm_mywish_pk PRIMARY KEY (wish_bno),
        CONSTRAINT htm_mywish_unique UNIQUE (blog_bno, userid)
    )';
    DBMS_OUTPUT.PUT_LINE('htm_mywish 테이블 생성 완료');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -955 THEN
            DBMS_OUTPUT.PUT_LINE('htm_mywish 테이블은 이미 존재합니다');
        ELSE
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'CREATE SEQUENCE htm_mywish_seq';
    DBMS_OUTPUT.PUT_LINE('htm_mywish_seq 시퀀스 생성 완료');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -955 THEN
            DBMS_OUTPUT.PUT_LINE('htm_mywish_seq 시퀀스는 이미 존재합니다');
        ELSE
            RAISE;
        END IF;
END;
/

-- ============================================
-- 5. 댓글 테이블 (htm_reply)
-- ============================================
BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE htm_reply (
        bno NUMBER NOT NULL,
        blog_bno NUMBER NOT NULL,
        userid VARCHAR2(50) NOT NULL,
        replytext VARCHAR2(4000) NOT NULL,
        regdate DATE DEFAULT SYSDATE,
        CONSTRAINT htm_replyblog_fk FOREIGN KEY (blog_bno) REFERENCES htm_blog (bno) ON DELETE CASCADE,
        CONSTRAINT htm_replymem_fk FOREIGN KEY (userid) REFERENCES htm_member (userid) ON DELETE CASCADE,
        CONSTRAINT htm_reply_pk PRIMARY KEY (bno)
    )';
    DBMS_OUTPUT.PUT_LINE('htm_reply 테이블 생성 완료');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -955 THEN
            DBMS_OUTPUT.PUT_LINE('htm_reply 테이블은 이미 존재합니다');
        ELSE
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'CREATE SEQUENCE htm_reply_seq';
    DBMS_OUTPUT.PUT_LINE('htm_reply_seq 시퀀스 생성 완료');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -955 THEN
            DBMS_OUTPUT.PUT_LINE('htm_reply_seq 시퀀스는 이미 존재합니다');
        ELSE
            RAISE;
        END IF;
END;
/

COMMIT;

-- 확인
SELECT '생성 완료!' AS 결과 FROM DUAL;
