
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_features/features/point/presentation/bloc/point_event.dart';
import 'package:flutter_features/features/point/presentation/bloc/point_state.dart';

import '../../domain/usecases/point_use_case.dart';
import '../vm/point_summary_view_model.dart';
import '../vm/point_view_model.dart';

class PointBloc extends Bloc<PointEvent, PointState> {
  final FetchPointsByUserIdUseCase fetchPointsByUserIdUseCase;
  //final FetchEarnedPointsByUserIdUseCase fetchEarnedPointsByUserIdUseCase;
  //final FetchUsedPointByUserIdUseCase fetchUsedPointByUserIdUseCase;

  PointBloc({
    required this.fetchPointsByUserIdUseCase,
    //required this.fetchEarnedPointsByUserIdUseCase,
    //required this.fetchUsedPointByUserIdUseCase,
  }) : super(PointInitialState()) {
    on<FetchPointsEvent>(_onLoadTotalPoint);
    //on<FetchEarnedPointsEvent>(_onLoadEarnedPoint);
    //on<FetchUsedPointsEvent>(_onLoadUsedPoint);
  }

  Future<void> _onLoadTotalPoint(
      FetchPointsEvent event, Emitter<PointState> emit) async {
    emit(PointLoadingState());

    try {
      final points = await fetchPointsByUserIdUseCase.call(event.userId);
      final pointViewModels = points.map((point) {
        return PointViewModel.fromEntity(point);
      }).toList();

      final pointSummaryViewModel = PointSummaryViewModel(pointViewModels);

      emit(PointLoadedState(
        pointViewModels: pointViewModels,
        pointSummaryViewModel: pointSummaryViewModel,
      ));
    } catch (e) {
      emit(PointErrorState('PointErrorState : $e'));
    }
  }
}
