import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../../app/app.dart';
import '../../../domain/domain.dart';

part 'examples_state.dart';

class ExamplesCubit extends Cubit<ExamplesState> {
  final FetchExamplesUseCase _fetchExamplesUseCase;

  ExamplesCubit({required this._fetchExamplesUseCase}):
        super(ExampleInitial());

  Future<void> fetchExamples() async {
    emit(ExampleLoading());

    final result = await _fetchExamplesUseCase.call(const NoParams());

    result.fold(
      (failure) => emit(ExampleFailure(message: failure.message)),
      (data) => emit(ExampleSuccess(data: data)),
    );
  }
}
