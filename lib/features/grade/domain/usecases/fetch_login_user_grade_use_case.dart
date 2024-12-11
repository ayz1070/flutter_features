import '../../domain/entities/user_grade.dart';
import '../../domain/repositories/my_grade_repository.dart';

class FetchLoginUserGradeUseCase {
  final MyGradeRepository repository;

  FetchLoginUserGradeUseCase(this.repository);

  Future<UserGrade> execute(String documentId) async {
    // Repository에서 UserGrade 가져옴
    final userGrade = await repository.fetchUserGradeInfo(documentId);

    // 가져온 UserGrade를 그대로 반환
    return userGrade;
  }
}