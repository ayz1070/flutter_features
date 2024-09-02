import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_features/user/features/address_management/data/datasources/shipping_address_local_data_source.dart';
import 'package:flutter_features/user/features/address_management/data/repositories/shipping_address_repository_impl.dart';
import 'package:flutter_features/user/features/address_management/domain/repositories/shipping_address_repository.dart';
import 'package:flutter_features/user/features/address_management/domain/services/shipping_address_service.dart';
import 'package:flutter_features/user/features/address_management/presentation/bloc/shipping_address_bloc.dart';
import 'package:flutter_features/user/features/address_management/presentation/pages/shipping_address_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        // ShippingAddressLocalDataSource 제공
        RepositoryProvider<ShippingAddressLocalDataSource>(
          create: (_) => ShippingAddressLocalDataSourceImpl(),
        ),
        // ShippingAddressRepository 제공
        RepositoryProvider<ShippingAddressRepository>(
          create: (context) => ShippingAddressRepositoryImpl(
            context.read<ShippingAddressLocalDataSource>(),
          ),
        ),
        // ShippingAddressService 제공
        RepositoryProvider<ShippingAddressService>(
          create: (context) => ShippingAddressService(
            context.read<ShippingAddressRepository>(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ShippingAddressBloc>(
            create: (context) => ShippingAddressBloc(
              service: context.read<ShippingAddressService>(),
            )..loadShippingAddresses(),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: ShippingAddressPage(),
        ),
      ),
    );
  }
}

