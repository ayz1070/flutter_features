import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../bloc/shipping_address_bloc.dart';
import '../bloc/shipping_address_add_bloc.dart';
import '../bloc/shipping_address_add_event.dart';
import '../bloc/shipping_address_add_state.dart';
import '../widgets/shipping_address_add_widgets/address_input_field.dart';
import '../widgets/shipping_address_add_widgets/address_name_input_field.dart';
import '../widgets/shipping_address_add_widgets/address_tags.dart';
import '../widgets/shipping_address_add_widgets/default_address_checkbox.dart';
import '../widgets/shipping_address_add_widgets/name_input_field.dart';
import '../widgets/shipping_address_add_widgets/phone_number_input_field.dart';
import '../../domain/models/shipping_address.dart';

class ShippingAddressAddPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  ShippingAddressAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShippingAddressAddBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('배송지 추가'),
        ),
        body: SingleChildScrollView(
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
                  AddressTags(),
                  SizedBox(height: 16),
                  PhoneNumberInputField(),
                  SizedBox(height: 16),
                  AddressInputField(),
                  SizedBox(height: 16),
                  DefaultAddressCheckbox(),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<ShippingAddressAddBloc, ShippingAddressAddState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newAddress = ShippingAddress(
                      id: Uuid().v4(), // 고유 ID 생성
                      name: state.name,
                      addressName: state.addressName,
                      phoneNumber: state.phoneNumber,
                      address: state.address,
                      isDefaultAddress: state.isDefaultAddress,
                    );

                    // BLoC을 통해 주소 추가 및 SharedPreferences에 저장
                    context
                        .read<ShippingAddressBloc>()
                        .addShippingAddress(newAddress);
                    Navigator.pop(context); // 이전 화면으로 돌아가기
                  }
                },

                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor:
                  state.formValid ? Colors.grey[300] : Colors.grey[500],
                ),
                child: Text('완료'),
              );
            },
          ),
        ),
      ),
    );
  }
}