import 'package:flutter_bloc/flutter_bloc.dart';

abstract class PaginationCubit<T, Params> extends Cubit<T> {
  PaginationCubit(super.initialState);

  void get({Params? params});

  void paginate();

}
