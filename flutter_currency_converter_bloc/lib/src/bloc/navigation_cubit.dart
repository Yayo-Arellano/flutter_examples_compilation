import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_currency_converter/src/ui/bottom_bar.dart';

class NavigationCubit extends Cubit<BottomNavItem> {
  NavigationCubit() : super(BottomNavItem.converter);

  void onChanged(BottomNavItem item) => emit(item);
}
