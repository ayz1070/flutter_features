class GitHubUser {
  final String login;
  final String avatarUrl;
  final String name;
  final String bio;
  final int publicRepos;
  final int followers;
  final int following;

  GitHubUser({
    required this.login,
    required this.avatarUrl,
    required this.name,
    required this.bio,
    required this.publicRepos,
    required this.followers,
    required this.following,
  });
}