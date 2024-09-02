import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/shipping_address_add_bloc.dart';
import '../../bloc/shipping_address_add_event.dart';
import '../../bloc/shipping_address_add_state.dart';


class PhoneNumberInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '연락처 *',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        BlocBuilder<ShippingAddressAddBloc, ShippingAddressAddState>(
          builder: (context, state) {
            return TextFormField(
              decoration: InputDecoration(
                hintText: '- 빼고 입력해 주세요',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => context
                  .read<ShippingAddressAddBloc>()
                  .add(PhoneNumberChanged(phoneNumber: value)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '연락처를 입력해주세요.';
                }
                return null;
              },
            );
          },
        ),
      ],
    );
  }
}