import 'package:cinema_booking/common/helpers/log_helpers.dart';
import 'package:cinema_booking/domain/entities/response/home.dart';
import 'package:cinema_booking/domain/usecase/home/get_home_data.dart';
import 'package:cinema_booking/service_locator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoading()) {
    on<LoadHome>(_onLoadHome);
    on<RefreshHome>(_onRefreshHome);
  }

  Future<void> _onLoadHome(
    LoadHome event,
    Emitter<HomeState> emit,
  ) async {
    try {
      LogHelper.logDebug(tag: "HomeBloc", message: "_onLoadHome start ");
      final response = await sl<GetHomeDataUseCase>().call();

      response.fold(
        (l) {
          emit(HomeNotLoaded("fail"));
        },
        (data) {
          emit(
            HomeLoaded(data),
          );
        },
      );
    } catch (e) {
      emit(HomeNotLoaded(e.toString()));
    }
  }

  Future<void> _onRefreshHome(
    RefreshHome event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    add(LoadHome());
  }
}
