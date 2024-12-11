
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../features/point/data/datasources/point_data_source.dart';
import '../../features/point/data/datasources/point_remote_data_source.dart';
import '../../features/point/data/repositories/point_repository_impl.dart';
import '../../features/point/domain/repositories/point_repository.dart';
import '../../features/point/domain/usecases/point_use_case.dart';
import '../../features/point/presentation/bloc/point_bloc.dart';


class PointProviders {
  static List<RepositoryProvider> repositoryProviders(
      FirebaseFirestore firestore) {
    return [
      // Data Sources
      RepositoryProvider<PointDataSource>(
        create: (_) => PointRemoteDataSource(firestore: firestore),
      ),

      RepositoryProvider<PointRepository>(
        create: (context) => PointRepositoryImpl(
          dataSource: context.read<PointDataSource>(),
        ),
      ),

      RepositoryProvider<FetchPointsByUserIdUseCase>(
        create: (context) => FetchPointsByUserIdUseCase(
          pointRepository: context.read<PointRepository>(),
        ),
      ),
    ];
  }

  static List<BlocProvider> blocProviders = [
    BlocProvider<PointBloc>(
      create: (context) => PointBloc(
        fetchPointsByUserIdUseCase: context.read<FetchPointsByUserIdUseCase>(),
      ),
    ),
  ];
}
