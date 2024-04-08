import 'package:get_it/get_it.dart';
import 'package:flutter_app/blocs/common/common_bloc.dart';

final DI = GetIt.instance;

Future<void> init() async {
  _initBloc();
}

void _initBloc() {
  DI.registerLazySingleton(() => CommonBloc());
}
