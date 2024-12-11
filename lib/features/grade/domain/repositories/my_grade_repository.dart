import '../entities/user_grade.dart';

abstract class MyGradeRepository {
  // 유저의 등급 정보를 가져오는 메소드
  Future<UserGrade> fetchUserGradeInfo(String documentId);
}