# 홈트레이닝 운동기구 소개 블로그

## 프로젝트 개요
jslhrd 프로젝트를 참고하여 만든 홈트레이닝 운동기구 소개 블로그입니다.

## 프로젝트 구조
```
hometraining/
├── src/main/
│   ├── java/model/
│   │   ├── DBManager.java      (DB 연결)
│   │   ├── ProductDto.java     (제품 데이터 객체)
│   │   └── ProductDao.java     (제품 DB 작업)
│   └── webapp/
│       ├── index.jsp            (메인 페이지)
│       ├── category.jsp         (카테고리 페이지)
│       ├── product.jsp          (제품 목록)
│       ├── detail.jsp           (제품 상세보기)
│       ├── css/
│       │   └── hometraining.css (스타일시트)
│       └── WEB-INF/
│           └── web.xml
├── create_table.sql              (DB 테이블 생성)
└── README.md
```

## 주요 기능
1. **메인 페이지**: 카테고리별 운동기구 소개
2. **드롭다운 메뉴**: 마우스 오버 시 대표 운동기구 표시
3. **카테고리 페이지**: 가슴/등/하체/유산소별 하위 카테고리 표시
4. **제품 목록**: 테이블 형태로 제품 정보 표시
5. **제품 상세**: 이미지 갤러리 및 구매 링크

## DB 설정
1. `create_table.sql` 파일 실행하여 테이블 생성
2. `DBManager.java`에서 DB 연결 정보 수정 (필요시)

## 사용 방법
1. Eclipse에서 Dynamic Web Project로 import
2. Oracle DB 연결 설정
3. `create_table.sql` 실행
4. Tomcat 서버에서 실행

## 참고
- jslhrd 프로젝트 구조 및 스타일 참고
- jspstudy 프로젝트의 DB 연결 방식 참고







