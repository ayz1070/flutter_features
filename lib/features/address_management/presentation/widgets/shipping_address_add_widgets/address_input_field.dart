import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 조건부 import 설정
import 'package:flutter_features/core/utils/kpostal_stub.dart';
import 'package:flutter_features/features/address_management/presentation/widgets/shipping_address_add_widgets/red_dot.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../bloc/shipping_address_add_bloc.dart';
import '../../bloc/shipping_address_add_event.dart';
import '../../bloc/shipping_address_add_state.dart';


class AddressInputField extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '주소',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            RedDot(),
          ],
        ),
        SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: BlocBuilder<ShippingAddressAddBloc, ShippingAddressAddState>(
                builder: (context, state) {
                  return TextFormField(
                    decoration: InputDecoration(
                      hintText: state.address.isEmpty ? '주소를 입력하세요' : state.address,
                      hintStyle: TextStyle(color: AppColors.textHintPrimaryColor),
                      fillColor: AppColors.textFieldBackgroundPrimaryColor,
                      filled: true,
                      errorStyle: AppTextStyles.medium14.copyWith(color: Color(0xFFE42838),),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    readOnly: true,

                    validator: (value) {
                      if (state.address.isEmpty) {
                        return '주소를 선택하세요.';
                      }
                      return null;
                    },
                  );
                },
              ),
            ),
            SizedBox(width: 8),
            ElevatedButton(
              onPressed: () async {
                // 플랫폼에 맞는 PostalView의 구체적인 구현체를 조건부로 호출
                print('웹 os 여부: $kIsWeb');

                PostalView postalView = PostalView();
                //final postalView2 = kIsWeb ? PostalView() : PostalView();


                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => postalView.buildPostalView(
                      context,
                          (address, postalCode) {
                        // 상태 업데이트 - address와 postalCode
                        context.read<ShippingAddressAddBloc>().add(
                          AddressChanged(address: address),
                        );
                        context.read<ShippingAddressAddBloc>().add(
                          PostalCodeChanged(postalCode: postalCode),
                        );
                      },
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: AppColors.primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),

              ),
              child: Text('주소 찾기'),
            ),
          ],
        ),
      ],
    );
  }
}