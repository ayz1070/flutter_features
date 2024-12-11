import '../../domain/entities/grade.dart';
import '../../domain/entities/user_grade.dart';

abstract class MyGradeState {}

class MyGradeInitState extends MyGradeState {}

class MyGradeLoadingState extends MyGradeState {}

class MyGradeLoadedState extends MyGradeState {
  final List<Grade> grades;
  final UserGrade userGrade;  // UserGrade를 직접 사용

  MyGradeLoadedState({
    required this.grades,
    required this.userGrade,
  });
}

class MyGradeErrorState extends MyGradeState {
  final String message;

  MyGradeErrorState({
    required this.message,
  });
}