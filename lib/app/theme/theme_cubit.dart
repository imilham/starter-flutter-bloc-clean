import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:starter/app/theme/theme_service.dart';
import 'package:starter/app/theme/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({bool isDark = false}) : super(ThemeState(isDark: isDark));

  void toggle() {
    final newIsDark = !state.isDark;
    Hive.box<bool>('themeMode').put('isDark', newIsDark);
    ThemeService.setSystemUIOverlayStyle(isDark: newIsDark);
    emit(state.copyWith(isDark: newIsDark));
  }

  ThemeData get lightTheme => ThemeService(isDark: false).lightThemeData();
  ThemeData get darkTheme => ThemeService(isDark: true).darkThemeData();
  ThemeMode get themeMode => state.isDark ? ThemeMode.dark : ThemeMode.light;

  // TODO: remove this
  Color get demoSnapColor => state.isDark ? Colors.orangeAccent : Colors.purpleAccent;
}
