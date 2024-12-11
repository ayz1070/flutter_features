import '../datasources/my_grade_data_source.dart';
import '../../domain/entities/user_grade.dart';
import '../../domain/repositories/my_grade_repository.dart';
import '../mapper/user_grade_mapper.dart';

class MyGradeRepositoryImpl implements MyGradeRepository {
  final MyGradeDataSource dataSource;

  MyGradeRepositoryImpl(this.dataSource);

  @override
  Future<UserGrade> fetchUserGradeInfo(String documentId) async {
    try {
      final userModel = await dataSource.fetchUserGradeInfo(documentId);

      return UserGradeMapper.toDomain(userModel);
    } catch (e) {
      throw Exception('Repository : $e');
    }
  }
}