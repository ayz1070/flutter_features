## 자료

ERD

[https://app.diagrams.net/#G1bzWGb3yAdstvrVpxeEdOj73L6rJfhmYB#{"pageId"%3A"YD3_lEGkiIx3zt-YuQIc"}](https://app.diagrams.net/#G1bzWGb3yAdstvrVpxeEdOj73L6rJfhmYB#%7B%22pageId%22%3A%22YD3_lEGkiIx3zt-YuQIc%22%7D)

유효성 검사 디스크립션
https://docs.google.com/spreadsheets/d/1S2uYFkitiaM-b_CvF8teZsZZQQWs6HpjdmwHAVfs7eU/edit?gid=580195490#gid=580195490

기능 명세서

https://docs.google.com/spreadsheets/d/1S2uYFkitiaM-b_CvF8teZsZZQQWs6HpjdmwHAVfs7eU/edit?gid=550762753#gid=550762753

---

## 기능 요구 사항

### 필수

1. CRUD
   1. 장바구니 상품 생성
   2. 장바구니 상품 조회
   3. 장바구니 상품 삭제
   4. 장바구니 생성 (최소 생성 시 1회)
   5. 장바구니 조회
   6. 장바구니 업데이트
   7. 장바구니 비우기
   8. 장바구니 저장 (로그인 여부)
2. 전체 선택
3. 상품 수량 조절
4. 계산
   1. 총 가격
   2. 총 할인 금액
   3. 총 배송비
   4. 최종 결제 금액
5. 알림 노출

### 추가

1. CRUD
   1. 상품 업데이트

---

## 데이터 모델 설계

https://app.diagrams.net/#G1bzWGb3yAdstvrVpxeEdOj73L6rJfhmYB#%7B%22pageId%22%3A%22YD3_lEGkiIx3zt-YuQIc%22%7D

---

## 기능 구현

### 1. 앱바 (CartAppBar)



- [ ]  백버튼 기능
   - [ ]  백 이전 팝업 표시
- [ ]  알림 노출

### 2. 장바구니 아이템 리스트 (CartListView)



- [ ]  전체 선택 기능
   - [ ]  총 상품 금액 상태 관리
   - [ ]  총 할인 금액 상태 관리
   - [ ]  총 배송비 상태 관리
   - [ ]  최종 결제 금액 상태 관리
- [ ]  수량 계산
   - [ ]  수량 계산 및 상태 관리
   - [ ]  총 상품 금액 상태 관리
   - [ ]  총 할인 금액 상태 관리
   - [ ]  총 배송비 상태 관리
   - [ ]  최종 결제 금액 상태 관리
- [ ]  장바구니 아이템 삭제
- [ ]  개별 장바구니 선택

### 3. 가격 계산 (PriceBox)



- [ ]  상태 관리 반영
   - [ ]  총 상품 금액 계산
   - [ ]  총 할인 금액 계산
   - [ ]  총 배송비 계산
   - [ ]  최종 결제 금액 계산

### 4. 결제하기 버튼 (SubmitButton)



- [ ]  체크된 상품 저장
- [ ]  버튼 클릭 시 유효성 검사
   - [ ]  체크된 상품이 없는 경우 없다는 표시
   - [ ] 

### 5. 빈 페이지 (CartEmptyView)


- [ ]  메인 화면으로 이동

### 6. 다른 페이지에서의 접근 (CartTestPage)

결제 페이지

- [ ]  결제 시 체크된 장바구니 아이템 삭제

상품 상세 페이지

- [ ]  장바구니 아이템 저장
   - [ ]  이미 존재하는 상품은 수량으로 처리
---
### 3) 에러

