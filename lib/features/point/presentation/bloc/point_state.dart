import 'package:equatable/equatable.dart';

import '../vm/point_summary_view_model.dart';
import '../vm/point_view_model.dart';

abstract class PointState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PointInitialState extends PointState {}

class PointLoadingState extends PointState {}

class PointLoadedState extends PointState {
  final List<PointViewModel> pointViewModels;
  final PointSummaryViewModel pointSummaryViewModel;

  PointLoadedState({
    required this.pointViewModels,
    required this.pointSummaryViewModel,
  });

  @override
  List<Object?> get props => [pointViewModels, pointSummaryViewModel];
}

class PointErrorState extends PointState {
  final String message;

  PointErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
