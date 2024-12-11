import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_features/features/address_management/presentation/widgets/shipping_address_add_widgets/red_dot.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../bloc/shipping_address_add_bloc.dart';
import '../../bloc/shipping_address_add_event.dart';
import '../../bloc/shipping_address_add_state.dart';

class PhoneNumberInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Row(
          children: [
            Text(
              '연락처',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            RedDot(),
          ],
        ),
        SizedBox(height: 8),
        BlocBuilder<ShippingAddressAddBloc, ShippingAddressAddState>(
          builder: (context, state) {
            return TextFormField(
              initialValue: state.phoneNumber,
              decoration: InputDecoration(
                hintText: '연락처 입력',
                hintStyle: TextStyle(
                  color: AppColors.textHintPrimaryColor,
                ),
                fillColor: AppColors.textFieldBackgroundPrimaryColor,
                filled: true,
                errorStyle: AppTextStyles.medium14.copyWith(color: Color(0xFFE42838),),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8.0),
                ),
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