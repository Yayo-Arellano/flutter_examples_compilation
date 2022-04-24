import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_currency_converter/src/extensions/list_extension.dart';
import 'package:flutter_currency_converter/src/model/currency.dart';
import 'package:flutter_currency_converter/src/repository/currency_repository.dart';

class ConverterCubit extends Cubit<ConverterState> {
  final CurrencyRepositoryBase _repository;

  StreamSubscription? subscription;

  late Currency _selected;
  List<Currency> _enabledCurrencies = [];

  num amountToConvert = 1.0;

  ConverterCubit(this._repository) : super(ConverterLoadingState()) {
    refresh();
  }

  Future<void> refresh() async {
    subscription?.cancel();
    subscription = _repository.getCurrencies().listen((it) async {
      if (it.isNotEmpty) {
        _selected = await _repository.getSelectedCurrency();

        // Keep only enabled
        _enabledCurrencies = it.where((item) => item.isEnabled).toList();

        // Remove selected one
        _enabledCurrencies.removeWhere((item) => item.key == _selected.key);

        // Sort by position
        _enabledCurrencies.sort((a, b) => a.position - b.position);

        _updateState();
      }
    });
  }

  bool lockSelecting = false;

  Future<void> setSelected(String key) async {
    if (lockSelecting) return;
    lockSelecting = true;

    final newIndex = _enabledCurrencies.indexWhere((it) => it.key == key);

    // Remove the 'new' selected from the list
    _enabledCurrencies.removeAt(newIndex);

    // I will put the 'old' selected in the position of the current
    await _repository.enableCurrency(_selected.key, newIndex);
    _enabledCurrencies.insert(newIndex, _selected);

    await _repository.setSelectedCurrency(key);
    _selected = await _repository.getSelectedCurrency();

    _updateState();
    lockSelecting = false;
  }

  void setAmount(num amount) {
    this.amountToConvert = amount;
    _updateState();
  }

  void reOrder(int oldIndex, int newIndex) {
    //Why newIndex =-1 ? https://github.com/flutter/flutter/issues/24786#issuecomment-644212767
    if (oldIndex < newIndex) newIndex -= 1;
    _enabledCurrencies.reOrder(oldIndex, newIndex);

    for (var i = 0; i < _enabledCurrencies.length; i++) {
      _repository.enableCurrency(_enabledCurrencies[i].key, i);
    }
    _updateState();
  }

  void _updateState() {
    final wrapper = _enabledCurrencies.map((it) {
      final resultSelectedTo = (amountToConvert / _selected.value) * it.value;
      final resultOneToSelected = (1 / it.value) * _selected.value;

      return WrapperCurrency(
        it.key,
        _selected.key,
        resultSelectedTo,
        resultOneToSelected,
      );
    }).toList();
    final date = DateTime.fromMillisecondsSinceEpoch(_selected.timestamp * 1000);
    emit(ConverterReadyState(wrapper, amountToConvert, _selected, date));
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}

class ConverterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ConverterLoadingState extends ConverterState {}

class ConverterReadyState extends ConverterState {
  final List<WrapperCurrency> currencies;
  final num amountConverting;
  final Currency selected;
  final DateTime timestamp;

  ConverterReadyState(
    this.currencies,
    this.amountConverting,
    this.selected,
    this.timestamp,
  );

  @override
  List<Object> get props => [currencies];
}

class WrapperCurrency extends Equatable {
  final String key;
  final String selectedKey;
  final num resultSelectedTo;
  final num resultOneToSelected;

  WrapperCurrency(
    this.key,
    this.selectedKey,
    this.resultSelectedTo,
    this.resultOneToSelected,
  );

  @override
  List<Object> get props => [
        key,
        selectedKey,
        resultSelectedTo,
        resultOneToSelected,
      ];
}
