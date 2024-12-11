import '../../domain/entities/grade.dart';
import '../../domain/entities/user_grade.dart';
import '../model/user_model.dart';

class UserGradeMapper {
  // UserModel -> UserGrade 변환
  static UserGrade toDomain(UserModel userModel) {
    final grade = Grade.gradeList().firstWhere(
          (grade) => grade.name == userModel.gradeName,
      orElse: () {
        throw Exception("존재하지 않는 등급명입니다.");
      },
    );

    return UserGrade(
      name: userModel.name,
      grade: grade,
      profileImageUrl: userModel.profileImageUrl,
    );
  }

}