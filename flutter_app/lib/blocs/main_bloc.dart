import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/common/common_bloc.dart';
import 'package:flutter_app/blocs/system/system_bloc.dart';
import 'package:flutter_app/blocs/auth/auth_bloc.dart';
import 'package:flutter_app/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainBloc {
  static List<BlocProvider> allBlocs() => [
        // System
        BlocProvider<SystemBloc>(
            lazy: true, create: (BuildContext context) => SystemBloc()),
        // Common data
        BlocProvider<CommonBloc>(
            create: (BuildContext context) => DI<CommonBloc>()),
        // Authentication
        BlocProvider<AuthBloc>(create: (BuildContext context) => AuthBloc()),
      ];
}
