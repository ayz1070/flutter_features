import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/colors.dart';
import '../../bloc/shipping_address_add_bloc.dart';
import '../../bloc/shipping_address_add_event.dart';
import '../../bloc/shipping_address_add_state.dart';


class AddressNameInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '배송지명',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        BlocBuilder<ShippingAddressAddBloc, ShippingAddressAddState>(
          builder: (context, state) {
            return TextFormField(
              initialValue: state.addressName ?? '',
              decoration: InputDecoration(
                hintText: '배송지 닉네임 입력 (예: 회사, 집)',
                hintStyle: TextStyle(
                  color: AppColors.textHintPrimaryColor,
                ),
                fillColor: AppColors.textFieldBackgroundPrimaryColor,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) => context
                  .read<ShippingAddressAddBloc>()
                  .add(AddressNameChanged(addressName: value)),
            );
          },
        ),
      ],
    );
  }
}