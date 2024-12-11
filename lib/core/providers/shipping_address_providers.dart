import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/address_management/data/datasources/shipping_address_data_source.dart';
import '../../features/address_management/data/datasources/shipping_address_firebase_data_source.dart';
import '../../features/address_management/data/repository_impls/shipping_address_repository_impl.dart';
import '../../features/address_management/domain/repositories/shipping_address_repository.dart';
import '../../features/address_management/domain/usecases/shipping_address_use_case.dart';
import '../../features/address_management/presentation/bloc/shipping_address_bloc.dart';

class ShippingAddressProviders {
  static List<RepositoryProvider> repositoryProviders = [
    RepositoryProvider<ShippingAddressDataSource>(
      create: (_) => ShippingAddressFirebaseDataSource(),
    ),
    RepositoryProvider<ShippingAddressRepository>(
      create: (context) =>
          ShippingAddressRepositoryImpl(
            context.read<ShippingAddressDataSource>(),
          ),
    ),
    RepositoryProvider<ShippingAddressUseCases>(
      create: (context) =>
          ShippingAddressUseCases(
            context.read<ShippingAddressRepository>(),
          ),
    ),
  ];

  static List<BlocProvider> blocProviders = [
    BlocProvider<ShippingAddressBloc>(
      create: (context) =>
      ShippingAddressBloc(
        useCases: context.read<ShippingAddressUseCases>(),
      ),
    ),
  ];
}
