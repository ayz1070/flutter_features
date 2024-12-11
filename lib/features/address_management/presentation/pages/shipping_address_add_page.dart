import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/theme/app_screen_size.dart';
import '../../../../core/theme/colors.dart';
import '../../domain/entities/shipping_address.dart';
import '../../domain/usecases/shipping_address_use_case.dart';
import '../bloc/shipping_address_add_bloc.dart';
import '../bloc/shipping_address_add_event.dart';
import '../bloc/shipping_address_add_state.dart';
import '../bloc/shipping_address_bloc.dart';
import '../bloc/shipping_address_event.dart';
import '../widgets/address_app_bar.dart';
import '../widgets/shipping_address_add_widgets/address_detail_input_field.dart';
import '../widgets/shipping_address_add_widgets/address_input_field.dart';
import '../widgets/shipping_address_add_widgets/address_name_input_field.dart';
import '../widgets/shipping_address_add_widgets/default_address_checkbox.dart';
import '../widgets/shipping_address_add_widgets/name_input_field.dart';
import '../widgets/shipping_address_add_widgets/phone_number_input_field.dart';
import '../widgets/shipping_address_widgets/address_button.dart';

class ShippingAddressAddPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final ShippingAddress? existingAddress; // 수정 모드일 경우 기존 주소 전달

  ShippingAddressAddPage({super.key, this.existingAddress});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShippingAddressAddBloc(
        addShippingAddressUseCase: context.read<ShippingAddressUseCases>().addShippingAddressUseCase,
        updateShippingAddressUseCase: context.read<ShippingAddressUseCases>().updateShippingAddressUseCase,
        getShippingAddressesUseCase: context.read<ShippingAddressUseCases>().getShippingAddressesUseCase,
        initialAddress: existingAddress,
      ),
      child: Scaffold(
        backgroundColor: AppColors.backgroundPrimaryColor,
        appBar: AddressAppBar(
          title: existingAddress != null ? '배송지 수정' : '배송지 추가',
          onPressed: () {
            GoRouter.of(context).pop();
          },
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: AppScreenSize.webMaxSize,
            ),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            NameInputField(),
                            SizedBox(height: 16),
                            AddressNameInputField(),
                            SizedBox(height: 8),
                            PhoneNumberInputField(),
                            SizedBox(height: 16),
                            AddressInputField(),
                            SizedBox(height: 16),
                            AddressDetailInputField(),
                            SizedBox(height: 16),
                            DefaultAddressCheckbox(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                BlocListener<ShippingAddressAddBloc, ShippingAddressAddState>(
                  listener: (context, state) {
                    if (state.isSuccess) {
                      // 수정 후 UI 업데이트를 위해 목록 새로고침 이벤트 트리거
                      context.read<ShippingAddressBloc>().add(LoadShippingAddressesEvent());
                      Navigator.pop(context); // 폼 제출 후 성공 시 화면을 닫음
                    } else if (state.errorMessage != null) {
                      // 에러 발생 시 에러 메시지를 화면에 표시
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage!)),
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: BlocBuilder<ShippingAddressAddBloc, ShippingAddressAddState>(
                      builder: (context, state) {
                        return AddressButton(
                          title: '저장',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // ShippingAddress 생성
                              final newAddress = ShippingAddress(
                                id: existingAddress?.id ?? Uuid().v4(),
                                userId: "test_user_id", // 실제 유저 ID를 전달해야 함
                                recipientName: state.name,
                                addressName: state.addressName,
                                phoneNumber: state.phoneNumber,
                                postalCode: state.postalCode, // 수정된 값 반영
                                address: state.address,
                                detailAddress: state.addressDetail, // 수정된 값 반영
                                deliveryRequest: state.deliveryRequest, // 수정된 값 반영
                                isDefaultAddress: state.isDefaultAddress,
                                createdAt: DateTime.now(),
                              );

                              // FormSubmitted 이벤트를 트리거하여 추가/수정 수행
                              context.read<ShippingAddressAddBloc>().add(
                                FormSubmitted(
                                  id: newAddress.id,
                                  isEditMode: existingAddress != null,
                                  userId: newAddress.userId, // 유저 ID 전달
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}