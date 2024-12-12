import '../../domain/entities/github_user.dart';
import '../../domain/repositories/github_repository.dart';
import '../datasources/git_hub_data_source.dart';

class GitHubRepositoryImpl implements GitHubRepository {
  final GitHubDataSource remoteDataSource;

  GitHubRepositoryImpl({required this.remoteDataSource});

  @override
  Future<GitHubUser> fetchUser(String username) async {
    final userModel = await remoteDataSource.fetchUser(username);
    return userModel.toEntity();
  }
}

