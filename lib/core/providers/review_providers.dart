import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/review/data/datasources/product_data_source.dart';
import '../../features/review/data/datasources/product_remote_data_source.dart';
import '../../features/review/data/datasources/purchased_product_data_source.dart';
import '../../features/review/data/datasources/purchased_product_remote_data_source.dart';
import '../../features/review/data/datasources/review_data_source.dart';
import '../../features/review/data/datasources/review_remote_data_source.dart';
import '../../features/review/data/repository_impls/purchased_product_repository_impl.dart';
import '../../features/review/data/repository_impls/review_repository_impl.dart';
import '../../features/review/domain/repositories/purchased_product_repository.dart';
import '../../features/review/domain/repositories/review_repository.dart';
import '../../features/review/domain/usecases/purchased_product_use_case.dart';
import '../../features/review/domain/usecases/review_use_case.dart';
import '../../features/review/presentation/bloc/review_add_bloc.dart';
import '../../features/review/presentation/bloc/review_bloc.dart';

class ReviewProviders {
  static List<RepositoryProvider> repositoryProviders(FirebaseFirestore firestore) {
    return [
      RepositoryProvider<ReviewDataSource>(
        create: (_) => ReviewRemoteDataSource(firestore: firestore),
      ),
      RepositoryProvider<PurchasedProductDataSource>(
        create: (_) => PurchasedProductRemoteDataSource(firestore: firestore),
      ),
      RepositoryProvider<ProductDataSource>(
        create: (_) => ProductRemoteDataSource(firestore: firestore),
      ),

      // 리포지토리 의존성 주입
      RepositoryProvider<ReviewRepository>(
        create: (context) => ReviewRepositoryImpl(
          remoteDataSource: context.read<ReviewDataSource>(),
        ),
      ),
      RepositoryProvider<PurchasedProductRepository>(
        create: (context) => PurchasedProductRepositoryImpl(
          purchasedProductRemoteDataSource:
              context.read<PurchasedProductDataSource>(),
          productDataSource: context.read<ProductDataSource>(),
        ),
      ),

      // 유스케이스 개별 의존성 주입
      RepositoryProvider<SaveReviewUseCase>(
        create: (context) => SaveReviewUseCase(
          repository: context.read<ReviewRepository>(),
        ),
      ),
      RepositoryProvider<UpdateReviewUseCase>(
        create: (context) => UpdateReviewUseCase(
          repository: context.read<ReviewRepository>(),
        ),
      ),
      RepositoryProvider<DeleteReviewUseCase>(
        create: (context) => DeleteReviewUseCase(
          repository: context.read<ReviewRepository>(),
        ),
      ),
      RepositoryProvider<FetchPurchasedProductsWithDetailsUseCase>(
        create: (context) => FetchPurchasedProductsWithDetailsUseCase(
          context.read<PurchasedProductRepository>(),
        ),
      ),
      RepositoryProvider<FetchReviewsByUserUseCase>(
        create: (context) => FetchReviewsByUserUseCase(
          repository: context.read<ReviewRepository>(),
        ),
      ),

      RepositoryProvider<ReviewUseCases>(
        create: (context) => ReviewUseCases(
          repository: context.read<ReviewRepository>(),
        ),
      ),
    ];
  }

  static List<BlocProvider> blocProviders = [
    BlocProvider<ReviewBloc>(
      create: (context) => ReviewBloc(
        fetchPurchasedProductsUseCase:
            context.read<FetchPurchasedProductsWithDetailsUseCase>(),
        fetchReviewsByUserUseCase: context.read<FetchReviewsByUserUseCase>(),
        deleteReviewUseCase: context.read<DeleteReviewUseCase>(),
      ),
    ),
    BlocProvider<ReviewAddBloc>(
      create: (context) => ReviewAddBloc(
        saveReviewUseCase: context.read<SaveReviewUseCase>(),
        updateReviewUseCase: context.read<UpdateReviewUseCase>(),
        deleteReviewUseCase: context.read<DeleteReviewUseCase>(),
      ),
    ),
  ];
}
