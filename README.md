# **인테리어 전문 쇼핑몰 프로젝트**

- **개발 기간** : 2021.10.26. ~ 2021.10.29. + ~ 12.15(추가 수정)
- **참여 인원** : 4명

## **1)** 프로젝트 소개

- **기획 의도**

최근 코로나 장기화로 인한 **집꾸미기 앱 및 인테리어 소품에 대한 수요도 증대**

- **기획 목표**

**고객에게는 정보제공과 소통을 제공**하며, **판매처에게는 고객들에게 자사 상품을 등록**할 수 있는 인테리어 오픈마켓 사이트로 제작방향을 설정하였습니다. 유사 업계인 [오늘의 집]을 벤치마킹하여, **제품 스토어 및 커뮤니티를 제공**하는 것을 목표로 하였습니다.

## 2) **담당 업무**

- `**PM 역할**` 및 `**전체적 구조설계**`
- **`메인`** 화면구현
- `**이메일 문의` ,`자주묻는질문`**  기능(섹션별 조회, 메일발송 등) 및 화면구현
- **`마이페이지`** 기능(회원 권한 변경 및 기존  및 화면구현
- `**회원가입**` 구글STMP를 활용한 회원가입인증 난수코드 발송 메서드 추가

## 3) **개발환경 및 사용기술**

- **`OS`** Windows 10
- **`Language`** JAVA 11
- **`DBMS`** MySQL
- **`Server`** Apache Tomcat v9.0
- **`Back-end`** Java, Spring Framework, MyBatis, JSP
- **`Front-end`** HTML5, CSS3, JavaScript, jQuery, Bootstrap

## 4) **개발 일정**

트렐로를 활용한 스케쥴 관리 진행

![홈픽0-1](https://user-images.githubusercontent.com/85205124/176145594-b9170e67-4556-409f-85f6-5bae6dffa8b4.png)

[Trello](https://trello.com/b/le6Pqd4a/ezen4%EC%A1%B0-teamproject)

## 5) **시스템 설계**

![홈픽0-2](https://user-images.githubusercontent.com/85205124/176145649-be82732e-0530-4453-8c9f-15ad805c848f.png)

## 6) 비즈니스 요구사항

**(1) 일반 회원**
   - [스토어]에서 상품에 대해 리스트 확인 및 상세페이지 내에서 장바구니 및 결제 가능하도록 구현
   - 상품 구매 후 상품별 상세보기에서 해당 제품 리뷰하기
   - [고객센터]에 문의사항을 작성하고 이메일로 제출
   - [마이페이지]에서 작성 게시물/북마크/나의 리뷰 등을 확인하거나, 회원정보 수정 가능
   - [마이페이지]에서 판매자 신청 가능

**(2) 판매자 회원**
   - [스토어]에 상품을 등록할 수 있고, [판매자페이지]에서 자신의 상품 정보에 대해 조회 가능

**(3) 관리자**
   - [관리자페이지]에서 전체 회원을 조회 관리 및 회원등급 변경 가능
   - [이벤트]와 [공지사항]에 글 작성 가능 및 [커뮤니티] 게시판 관리 가능
   - [관리자페이지]에서 모든 커뮤니티 게시판을 관리 가능

## 7) 화면 구성

- **메인 :** 주요 페이지 데이터 호출 및 롤링배너 구현

![홈픽1](https://user-images.githubusercontent.com/85205124/176145691-6a0573e3-8050-4124-b616-fb7f29fd66b7.png)

- **회원 가입** - 이메일 인증 난수코드 8자리 발송 및 인증 확인 가능

![홈픽2](https://user-images.githubusercontent.com/85205124/176145739-a9de4640-b5eb-41fb-8de1-7611fddcdd36.png)

- **통합검색 :** 주요 페이지 데이터 통합검색 조회

![홈픽3](https://user-images.githubusercontent.com/85205124/176145764-926cb77b-05c0-49aa-9378-003f00bc5fed.png)

- **스토어 페이지 :** 카테고리 별 데이터 호출

![홈픽4](https://user-images.githubusercontent.com/85205124/176145790-8f1961bb-7728-4ad1-99d7-5db1e1a88051.png)

- **스토어 > 상품 상세보기 :** 상품 데이터 호출 및 옵션값과 수량 선택 후 장바구니 및 구매 가능

![홈픽5](https://user-images.githubusercontent.com/85205124/176145817-9343925c-1b4f-4e5c-95e0-7061145cd92f.png)

- **주문 결제 :** 주문자 정보, 배송지 정보 입력란 및 상품 정보 호출 및 결제 가능

![홈픽6](https://user-images.githubusercontent.com/85205124/176145847-ecde163a-1d96-4213-a15c-7302a3363038.png)

![홈픽7](https://user-images.githubusercontent.com/85205124/176145859-8afb3fbe-de7d-40db-9567-dc76e12a8a5d.png)

- **커뮤니티 > 집들이 페이지 :** 주거 카테고리별 데이터 호출

![홈픽8](https://user-images.githubusercontent.com/85205124/176145886-ec36d856-3882-4e20-9451-fb13e6428690.png)

- **이벤트 :** 이벤트 데이터 호출

![홈픽9](https://user-images.githubusercontent.com/85205124/176145909-917bd1a9-43cb-4cb9-9f63-01564985d9d2.png)

- **집들이/이벤트 게시물 상세보기 하단 :** 댓글 기능 Ajax 구현 및 시간 표기 설정

![홈픽10](https://user-images.githubusercontent.com/85205124/176145939-e89b19b9-4182-410e-8e1a-1c8edcb87a62.png)

- **관리자 - 회원관리 > 전체 회원 조회 :** 전 회원 CRUD 기능 구현 및 회원등급 변경 가능

![홈픽11](https://user-images.githubusercontent.com/85205124/176145973-e382ed5e-b4a5-491f-b867-e4544b45d76f.png)

- **관리자 - 커뮤니티관리 > 자주묻는 질문 리스트 :** 자주묻는 질문 관리자를 통해 CRUD 가능

![홈픽12](https://user-images.githubusercontent.com/85205124/176146006-5b7cbc93-7aa5-41b1-9e84-e5c8e09cdfc8.png)

- **관리자 - 커뮤니티관리 > 이메일 문의 내역조회 > 상세 :** 1:1 문의에 대한 이메일 전송 답변

![홈픽13](https://user-images.githubusercontent.com/85205124/176146034-7ac98201-e81f-4343-933e-e8bc3b684d38.png)
