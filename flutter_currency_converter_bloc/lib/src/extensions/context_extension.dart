import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_currency_converter/src/bloc/settings_cubit.dart';

extension BuildContextExtension on BuildContext {
  String formatCurrency(num item, String currencySymbol) =>
      watch<SettingsCubit>().formatCurrency(item, currencySymbol);

  String format(num item) => watch<SettingsCubit>().format(item);

  double get height => MediaQuery.of(this).size.height;
}
