class UserModel {
  final String id;  // 추가된 필드
  final String name;
  final String gradeName;
  final String profileImageUrl;

  UserModel({
    required this.id,  // 추가된 필드
    required this.name,
    required this.gradeName,
    required this.profileImageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],  // 추가된 필드 처리
      name: json['name'],
      gradeName: json['gradeName'],
      profileImageUrl: json['profileImageUrl'],
    );
  }

  // toJson 메서드 추가 (필요시 사용)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'gradeName': gradeName,
      'profileImageUrl': profileImageUrl,
    };
  }
}