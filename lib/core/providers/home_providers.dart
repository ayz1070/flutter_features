import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_features/features/home/data/datasources/git_hub_remote_data_source.dart';
import 'package:flutter_features/features/home/data/repositories/git_hub_repository_impl.dart';
import 'package:flutter_features/features/home/domain/repositories/github_repository.dart';
import 'package:flutter_features/features/home/domain/usecases/fetch_git_hub_user_use_case.dart';
import 'package:http/http.dart';

import '../../features/home/data/datasources/git_hub_data_source.dart';
import '../../features/home/presentation/bloc/home_bloc.dart';
import '../../features/home/presentation/bloc/home_event.dart';

class HomeProviders {
  static List<RepositoryProvider> repositoryProviders(Client client) {
    return [
      RepositoryProvider<GitHubDataSource>(
        create: (context) => GitHubRemoteDataSource(client: client),
      ),
      RepositoryProvider<GitHubRepository>(
        create: (context) => GitHubRepositoryImpl(remoteDataSource: context.read<GitHubDataSource>()),
      ),

      // Use Cases
      RepositoryProvider<FetchGitHubUserUseCase>(
        create: (context) => FetchGitHubUserUseCase(
          repository : context.read<GitHubRepository>(),
        ),
      ),
    ];
  }

  static List<BlocProvider> blocProviders = [
    BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(
        fetchGitHubUserUseCase: context.read<FetchGitHubUserUseCase>()
      )..add(FetchGitHubUser('ayz1070')),
    ),
  ];
}
