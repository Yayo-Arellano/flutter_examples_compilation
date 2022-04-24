import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_currency_converter/src/bloc/navigation_cubit.dart';
import 'package:flutter_currency_converter/src/bloc/settings_cubit.dart';
import 'package:flutter_currency_converter/src/extensions/context_extension.dart';
import 'package:flutter_currency_converter/src/localization/locale_keys.g.dart';
import 'package:flutter_currency_converter/src/localization/supported_locales.dart';
import 'package:flutter_currency_converter/src/ui/bottom_bar.dart';

class SettingsScreen extends StatelessWidget {
  static Widget create(BuildContext context) => SettingsScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.settings.tr())),
      bottomNavigationBar: BottomNavBar(context.watch<NavigationCubit>().state),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              LanguageChooser(),
              getDivisor(),
              const SizedBox(height: 16),
              Center(
                  child: Text(
                context.formatCurrency(1000000, '\$'),
                style: const TextStyle(fontSize: 23),
              )),
              getDivisor(),
              NumberOfDecimals(),
              getDivisor(),
              GroupingSeparator(),
              getDivisor(),
              DecimalSeparator(),
              getDivisor(),
              CurrencySymbol()
            ],
          ),
        ),
      ),
    );
  }

  Widget getDivisor() {
    return Column(
      children: [
        const SizedBox(
          height: 8,
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: Colors.black,
        ),
      ],
    );
  }
}

class LanguageChooser extends StatelessWidget {
  List<DropdownMenuItem<Locale>> dropDownItems() {
    return supportedLocales.entries.map((it) {
      return DropdownMenuItem<Locale>(
        child: Text(it.value),
        value: it.key,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.translate),
        SizedBox(width: 8),
        Text(LocaleKeys.change_language.tr()),
        Expanded(child: Container()),
        DropdownButton(
          value: context.locale,
          items: dropDownItems(),
          onChanged: (value) async {
            context.setLocale(value as Locale);
          },
        )
      ],
    );
  }
}

class NumberOfDecimals extends StatelessWidget {
  List<DropdownMenuItem<int>> dropDownItems() {
    return [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
        .map((it) => DropdownMenuItem<int>(
              child: Text('   $it'), // 3 spaces so it look better
              value: it,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<SettingsCubit>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              LocaleKeys.decimals.tr(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(LocaleKeys.decimals_description.tr()),
          ],
        ),
        DropdownButton(
          value: cubit.numberOfDecimals,
          items: dropDownItems(),
          onChanged: (int? value) => cubit.setNumberOfDecimals(value ?? 3),
        ),
      ],
    );
  }
}

class DecimalSeparator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settingsCubit = context.watch<SettingsCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          LocaleKeys.decimal_separator.tr(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(LocaleKeys.decimal_separator_description.tr()),
        Row(
          children: [
            Radio(
              value: true,
              groupValue: settingsCubit.decimalSeparator == '.',
              onChanged: (bool? value) => settingsCubit.setDecimalSeparator(value!),
            ),
            Text(LocaleKeys.decimal_point.tr())
          ],
        ),
        Row(
          children: [
            Radio(
              value: false,
              groupValue: settingsCubit.decimalSeparator == '.',
              onChanged: (bool? value) => settingsCubit.setDecimalSeparator(value!),
            ),
            Text(LocaleKeys.decimal_comma.tr())
          ],
        ),
      ],
    );
  }
}

class CurrencySymbol extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settingsCubit = context.watch<SettingsCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          LocaleKeys.currency_symbol.tr(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(LocaleKeys.currency_symbol_description.tr()),
        Row(
          children: [
            Radio(
              value: true,
              groupValue: settingsCubit.isSymbolAtStart,
              onChanged: (bool? value) => settingsCubit.setSymbolPosition(value!),
            ),
            Text(LocaleKeys.currency_symbol_start.tr()),
            const SizedBox(width: 50),
            Radio(
              value: false,
              groupValue: settingsCubit.isSymbolAtStart,
              onChanged: (bool? value) => settingsCubit.setSymbolPosition(value!),
            ),
            Text(LocaleKeys.currency_symbol_end.tr())
          ],
        )
      ],
    );
  }
}

class GroupingSeparator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settingsCubit = context.watch<SettingsCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          LocaleKeys.grouping_separator.tr(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Checkbox(
              value: settingsCubit.isGroupSeparatorEnabled,
              onChanged: (bool? value) async => settingsCubit.setGroupingSeparator(value!),
            ),
            Expanded(child: Text(LocaleKeys.grouping_separator_description.tr()))
          ],
        ),
      ],
    );
  }
}
