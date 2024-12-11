import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user_grade.dart';
import '../../domain/entities/grade.dart';
import '../../domain/usecases/fetch_login_user_grade_use_case.dart';
import 'my_grade_event.dart';
import 'my_grade_state.dart';

class MyGradeBloc extends Bloc<MyGradeEvent, MyGradeState> {
  final FetchLoginUserGradeUseCase fetchUserGradeUseCase;

  MyGradeBloc({required this.fetchUserGradeUseCase}) : super(MyGradeInitState()) {
    on<LoadMyGradeEvent>(_onLoadMyGradeEvent);
    on<MyGradeErrorEvent>(_onMyGradeErrorEvent);
  }

  // LoadMyGradeEvent 핸들러
  Future<void> _onLoadMyGradeEvent(LoadMyGradeEvent event, Emitter<MyGradeState> emit) async {
    emit(MyGradeLoadingState());

    try {
      // FetchLoginUserGradeUseCase를 통해 유저의 등급 정보를 가져옴
      //final UserGrade userGrade = await fetchUserGradeUseCase.execute(event.documentId);

      // 모든 등급 리스트를 가져옴
      List<Grade> grades = Grade.gradeList();

      // 데이터가 성공적으로 로드되었으면 Loaded 상태로 전환
      emit(MyGradeLoadedState(
        grades: grades,
        userGrade: UserGrade(name: "name", grade: Grade(name: "name", pointRate: 1, benefits: [], discountRate: 1, upgradeAmount: 1, upgradePurchaseCount: 1, createdAt: DateTime.now(), updatedAt: DateTime.now()), profileImageUrl: "profileImageUrl"),
      ));
    } catch (e) {
      print('Error: ${e.toString()}');
      emit(MyGradeErrorState(message: '등급 정보를 불러오는 중 오류가 발생했습니다. ${e.toString()}'));
    }
  }

  // MyGradeErrorEvent 핸들러
  void _onMyGradeErrorEvent(MyGradeErrorEvent event, Emitter<MyGradeState> emit) {
    emit(MyGradeErrorState(message: event.message));
  }
}