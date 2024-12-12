// lib/presentation/bloc/home_state.dart

import 'package:equatable/equatable.dart';
import '../vm/profile_view_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final ProfileViewModel profileViewModel;

  const HomeLoaded(this.profileViewModel);

  @override
  List<Object?> get props => [profileViewModel];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}