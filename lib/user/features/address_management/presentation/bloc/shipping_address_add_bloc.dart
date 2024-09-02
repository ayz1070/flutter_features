import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/models/shipping_address.dart';
import 'shipping_address_add_event.dart';
import 'shipping_address_add_state.dart';
import '../../data/entities/shipping_address_entity.dart';

class ShippingAddressAddBloc extends Bloc<ShippingAddressAddEvent, ShippingAddressAddState> {
  ShippingAddressAddBloc() : super(const ShippingAddressAddState()) {
    on<NameChanged>(_onNameChanged);
    on<AddressNameChanged>(_onAddressNameChanged);
    on<PhoneNumberChanged>(_onPhoneNumberChanged);
    on<AddressChanged>(_onAddressChanged);
    on<IsDefaultAddressToggled>(_onIsDefaultAddressToggled);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onNameChanged(NameChanged event, Emitter<ShippingAddressAddState> emit) {
    emit(state.copyWith(name: event.name, formValid: _isFormValid()));
  }

  void _onAddressNameChanged(AddressNameChanged event, Emitter<ShippingAddressAddState> emit) {
    emit(state.copyWith(addressName: event.addressName, formValid: _isFormValid()));
  }

  void _onPhoneNumberChanged(PhoneNumberChanged event, Emitter<ShippingAddressAddState> emit) {
    emit(state.copyWith(phoneNumber: event.phoneNumber, formValid: _isFormValid()));
  }

  void _onAddressChanged(AddressChanged event, Emitter<ShippingAddressAddState> emit) {
    emit(state.copyWith(address: event.address, formValid: _isFormValid()));
  }

  void _onIsDefaultAddressToggled(IsDefaultAddressToggled event, Emitter<ShippingAddressAddState> emit) {
    emit(state.copyWith(isDefaultAddress: event.isDefaultAddress));
  }

  void _onFormSubmitted(FormSubmitted event, Emitter<ShippingAddressAddState> emit) {
    if (state.formValid) {
      // 폼 제출 로직 처리
      final newShippingAddress = ShippingAddress(
        id: event.id,
        name: state.name,
        addressName: state.addressName,
        phoneNumber: state.phoneNumber,
        address: state.address,
        isDefaultAddress: state.isDefaultAddress,
      );

      // 예: 저장 로직 수행 (DB 저장, API 호출 등)
      final entity = newShippingAddress.toEntity();
      // 저장 로직을 수행하는 코드 추가 (repository.save(entity) 등)
    }
  }

  bool _isFormValid() {
    return state.name.isNotEmpty &&
        state.phoneNumber.isNotEmpty &&
        state.address.isNotEmpty;
  }
}