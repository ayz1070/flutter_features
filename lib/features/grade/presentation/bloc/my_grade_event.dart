abstract class MyGradeEvent {}

// 등급 정보를 불러오는 이벤트
class LoadMyGradeEvent extends MyGradeEvent {
  final String documentId;  // 유저의 documentId를 통해 데이터를 가져옴

  LoadMyGradeEvent({required this.documentId});
}

// 에러 처리 이벤트
class MyGradeErrorEvent extends MyGradeEvent {
  final String message;

  MyGradeErrorEvent({required this.message});
}