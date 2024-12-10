import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../features/cart/data/datasources/cart_data_source.dart';
import '../../features/cart/data/datasources/cart_remote_data_source.dart';
import '../../features/cart/data/datasources/cart_product_data_source.dart';
import '../../features/cart/data/datasources/cart_product_remote_data_source.dart';
import '../../features/cart/data/repositories/cart_product_repository_impl.dart';
import '../../features/cart/data/repositories/cart_repository_impl.dart';
import '../../features/cart/domain/repositories/cart_repository.dart';
import '../../features/cart/domain/repositories/cart_product_repository.dart';
import '../../features/cart/domain/usecases/cart_use_case.dart';
import '../../features/cart/domain/usecases/cart_product_use_case.dart';
import '../../features/cart/presentation/bloc/cart_bloc.dart';

class CartProviders {
  static List<RepositoryProvider> repositoryProviders(
      FirebaseFirestore firestore) {
    return [
      // Data Sources
      RepositoryProvider<CartDataSource>(
        create: (_) => CartRemoteDataSource(firestore: firestore),
      ),
      RepositoryProvider<CartProductDataSource>(
        create: (_) => CartProductRemoteDataSource(firestore: firestore),
      ),

      // Repositories
      RepositoryProvider<CartRepository>(
        create: (context) => CartRepositoryImpl(
          dataSource: context.read<CartDataSource>(),
        ),
      ),
      RepositoryProvider<CartProductRepository>(
        create: (context) => CartProductRepositoryImpl(
          dataSource: context.read<CartProductDataSource>(),
        ),
      ),

      // Use Cases - Cart
      RepositoryProvider<SaveCartUseCase>(
        create: (context) => SaveCartUseCase(
          cartRepository: context.read<CartRepository>(),
        ),
      ),

      RepositoryProvider<ClearCartUseCase>(
        create: (context) => ClearCartUseCase(
          cartRepository: context.read<CartRepository>(),
        ),
      ),
      RepositoryProvider<DeleteCartUseCase>(
        create: (context) => DeleteCartUseCase(
          cartRepository: context.read<CartRepository>(),
        ),
      ),

      RepositoryProvider<CheckoutCartUseCase>(
        create: (context) => CheckoutCartUseCase(
          cartRepository: context.read<CartRepository>(),
        ),
      ),

      RepositoryProvider<FetchCartByUserIdUseCase>(
        create: (context) => FetchCartByUserIdUseCase(
          cartRepository: context.read<CartRepository>(),
        ),
      ),


      // Use Cases - Cart Products
      RepositoryProvider<SaveCartProductUseCase>(
        create: (context) => SaveCartProductUseCase(
          cartProductRepository: context.read<CartProductRepository>(),
          cartRepository: context.read<CartRepository>(),
        ),
      ),
      RepositoryProvider<FetchCartProductsByCartIdUseCase>(
        create: (context) => FetchCartProductsByCartIdUseCase(
          cartProductRepository: context.read<CartProductRepository>(),
        ),
      ),
      RepositoryProvider<UpdateCartProductUseCase>(
        create: (context) => UpdateCartProductUseCase(
          cartProductRepository: context.read<CartProductRepository>(),
        ),
      ),
      RepositoryProvider<DeleteCartProductUseCase>(
        create: (context) => DeleteCartProductUseCase(
          cartProductRepository: context.read<CartProductRepository>(),
        ),
      ),

      // Use Case - Calculate Cart Summary
    ];
  }

  static List<BlocProvider> blocProviders = [
    BlocProvider<CartBloc>(
      create: (context) => CartBloc(
        fetchCartProductsByCartIdUseCase:
            context.read<FetchCartProductsByCartIdUseCase>(),
        updateCartProductUseCase: context.read<UpdateCartProductUseCase>(),
        deleteCartProductUseCase: context.read<DeleteCartProductUseCase>(),
        checkoutCartUseCase: context.read<CheckoutCartUseCase>(),
        fetchCartByUserIdUseCase: context.read<FetchCartByUserIdUseCase>(),
      ),
    ),
  ];
}
