import 'package:equatable/equatable.dart';

class ThemeState extends Equatable {
  const ThemeState({this.isDark = false});

  final bool isDark;

  ThemeState copyWith({bool? isDark}) => ThemeState(isDark: isDark ?? this.isDark);

  @override
  List<Object?> get props => [isDark];
}
