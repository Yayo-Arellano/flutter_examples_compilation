import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsCubit extends Cubit<SettingsState> {
  late NumberFormat formatter;
  late SharedPreferences prefs;

  late int numberOfDecimals;
  late bool isGroupSeparatorEnabled;
  late String decimalSeparator;
  late bool isSymbolAtStart;

  SettingsCubit() : super(SettingsState());

  Future<SettingsCubit> init() async {
    prefs = await SharedPreferences.getInstance();
    numberOfDecimals = prefs.getInt('numberOfDecimals') ?? 3;
    decimalSeparator = prefs.getString('decimalSeparator') ?? '.';
    isSymbolAtStart = prefs.getBool('isSymbolAtStart') ?? true;
    isGroupSeparatorEnabled = prefs.getBool('isGroupSeparatorEnabled') ?? true;
    _formatUpdated();
    return this;
  }

  void setNumberOfDecimals(int numberOfDecimals) async {
    this.numberOfDecimals = numberOfDecimals;
    await prefs.setInt('numberOfDecimals', numberOfDecimals);
    _formatUpdated();
  }

  void setGroupingSeparator(bool enabled) async {
    this.isGroupSeparatorEnabled = enabled;
    await prefs.setBool('isGroupSeparatorEnabled', isGroupSeparatorEnabled);
    _formatUpdated();
  }

  void setSymbolPosition(bool atStart) async {
    this.isSymbolAtStart = atStart;
    await prefs.setBool('isSymbolAtStart', isSymbolAtStart);
    _formatUpdated();
  }

  void setDecimalSeparator(bool isPoint) async {
    decimalSeparator = isPoint ? '.' : ',';
    await prefs.setString('decimalSeparator', decimalSeparator);
    _formatUpdated();
  }

  void _formatUpdated() {
    numberFormatSymbols['custom'] = _getSymbols();

    var auxDecimals = '';
    for (var i = 0; i < numberOfDecimals; i++) {
      auxDecimals += '0';
    }
    var pattern = '###,###,##0.$auxDecimals';
    if (isSymbolAtStart) {
      pattern = '{symbol} $pattern';
    } else {
      pattern = '$pattern {symbol}';
    }
    formatter = NumberFormat(pattern, 'custom');
    emit(SettingsState());
  }

  String formatCurrency(num item, String currencySymbol) {
    var auxText = formatter.format(item);
    return auxText.replaceAll('{symbol}', currencySymbol);
  }

  String format(num item) => formatter.format(item).replaceAll('{symbol}', '').trim();

  // https://stackoverflow.com/a/50142875/3479489
  NumberSymbols _getSymbols() {
    var groupSeparator = decimalSeparator == '.' ? ',' : '.';
    if (!isGroupSeparatorEnabled) groupSeparator = ' ';
    return NumberSymbols(
      NAME: 'custom',
      DECIMAL_SEP: decimalSeparator,
      GROUP_SEP: groupSeparator,
      ZERO_DIGIT: '0',
      MINUS_SIGN: '-',
      PERCENT: '%',
      PLUS_SIGN: '+',
      EXP_SYMBOL: 'e',
      PERMILL: '\u2030',
      INFINITY: '\u221E',
      NAN: 'NaN',
      DECIMAL_PATTERN: '',
      SCIENTIFIC_PATTERN: '',
      PERCENT_PATTERN: '',
      CURRENCY_PATTERN: '',
      DEF_CURRENCY_CODE: '',
    );
  }
}

class SettingsState {}
