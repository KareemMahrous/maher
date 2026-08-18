import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../../domain/domain.dart';

part 'examples_state.dart';

class ExamplesCubit extends Cubit<ExamplesState> {
  ExamplesCubit({required FetchExamplesUseCase fetchExamplesUseCase})
    : _fetchExamplesUseCase = fetchExamplesUseCase,
      super(ExampleInitial());

  final FetchExamplesUseCase _fetchExamplesUseCase;

  Future<void> fetchExamples() async {
    emit(ExampleLoading());

    final result = await _fetchExamplesUseCase.call(const NoParams());

    result.fold(
      (failure) => emit(ExampleFailure(message: failure.message)),
      (data) => emit(ExampleSuccess(data: data)),
    );
  }
}
