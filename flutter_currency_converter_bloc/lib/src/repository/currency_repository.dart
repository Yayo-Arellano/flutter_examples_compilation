import 'package:flutter_currency_converter/src/model/currency.dart';

abstract class CurrencyRepositoryBase {
  Stream<List<Currency>> getCurrencies();

  Future<Currency> getCurrency(String key);

  Future<void> enableCurrency(String key, int position);

  Future<void> disableCurrency(String key);

  Future<int> getEnabledCurrencyCount();

  Future<void> setSelectedCurrency(String key);

  Future<Currency> getSelectedCurrency();
}
