import '../model/git_hub_user_model.dart';

abstract class GitHubDataSource {
  Future<GitHubUserModel> fetchUser(String username);
}