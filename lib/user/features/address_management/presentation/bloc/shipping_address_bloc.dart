import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/shipping_address.dart';
import '../../domain/services/shipping_address_service.dart';

class ShippingAddressBloc extends Cubit<List<ShippingAddress>> {
  final ShippingAddressService service;

  ShippingAddressBloc({required this.service}) : super([]);

  Future<void> loadShippingAddresses() async {
    final addresses = await service.getShippingAddresses();
    emit(addresses);
  }

  Future<void> addShippingAddress(ShippingAddress address) async {
    await service.addShippingAddress(address);
    await loadShippingAddresses();
  }

  Future<void> removeShippingAddress(String id) async {
    await service.removeShippingAddress(id);
    await loadShippingAddresses();
  }
}