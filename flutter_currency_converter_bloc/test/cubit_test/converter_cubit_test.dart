import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_currency_converter/src/bloc/converter_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks/mock_currency_repository.dart';

void main() {
  late MockCurrencyRepository currencyRepository;

  setUp(() {
    currencyRepository = MockCurrencyRepository();
  });

  blocTest<ConverterCubit, ConverterState>(
    'Converter cubit initialize correctly',
    build: () => ConverterCubit(currencyRepository),
    verify: (cubit) {
      expect(cubit.state is ConverterReadyState, true);

      final state = cubit.state as ConverterReadyState;
      expect(state.currencies.length, 4);
      expect(state.currencies[0].key, 'CNY');
      expect(state.currencies[1].key, 'USD');
      expect(state.currencies[2].key, 'JPY');
      expect(state.currencies[3].key, 'MXN');

      expect(state.selected.key, 'EUR');
    },
  );

  blocTest<ConverterCubit, ConverterState>(
    'One EUR to other currency is converter correctly',
    build: () => ConverterCubit(currencyRepository),
    verify: (cubit) {
      final state = cubit.state as ConverterReadyState;

      expect(state.currencies[0].resultSelectedTo, 7.71);
      expect(state.currencies[1].resultSelectedTo, 1.17);
      expect(state.currencies[2].resultSelectedTo, 129.16);
      expect(state.currencies[3].resultSelectedTo, 24.33);
    },
  );

  blocTest<ConverterCubit, ConverterState>(
    'One of currency is converter to EUR correctly',
    build: () => ConverterCubit(currencyRepository),
    verify: (cubit) {
      final state = cubit.state as ConverterReadyState;

      expect(state.currencies[0].resultOneToSelected, 0.1297016861219196);
      expect(state.currencies[1].resultOneToSelected, 0.8547008547008548);
      expect(state.currencies[2].resultOneToSelected, 0.00774233508826262);
      expect(state.currencies[3].resultOneToSelected, 0.04110152075626799);
    },
  );

  blocTest<ConverterCubit, ConverterState>(
    'Set different amount will convert correctly',
    build: () => ConverterCubit(currencyRepository),
    act: (cubit) async {
      await Future.delayed(Duration(milliseconds: 1));
      cubit.setAmount(3.5);
    },
    verify: (cubit) {
      final state = cubit.state as ConverterReadyState;

      expect(state.currencies[0].resultSelectedTo, 26.985);
      expect(state.currencies[1].resultSelectedTo, 4.095);
      expect(state.currencies[2].resultSelectedTo, 452.06);
      expect(state.currencies[3].resultSelectedTo, 85.155);
    },
  );

  blocTest<ConverterCubit, ConverterState>(
    'Select another currency as default works correctly',
    build: () => ConverterCubit(currencyRepository),
    act: (cubit) async {
      await Future.delayed(Duration(milliseconds: 1));
      cubit.setSelected('USD');
    },
    verify: (cubit) {
      final state = cubit.state as ConverterReadyState;
      expect(state.selected.key, 'USD');
    },
  );

  blocTest<ConverterCubit, ConverterState>(
    'Select another currency as default will convert correctly',
    build: () => ConverterCubit(currencyRepository),
    act: (cubit) async {
      await Future.delayed(Duration(milliseconds: 1));
      cubit.setSelected('USD');
      cubit.setAmount(10);
    },
    expect: () => [
      isA<ConverterReadyState>(),
      isA<ConverterReadyState>(),
      isA<ConverterReadyState>(),
    ],
    verify: (cubit) {
      final state = cubit.state as ConverterReadyState;

      expect(state.currencies[0].resultSelectedTo, 65.8974358974359);
      expect(state.currencies[1].resultSelectedTo, 8.547008547008547);
      expect(state.currencies[2].resultSelectedTo, 1103.9316239316238);
      expect(state.currencies[3].resultSelectedTo, 207.94871794871793);
    },
  );
}
