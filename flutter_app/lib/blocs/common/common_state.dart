import 'package:flutter_app/models/common/currency_model.dart';

class CommonState {
  List<CurrencyModel>? listCurrencies;
  int? tabPosition;
  Map<String, dynamic>? dataMessageSelected;
  double? exchangeRate;

  CommonState({
    this.listCurrencies,
    this.tabPosition,
    this.dataMessageSelected,
    this.exchangeRate,
  });

  CommonState copyWith({
    int? tabPosition,
    Map<String, dynamic>? dataMessageSelected,
    List<CurrencyModel>? listCurrencies,
    double? exchangeRate,
  }) =>
      CommonState(
        listCurrencies: listCurrencies ?? this.listCurrencies,
        tabPosition: tabPosition ?? this.tabPosition,
        dataMessageSelected: dataMessageSelected ?? this.dataMessageSelected,
        exchangeRate: exchangeRate ?? this.exchangeRate,
      );
}
