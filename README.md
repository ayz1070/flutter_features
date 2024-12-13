# Flutter 기능 모음
프로젝트 및 공부했던 Flutter 재사용할 기능들을 정리

프로젝트 수행 및 경험했던 재사용할 Flutter 기능들을 정리

---

## 프로젝트 구조
- 구조 (클린 아키텍처)
  - data
    - data_sources
    - mappers
    - models
    - repository_impls
  - domain
    - repositories
    - use_cases
    - entities
  - presentation
    - bloc
    - pages
    - widgets
    - vm (view_models)
  
---
## 상태 관리
- [x] bloc
- [ ] provider
- [ ] riverpod

---
## 기능 목록
- [ ] board (게시판)
- [ ] cart (장바구니)
- [ ] point (포인트)
- [ ] review (리뷰)

---
## 할 일

### UI
- [ ] 다크 모드 처리 필요
  - [ ] 기능에 진입 시 아이콘들이 흰색으로 설정되어 있어 보이지 않음

### 의존성 주입
- [ ] 전체 기능에 대한 의존성 주입
  - [x] cart
    - [x] data_source
    - [x] repository
    - [x] use_case
    - [x] bloc
  - [ ] address
    - [ ] data_source
    - [ ] repository
    - [ ] use_case
    - [ ] bloc
  - [ ] grade
    - [ ] data_source
    - [ ] repository
    - [ ] use_case
    - [ ] bloc
  - [x] home
    - [x] data_source
    - [x] repository
    - [x] use_case
    - [x] bloc
  - [ ] point
    - [ ] data_source
    - [ ] repository
    - [ ] use_case
    - [ ] bloc
  - [ ] review
    - [ ] data_source
    - [ ] repository
    - [ ] use_case
    - [ ] bloc

### 

### 에러

- [ ] 파이어베이스 연동 오류
  - [x] 파이어베이스 연동 오류 -> write, read 권한 if true 로 수정하여 누구나 접근할 수 있게 수정
  - [ ] 연결 실패에 대한 처리
