import '../../domain/entities/github_user.dart';

class GitHubUserModel {
  final String login;
  final String avatarUrl;
  final String name;
  final String bio;
  final int publicRepos;
  final int followers;
  final int following;

  GitHubUserModel({
    required this.login,
    required this.avatarUrl,
    required this.name,
    required this.bio,
    required this.publicRepos,
    required this.followers,
    required this.following,
  });

  factory GitHubUserModel.fromJson(Map<String, dynamic> json) {
    return GitHubUserModel(
      login: json['login'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      name: json['name'] ?? '',
      bio: json['bio'] ?? '',
      publicRepos: json['public_repos'] ?? 0,
      followers: json['followers'] ?? 0,
      following: json['following'] ?? 0,
    );
  }

  GitHubUser toEntity() {
    return GitHubUser(
      login: login,
      avatarUrl: avatarUrl,
      name: name,
      bio: bio,
      publicRepos: publicRepos,
      followers: followers,
      following: following,
    );
  }
}