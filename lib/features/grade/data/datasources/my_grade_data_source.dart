import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user_model.dart';

abstract class MyGradeDataSource {
  Future<UserModel> fetchUserGradeInfo(String documentId);
}

class MyGradeDataSourceImpl implements MyGradeDataSource {
  final FirebaseFirestore firestore;

  MyGradeDataSourceImpl(this.firestore);

  @override
  Future<UserModel> fetchUserGradeInfo(String documentId) async {
    try {
      // Firestore에서 documentId를 기반으로 데이터를 가져옴
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await firestore
          .collection('users')
          .doc(documentId)
          .get();

      // Document가 존재하는지 체크
      if (documentSnapshot.exists) {
        Map<String, dynamic>? data = documentSnapshot.data();

        // 데이터가 null인지 확인 후 처리
        if (data == null) {
          throw Exception("DataSource: documentId에 해당하는 데이터 없음: $documentId");
        }

        // UserModel로 변환하여 반환, id 필드 추가
        return UserModel.fromJson({
          ...data,  // 기존 데이터
          'id': documentSnapshot.id,  // documentId로부터 id 필드 추가
        });
      } else {
        throw Exception("DataSource: Document가 존재하지 않음");
      }
    } catch (e) {
      throw Exception("DataSource: UserGrade 정보 에러. $e");
    }
  }
}