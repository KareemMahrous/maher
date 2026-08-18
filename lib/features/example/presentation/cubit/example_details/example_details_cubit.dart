import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/domain.dart';

part 'example_details_state.dart';

class ExampleDetailsCubit extends Cubit<ExampleDetailsState> {
  ExampleDetailsCubit({
    required FetchExampleDetailsUseCase fetchExampleDetailsUseCase,
  }) : _fetchExampleDetailsUseCase = fetchExampleDetailsUseCase,
       super(ExampleDetailsInitial());

  final FetchExampleDetailsUseCase _fetchExampleDetailsUseCase;

  Future<void> fetchExampleDetails({required int id}) async {
    emit(ExampleDetailsLoading());

    final result = await _fetchExampleDetailsUseCase.call(id);

    result.fold(
      (failure) => emit(ExampleDetailsFailure(message: failure.message)),
      (data) => emit(ExampleDetailsSuccess(data: data)),
    );
  }
}
