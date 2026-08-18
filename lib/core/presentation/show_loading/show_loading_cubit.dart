import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'show_loading_state.dart';

class ShowLoadingCubit extends Cubit<ShowLoadingState> {
  ShowLoadingCubit() : super(ShowLoadingInitial());

  showLoading(bool call) {
    if (!call) {
      return;
    }
    Future.delayed(const Duration(milliseconds: 600), () {
      emit(ShowLoadingLoadingState());
    });
  }

  hideLoading(bool call) {
    if (!call) {
      return;
    }
    emit(ShowLoadingLoadedState());
  }
}
