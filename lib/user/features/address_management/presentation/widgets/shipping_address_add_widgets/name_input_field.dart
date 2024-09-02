import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/shipping_address_add_bloc.dart';
import '../../bloc/shipping_address_add_event.dart';
import '../../bloc/shipping_address_add_state.dart';


class NameInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '이름 *',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        BlocBuilder<ShippingAddressAddBloc, ShippingAddressAddState>(
          builder: (context, state) {
            return TextFormField(
              decoration: InputDecoration(
                hintText: '이름 입력',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => context
                  .read<ShippingAddressAddBloc>()
                  .add(NameChanged(name: value)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '이름을 입력해주세요.';
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