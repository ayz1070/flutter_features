import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/shipping_address.dart';
import '../../domain/usecases/shipping_address_use_case.dart';
import 'shipping_address_add_event.dart';
import 'shipping_address_add_state.dart';

class ShippingAddressAddBloc extends Bloc<ShippingAddressAddEvent, ShippingAddressAddState> {
  final AddShippingAddressUseCase addShippingAddressUseCase;
  final UpdateShippingAddressUseCase updateShippingAddressUseCase;
  final GetShippingAddressesUseCase getShippingAddressesUseCase;

  ShippingAddressAddBloc({
    required this.addShippingAddressUseCase,
    required this.updateShippingAddressUseCase,
    required this.getShippingAddressesUseCase,
    ShippingAddress? initialAddress,
  }) : super(initialAddress != null
      ? ShippingAddressAddState(
    name: initialAddress.recipientName,
    addressName: initialAddress.addressName,
    phoneNumber: initialAddress.phoneNumber,
    address: initialAddress.address,
    addressDetail: initialAddress.detailAddress, // 상세 주소 필드 추가
    postalCode: initialAddress.postalCode,
    isDefaultAddress: initialAddress.isDefaultAddress,
    formValid: true, // 수정 시 폼은 기본적으로 유효한 상태
  )
      : const ShippingAddressAddState()) {
    // 이벤트 처리 핸들러 등록
    on<NameChanged>(_onNameChanged);
    on<AddressNameChanged>(_onAddressNameChanged);
    on<PhoneNumberChanged>(_onPhoneNumberChanged);
    on<AddressChanged>(_onAddressChanged);
    on<AddressDetailChanged>(_onAddressDetailChanged); // 상세 주소 이벤트 추가
    on<PostalCodeChanged>(_onPostalCodeChanged);
    on<IsDefaultAddressToggled>(_onIsDefaultAddressToggled);
    on<FormSubmitted>(_onFormSubmitted);
  }

  // 이름 변경 이벤트 처리
  void _onNameChanged(NameChanged event, Emitter<ShippingAddressAddState> emit) {
    emit(state.copyWith(name: event.name, formValid: _isFormValid()));
  }

  // 주소 이름 변경 이벤트 처리
  void _onAddressNameChanged(AddressNameChanged event, Emitter<ShippingAddressAddState> emit) {
    emit(state.copyWith(addressName: event.addressName, formValid: _isFormValid()));
  }

  // 전화번호 변경 이벤트 처리
  void _onPhoneNumberChanged(PhoneNumberChanged event, Emitter<ShippingAddressAddState> emit) {
    emit(state.copyWith(phoneNumber: event.phoneNumber, formValid: _isFormValid()));
  }

  // 주소 변경 이벤트 처리
  void _onAddressChanged(AddressChanged event, Emitter<ShippingAddressAddState> emit) {
    emit(state.copyWith(address: event.address, formValid: _isFormValid()));
  }

  // 상세 주소 변경 이벤트 처리
  void _onAddressDetailChanged(AddressDetailChanged event, Emitter<ShippingAddressAddState> emit) {
    emit(state.copyWith(addressDetail: event.addressDetail, formValid: _isFormValid()));
  }

  // 우편번호 변경 이벤트 처리 추가
  void _onPostalCodeChanged(PostalCodeChanged event, Emitter<ShippingAddressAddState> emit) {
    emit(state.copyWith(postalCode: event.postalCode, formValid: _isFormValid()));
  }

  // 기본 배송지 토글 이벤트 처리
  void _onIsDefaultAddressToggled(IsDefaultAddressToggled event, Emitter<ShippingAddressAddState> emit) {
    emit(state.copyWith(isDefaultAddress: event.isDefaultAddress));
  }



  // 폼 제출 이벤트 처리
  Future<void> _onFormSubmitted(FormSubmitted event, Emitter<ShippingAddressAddState> emit) async {
    if (state.formValid) {
      final shippingAddress = ShippingAddress(
        id: event.id,
        userId: event.userId,
        recipientName: state.name,
        addressName: state.addressName,
        phoneNumber: state.phoneNumber,
        postalCode: state.postalCode,
        address: state.address,
        detailAddress: state.addressDetail,
        deliveryRequest: state.deliveryRequest,
        isDefaultAddress: state.isDefaultAddress,
        createdAt: DateTime.now(),
      );

      emit(state.copyWith(isSubmitting: true));

      try {
        // 현재 모든 주소를 가져옴
        final allAddresses = await getShippingAddressesUseCase.call();

        // 새로운 주소가 기본 배송지로 설정되면, 기존 기본 배송지를 비활성화
        if (shippingAddress.isDefaultAddress) {
          final updatedAddresses = allAddresses.map((address) {
            if (address.isDefaultAddress) {
              return address.copyWith(isDefaultAddress: false);
            }
            return address;
          }).toList();

          // 기본 배송지가 false로 된 주소들 업데이트
          for (final address in updatedAddresses) {
            await updateShippingAddressUseCase.call(address);
          }
        }

        // 새로운 주소 추가 또는 업데이트
        if (event.isEditMode) {
          await updateShippingAddressUseCase.call(shippingAddress);
        } else {
          await addShippingAddressUseCase.call(shippingAddress);
        }

        emit(state.copyWith(isSuccess: true, isSubmitting: false));
      } catch (error) {
        emit(state.copyWith(isSubmitting: false, errorMessage: 'Error submitting form: $error'));
      }
    }
  }


  // 폼 유효성 검사
  bool _isFormValid() {
    return state.name.isNotEmpty &&
        state.phoneNumber.isNotEmpty &&
        state.address.isNotEmpty &&
        state.addressDetail.isNotEmpty; // 상세 주소 유효성 검사 추가
  }
}