import '../entities/github_user.dart';
import '../repositories/github_repository.dart';

class FetchGitHubUserUseCase {
  final GitHubRepository repository;

  FetchGitHubUserUseCase({required this.repository} );

  Future<GitHubUser> call(String username) {
    return repository.fetchUser(username);
  }
}