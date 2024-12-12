import 'package:bloc/bloc.dart';
import 'package:flutter_features/features/home/presentation/vm/profile_view_model.dart';
import '../../domain/usecases/fetch_git_hub_user_use_case.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FetchGitHubUserUseCase fetchGitHubUserUseCase;

  HomeBloc({
    required this.fetchGitHubUserUseCase,
  }) : super(HomeInitial()) {
    on<FetchGitHubUser>(_onFetchHomeUser);
  }

  Future<void> _onFetchHomeUser(
      FetchGitHubUser event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final user = await fetchGitHubUserUseCase.call("ayz1070");
      final viewModel = ProfileViewModel.mapFromEntity(user);
      emit(HomeLoaded(viewModel));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}