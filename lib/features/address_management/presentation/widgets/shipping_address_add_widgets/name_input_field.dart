import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_features/features/address_management/presentation/widgets/shipping_address_add_widgets/red_dot.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../bloc/shipping_address_add_bloc.dart';
import '../../bloc/shipping_address_add_event.dart';
import '../../bloc/shipping_address_add_state.dart';


class NameInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '받는 사람',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            RedDot(),
          ],
        ),
        SizedBox(height: 8),
        BlocBuilder<ShippingAddressAddBloc, ShippingAddressAddState>(
          builder: (context, state) {
            return TextFormField(
              initialValue: state.name, // 수정 모드에서 기존 값을 보여줌
              decoration: InputDecoration(
                hintText: '이름 입력',
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
                  .add(NameChanged(name: value)), // 이름 변경 이벤트 발생
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '이름을 입력해주세요.'; // 유효성 검사
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