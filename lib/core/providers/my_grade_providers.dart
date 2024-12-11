import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/grade/data/datasources/my_grade_data_source.dart';
import '../../features/grade/data/repositories/my_grade_repository_impl.dart';
import '../../features/grade/domain/repositories/my_grade_repository.dart';
import '../../features/grade/domain/usecases/fetch_login_user_grade_use_case.dart';
import '../../features/grade/presentation/bloc/my_grade_bloc.dart';
import '../../features/grade/presentation/bloc/my_grade_event.dart';

class MyGradeProviders {
  static List<RepositoryProvider> repositoryProviders(
      FirebaseFirestore firestore) {
    return [
      RepositoryProvider<MyGradeDataSource>(
        create: (_) => MyGradeDataSourceImpl(firestore),
      ),
      RepositoryProvider<MyGradeRepository>(
        create: (context) =>
            MyGradeRepositoryImpl(
              context.read<MyGradeDataSource>(),
            ),
      ),
      RepositoryProvider<FetchLoginUserGradeUseCase>(
        create: (context) =>
            FetchLoginUserGradeUseCase(
              context.read<MyGradeRepository>(),
            ),
      ),
    ];
  }

  static List<BlocProvider> blocProvider = [
    BlocProvider<MyGradeBloc>(
      create: (context) =>
      MyGradeBloc(
        fetchUserGradeUseCase: context.read<
            FetchLoginUserGradeUseCase>(), // myGradeUseCase → fetchUserGradeUseCase로 수정
      )
        ..add(LoadMyGradeEvent(documentId: 'test')), // documentId 전달
    )
  ];
}
