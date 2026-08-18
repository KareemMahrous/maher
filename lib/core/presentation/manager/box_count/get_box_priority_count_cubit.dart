import 'package:equatable/equatable.dart';
import 'package:flutter_alice/core/alice_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/domain/entities/failure.dart';
import '../../../../features/home_feature/domain/entities/enums/transaction_eum.dart';
import '../../../../features/home_feature/presentation/manager/builders/home_data_builder.dart';
import '../../../domain/entities/box_priotity_count_entity.dart';
import '../../../domain/use_cases/get_box_priority_count_use_case.dart';

part 'get_box_priority_count_state.dart';

class GetBoxPriorityCountCubit extends Cubit<GetBoxPriorityCountState> {
  GetBoxPriorityCountCubit(this.useCase) : super(GetBoxPriorityCountInitial());
  final GetBoxPriorityCountUseCase useCase;

  Future<void> getStatistics({bool firstTime = false,required int boxType}) async {
    if (firstTime && state is GetBoxPriorityCountSuccess) {
      return;
    }
    emit(GetBoxPriorityCountLoading());
    final result = await useCase(
      GetBoxPriorityCountParams(
          year: HomeDataBuilder.instance.year.toString(),
          boxType: boxType,
      ),
    );
    result.fold((e) => emit(GetBoxPriorityCountFailed(e)), (value) {
      emit(GetBoxPriorityCountSuccess(data: value));
    });
  }


  BoxPriorityCountEntity getCountByPriorityCode(int code){
    if(state is GetBoxPriorityCountSuccess){
      final successState = state as GetBoxPriorityCountSuccess;
      try{
        return successState.data?.firstWhereOrNull((element) => element.priorityType.value == code,) ??
            BoxPriorityCountEntity(
              priorityType:TransferPriorityLookups.regular,
              count: 0,
            );
      }catch(e){
        return BoxPriorityCountEntity(
          priorityType:TransferPriorityLookups.regular,
          count: 0,
        );
      }
    }else{
      return BoxPriorityCountEntity(
        priorityType:TransferPriorityLookups.regular,
        count: 0,
      );
    }
  }


  // setSelectedPriorityCode(int code,{required BuildContext context}){
  //   print('Setting Selected Priority Code: $code');
  //   if(state is GetBoxPriorityCountSuccess){
  //     var  successState = state as GetBoxPriorityCountSuccess;
  //     // if(successState.selectedPriorityCode != code){
  //     successState = successState.copyWith(selectedPriorityCode: code);
  //       emit(successState);
  //     // }else{
  //     //   emit(successState.copyWith(selectedPriorityCode: -1));
  //     // }
  //     final int? selectedCode = successState.selectedPriorityCode==-1?null:successState.selectedPriorityCode;
  //       print('Selected Priority Code: ${successState.selectedPriorityCode}');
  //     HomeDataBuilder.instance.setTransferPriorityID(selectedCode);
  //     HomeApiCaller.instance.callHome(context);
  //   }
  //
  // }
  //
  // int getSelectedPriorityCode(){
  //   if(state is GetBoxPriorityCountSuccess){
  //     print('qqqqqq${(state as GetBoxPriorityCountSuccess).selectedPriorityCode}');
  //     final successState = state as GetBoxPriorityCountSuccess;
  //     return successState.selectedPriorityCode??-1;
  //   }else{
  //     return -1;
  //   }
  // }


}
