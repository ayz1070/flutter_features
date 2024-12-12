import '../../domain/entities/github_user.dart';

class ProfileViewModel {
  final String login;
  final String avatarUrl;
  final String name;
  final String bio;
  final int publicRepos;
  final int followers;
  final int following;

  ProfileViewModel({
    required this.login,
    required this.avatarUrl,
    required this.name,
    required this.bio,
    required this.publicRepos,
    required this.followers,
    required this.following,
  });

  factory ProfileViewModel.fromGitHubUser(GitHubUser user) {
    return ProfileViewModel(
      login: user.login,
      avatarUrl: user.avatarUrl,
      name: user.name,
      bio: user.bio,
      publicRepos: user.publicRepos,
      followers: user.followers,
      following: user.following,
    );
  }
  static ProfileViewModel mapFromEntity(GitHubUser user) {
    return ProfileViewModel(
      login: user.login,
      avatarUrl: user.avatarUrl,
      name: user.name,
      bio: user.bio,
      publicRepos: user.publicRepos,
      followers: user.followers,
      following: user.following,
    );
  }
}