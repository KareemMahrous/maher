import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core.dart';

part 'package:arch/core/presentation/manager/theme/theme_states.dart';

class ThemeCubit extends Cubit<ThemeStates> {
  ThemeCubit() : super(ThemeInitial());
  bool isDartMode = false;

  getCurrentMode() {
    isDartMode = SharedPref.getBoolean(PrefKeys.isDarkMode) ?? false;
  }

  changeToDarkMode() {
    isDartMode = true;
    SharedPref.setBoolean(key: PrefKeys.isDarkMode, value: true);
    emit(ChangeTheme());
  }

  changeToLightMode() {
    isDartMode = false;
    SharedPref.setBoolean(key: PrefKeys.isDarkMode, value: true);
    emit(ChangeTheme());
  }
}
