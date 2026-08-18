import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/domain.dart';
import 'manage_example_state.dart';

class ManageExampleCubit extends Cubit<ManageExampleState> {
  ManageExampleCubit({
    required CreateExampleUseCase createExampleUseCase,
    required UpdateExampleUseCase updateExampleUseCase,
    required DeleteExampleUseCase deleteExampleUseCase,
  }) : _createExampleUseCase = createExampleUseCase,
       _updateExampleUseCase = updateExampleUseCase,
       _deleteExampleUseCase = deleteExampleUseCase,
       super(ManageExampleInitial());

  final CreateExampleUseCase _createExampleUseCase;
  final UpdateExampleUseCase _updateExampleUseCase;
  final DeleteExampleUseCase _deleteExampleUseCase;

  Future<void> createExample(ExampleParamsEntity data) async {
    emit(ManageExampleLoading());
    final result = await _createExampleUseCase.call(data);
    result.fold(
      (failure) => emit(ManageExampleFailure(message: failure.message)),
      (_) => emit(ManageExampleSuccess()),
    );
  }

  Future<void> updateExample(ExampleParamsEntity data) async {
    emit(ManageExampleLoading());
    final result = await _updateExampleUseCase.call(data);
    result.fold(
      (failure) => emit(ManageExampleFailure(message: failure.message)),
      (_) => emit(ManageExampleSuccess()),
    );
  }

  Future<void> deleteExample(int id) async {
    emit(ManageExampleLoading());
    final result = await _deleteExampleUseCase.call(id);
    result.fold(
      (failure) => emit(ManageExampleFailure(message: failure.message)),
      (_) => emit(ManageExampleSuccess()),
    );
  }
}
