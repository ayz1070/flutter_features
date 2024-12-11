import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/shipping_address.dart';
import '../../domain/usecases/shipping_address_use_case.dart';
import 'shipping_address_event.dart';
import 'shipping_address_state.dart';

class ShippingAddressBloc extends Bloc<ShippingAddressEvent, ShippingAddressState> {
  final ShippingAddressUseCases useCases;

  ShippingAddressBloc({required this.useCases}) : super(ShippingAddressInitial()) {
    // 이벤트 핸들러 등록
    on<LoadShippingAddressesEvent>(_onLoadShippingAddresses);
    on<AddShippingAddressEvent>(_onAddShippingAddress);
    on<RemoveShippingAddressEvent>(_onRemoveShippingAddress);
    on<UpdateShippingAddressEvent>(_onUpdateShippingAddress);
  }

  // LoadShippingAddressesEvent 처리
  Future<void> _onLoadShippingAddresses(
      LoadShippingAddressesEvent event,
      Emitter<ShippingAddressState> emit,
      ) async {
    emit(ShippingAddressLoading());
    try {
      final addresses = await useCases.getShippingAddressesUseCase.call();
      emit(ShippingAddressLoaded(addresses));
    } catch (e) {
      emit(ShippingAddressError('Error loading shipping addresses'));
    }
  }

  // AddShippingAddressEvent 처리
  Future<void> _onAddShippingAddress(
      AddShippingAddressEvent event,
      Emitter<ShippingAddressState> emit,
      ) async {
    try {
      await useCases.addShippingAddressUseCase.call(event.address);
      final addresses = await useCases.getShippingAddressesUseCase.call();
      emit(ShippingAddressLoaded(addresses));
    } catch (e) {
      emit(ShippingAddressError('Error adding shipping address'));
    }
  }

  // RemoveShippingAddressEvent 처리
  Future<void> _onRemoveShippingAddress(
      RemoveShippingAddressEvent event,
      Emitter<ShippingAddressState> emit,
      ) async {
    try {
      await useCases.removeShippingAddressUseCase.call(event.id);
      final addresses = await useCases.getShippingAddressesUseCase.call();
      emit(ShippingAddressLoaded(addresses));
    } catch (e) {
      emit(ShippingAddressError('Error removing shipping address'));
    }
  }

  // UpdateShippingAddressEvent 처리
  Future<void> _onUpdateShippingAddress(
      UpdateShippingAddressEvent event,
      Emitter<ShippingAddressState> emit,
      ) async {
    try {
      await useCases.updateShippingAddressUseCase.call(event.address);
      final addresses = await useCases.getShippingAddressesUseCase.call();
      emit(ShippingAddressLoaded(addresses));
    } catch (e) {
      emit(ShippingAddressError('Error updating shipping address'));
    }
  }
}