import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/blocs/common/common_event.dart';
import 'package:flutter_app/blocs/common/common_state.dart';
import 'package:flutter_app/services/common/common_repository.dart';
import 'package:flutter_app/shared_pref_services.dart';
import 'package:flutter_app/utils/log_utils.dart';

class CommonBloc extends Bloc<CommonEvent, CommonState> {
  CommonBloc() : super(CommonState()) {
    on<GetListDataCommonEvent>(_onGetListDataCommonEvent);

    // Request change tab
    on<RequestChangeTab>(_onChangedTab);
  }

  void _onGetListDataCommonEvent(
      GetListDataCommonEvent event, Emitter emit) async {
    try {
      if (state.listCurrencies == null) {
        final listCurrency = await CommonRepository.instance.getListCurrency();
        emit(state.copyWith(listCurrencies: listCurrency));
      }
    } catch (error) {
      LogUtils().i('${error.toString()} - URL: Get list currency');
    }

    await exchangeCurrency();

    emit(state);
  }

  Future<void> exchangeCurrency() async {
    try {
      final prefs = await SharedPreferencesService.instance;
      final user = prefs.userProfile;
      final authRes = prefs.authResponse;

      if (user != null &&
          user.currency?.code != null &&
          user.currency?.code != 'PHP') {
        String query = 'PHP${user.currency?.code ?? 'PHP'}';
        final exchange =
            await CommonRepository.instance.getChangeCurrency(query: query);
        state.exchangeRate = exchange;
      } else if (authRes != null &&
          authRes.data?.currencyModel?.code != null &&
          authRes.data?.currencyModel?.code != 'PHP') {
        String query = 'PHP${authRes.data?.currencyModel?.code ?? 'PHP'}';
        final exchange =
            await CommonRepository.instance.getChangeCurrency(query: query);
        state.exchangeRate = exchange;
      }
    } catch (error) {
      LogUtils().i('${error.toString()} - URL: Get exchangeRate');
    }
  }

  void _onChangedTab(RequestChangeTab event, Emitter emit) {
    emit(state.copyWith(
        tabPosition: event.position, dataMessageSelected: event.map));
  }
}
