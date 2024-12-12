import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class FetchGitHubUser extends HomeEvent {
  final String username;

  const FetchGitHubUser(this.username);

  @override
  List<Object> get props => [username];
}