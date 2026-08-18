import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/domain/entities/failure.dart';
import '../../../../../core/domain/use_cases/get_box_count_use_case.dart';
import '../../../../../core/domain/use_cases/user_type_use_case.dart';
import '../../../../../core/presentation/manager/user_settings/user_settings_cubit.dart';
import '../../../../features/home_feature/domain/entities/drawer_box_entity.dart';
import '../../../../features/home_feature/domain/facrtories/drawer_boxes_factory.dart';
import '../../../../features/home_feature/presentation/manager/builders/home_data_builder.dart';
import '../../../domain/entities/box_count_entity.dart';

part 'get_box_count_state.dart';

class GetBoxCountCubit extends Cubit<GetBoxCountState> {
  GetBoxCountCubit(this.useCase) : super(GetBoxCountInitial());

  final GetBoxCountUseCase useCase;

  DrawerBoxEntity? box;

  List<BoxCountEntity> boxes = [];

  Future<void> getStatistics({bool firstTime = false}) async {
    if (firstTime && state is GetBoxCountSuccess) {
      return;
    }
    emit(GetBoxCountLoading());
    final result = await useCase(
      GetBoxCountParams(year: HomeDataBuilder.instance.year.toString()),
    );
    result.fold((e) => emit(GetBoxCountFailed(e)), (value) {
      boxes = value;
      emit(GetBoxCountSuccess());
    });
  }

  initialBox(BuildContext context, {bool force = false}) {
    if (box == null || force) {
      final UserRole userType =
          context.read<UserSettingsCubit>().userType ?? UserRole.employee;
      switch (userType) {
        case UserRole.manager:
          box = DrawerBoxesFactory.instance.managerBoxes[0];
        case UserRole.excellency:
          box = DrawerBoxesFactory.instance.excellencyBoxes[0];
        default:
          box = null;
      }
      if (box != null) {
        HomeDataBuilder.instance.setBoxNumber(box!.id);
      }
      emit(GetBoxCountLoading());
      emit(GetBoxCountDump());
    }
  }

  setBox(DrawerBoxEntity? box) {
    this.box = box;
    emit(GetBoxCountLoading());
    emit(GetBoxCountSuccess());
  }

  BoxCountEntity getBoxByNumber(int number) {
    final int index = boxes.indexWhere((e) => e.boxTypeCode == number);
    if (index > -1) {
      return boxes[index];
    } else {
      return BoxCountEntity(count: 0, boxTypeCode: 0, boxName: "");
    }
  }

  clear() {
    box = null;
    boxes = [];
    emit(GetBoxCountInitial());
  }
}
