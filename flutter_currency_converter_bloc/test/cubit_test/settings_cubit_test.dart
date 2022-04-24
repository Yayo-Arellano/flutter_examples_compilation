import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_currency_converter/src/bloc/settings_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late SettingsCubit settingsCubit;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    settingsCubit = await SettingsCubit().init();
  });

  blocTest<SettingsCubit, SettingsState>(
    'Settings cubit defaults value correctly',
    build: () => settingsCubit,
    expect: () => [],
    verify: (cubit) {
      expect(cubit.numberOfDecimals, 3);
      expect(cubit.decimalSeparator, '.');
      expect(cubit.isSymbolAtStart, true);
      expect(cubit.isGroupSeparatorEnabled, true);
    },
  );

  blocTest<SettingsCubit, SettingsState>(
    'Set number of decimal works correctly',
    build: () => settingsCubit,
    act: (cubit) => cubit.setNumberOfDecimals(5),
    expect: () => [isA<SettingsState>()],
    verify: (cubit) {
      expect(cubit.format(10), '10.00000');
      expect(cubit.formatCurrency(10, '\$'), '\$ 10.00000');
    },
  );

  blocTest<SettingsCubit, SettingsState>(
    'Disable group separator works correctly',
    build: () => settingsCubit,
    act: (cubit) => cubit.setGroupingSeparator(false),
    expect: () => [isA<SettingsState>()],
    verify: (cubit) {
      expect(cubit.format(100000), '100 000.000');
      expect(cubit.formatCurrency(100000, '\$'), '\$ 100 000.000');
    },
  );

  blocTest<SettingsCubit, SettingsState>(
    'Symbol at end works correctly',
    build: () => settingsCubit,
    act: (cubit) => cubit.setSymbolPosition(false),
    expect: () => [isA<SettingsState>()],
    verify: (cubit) {
      expect(cubit.formatCurrency(100000, '\$'), '100,000.000 \$');
    },
  );

  blocTest<SettingsCubit, SettingsState>(
    'Decimal separator is comma',
    build: () => settingsCubit,
    act: (cubit) => cubit.setDecimalSeparator(false),
    expect: () => [isA<SettingsState>()],
    verify: (cubit) {
      expect(cubit.formatCurrency(100000, '\$'), '\$ 100.000,000');
    },
  );
}
