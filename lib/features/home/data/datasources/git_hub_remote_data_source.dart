import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'dart:convert';
import '../model/git_hub_user_model.dart';
import 'git_hub_data_source.dart';

class GitHubRemoteDataSource implements GitHubDataSource {
  final http.Client client;
  final Logger logger = Logger();

  GitHubRemoteDataSource({required this.client});

  @override
  Future<GitHubUserModel> fetchUser(String username) async {
    print("데이터 소스 : fetchUser 진입");
    final response = await client.get(
      Uri.parse('https://api.github.com/users/ayz1070'),
    );
    if (response.statusCode == 200) {
      print("성공 상태 status : ${response.statusCode}");
      return GitHubUserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('깃허브 http 접근 실패');
    }
  }
}
