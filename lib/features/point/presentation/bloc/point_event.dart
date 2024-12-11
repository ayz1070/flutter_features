import 'package:equatable/equatable.dart';

abstract class PointEvent extends Equatable{
  @override
  List<Object?> get props => [];
}


class FetchPointsEvent extends PointEvent {
  final String userId;

  FetchPointsEvent({required this.userId});
}

class FetchEarnedPointsEvent extends PointEvent {
  final String userId;

  FetchEarnedPointsEvent({required this.userId});
}

class FetchUsedPointsEvent extends PointEvent {
  final String userId;

  FetchUsedPointsEvent({required this.userId});
}