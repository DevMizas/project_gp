import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBlockViewModel extends Cubit<bool> {
  ThemeBlockViewModel() : super(false);

  void toggleTheme() => emit(!state);
}
