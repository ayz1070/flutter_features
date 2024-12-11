import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/utils/formatter.dart';
import 'custom_dialog.dart';

class AddressCard extends StatelessWidget {
  final String name;
  final String addressName;
  final String postalCode;
  final String address;
  final String detailAddress;
  final String phone;
  final bool isDefault;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  AddressCard({
    required this.name,
    required this.addressName,
    required this.postalCode,
    required this.address,
    required this.detailAddress,
    required this.phone,
    required this.isDefault,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      color: AppColors.backgroundPrimaryColor,
      shadowColor: AppColors.backgroundPrimaryColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 16.0, // 글자 크기 확대
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  addressName,
                  style: TextStyle(
                    color: AppColors.textTertiaryColor,
                    fontSize: 14.0,
                  ),
                ),
                if (isDefault)
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Color(0x14F06B23), // 연한 오렌지 배경
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      '기본 배송지',
                      style: TextStyle(
                        color: Color(0xFFF06B23),
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              "[$postalCode] $address",
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            Text(
              "$detailAddress",
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              "${Formatter.formatPhoneNumber(phone)}",
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: (){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDialog(
                            title: '삭제하시겠습니까?',
                            content: '확인을 누르면 선택한 배송지가 삭제됩니다.',
                            confirmTitle: "확인",
                            onConfirm: () {
                              // 삭제 확인 시 호출
                              onDelete();
                              Navigator.of(context).pop(); // 다이얼로그 닫기
                            },
                            cancelTitle: "취소",
                            onCancel: () {
                              // 취소 시 다이얼로그 닫기
                              Navigator.of(context).pop();
                            },
                          );
                        },
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 12.0),
                      side: BorderSide(color: Colors.grey.shade300),
                      // 테두리 회색
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      fixedSize: Size(140, 38),
                    ),
                    child: Text(
                      '삭제',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: TextButton(
                    onPressed: onEdit,
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 12.0),
                      side: BorderSide(color: Colors.grey.shade300),
                      // 테두리 회색
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      fixedSize: Size(140, 38),
                    ),
                    child: Text(
                      '수정',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

