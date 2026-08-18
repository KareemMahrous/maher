import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/app.dart';
import '../../../domain/domain.dart';

part 'example_details_state.dart';

class ExampleDetailsCubit extends Cubit<ExampleDetailsState> {
  final FetchExampleDetailsUseCase _fetchExampleDetailsUseCase;

  ExampleDetailsCubit({required this._fetchExampleDetailsUseCase}) :
        super(ExampleDetailsInitial());

  Future<void> fetchExampleDetails({required int id}) async {
    emit(ExampleDetailsLoading());

    final result = await _fetchExampleDetailsUseCase.call(id);

    result.fold(
      (failure) => emit(ExampleDetailsFailure(message: failure.message)),
      (data) => emit(ExampleDetailsSuccess(data: data)),
    );
  }
}
