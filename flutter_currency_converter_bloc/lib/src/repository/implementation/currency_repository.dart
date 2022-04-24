import 'package:flutter_currency_converter/src/provider/db_provider.dart';
import 'package:flutter_currency_converter/src/model/currency.dart';
import 'package:flutter_currency_converter/src/provider/rest_provider.dart';
import 'package:flutter_currency_converter/src/repository/currency_repository.dart';

class CurrencyRepository extends CurrencyRepositoryBase {
  final RestProvider _restProvider;
  final DbProvider _dbProvider;

  CurrencyRepository(this._restProvider, this._dbProvider);

  @override
  Stream<List<Currency>> getCurrencies() async* {
    // Return local data
    yield await _dbProvider.getCurrencies();

    // Fetch data from Api
    final result = await _restProvider.latest();
    final currencies = result.item1;
    final timestamp = result.item2;

    final currenciesList = currencies.entries.map((it) => Currency(it.key, it.value, timestamp)).toList();

    await Future.forEach<Currency>(currenciesList, (it) async => await _dbProvider.insert(it));

    yield await _dbProvider.getCurrencies();
  }

  @override
  Future<void> enableCurrency(String key, int position) => _dbProvider.enableCurrency(key, position);

  @override
  Future<void> disableCurrency(String key) => _dbProvider.disableCurrency(key);

  @override
  Future<int> getEnabledCurrencyCount() => _dbProvider.getEnabledCurrencyCount();

  @override
  Future<Currency> getCurrency(String key) => _dbProvider.getCurrency(key);

  @override
  Future<Currency> getSelectedCurrency() => _dbProvider.getSelectedCurrency();

  @override
  Future<void> setSelectedCurrency(String key) => _dbProvider.setSelectedCurrency(key);
}
