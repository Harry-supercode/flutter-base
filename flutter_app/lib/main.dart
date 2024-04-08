import 'package:flutter/material.dart';
import 'package:flutter_app/app_localizations.dart';
import 'package:flutter_app/app_theme.dart';
import 'package:flutter_app/blocs/main_bloc.dart';
import 'package:flutter_app/blocs/system/system_bloc.dart';
import 'package:flutter_app/blocs/system/system_event.dart';
import 'package:flutter_app/blocs/system/system_state.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/screens/home/main_page.dart';
import 'package:flutter_app/screens/splash/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  // Setup config loading
  configLoading();

  runApp(const CoreApp());
}

class CoreApp extends StatefulWidget {
  const CoreApp({super.key});

  // This widget is the root of your application.
  @override
  State<CoreApp> createState() => _CoreAppState();
}

class _CoreAppState extends State<CoreApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: MainBloc.allBlocs(), child: const NameApp());
  }
}

class NameApp extends StatefulWidget {
  const NameApp({super.key});

  @override
  State<NameApp> createState() => _NameAppState();
}

class _NameAppState extends State<NameApp> {
  // Theme mode
  ThemeMode _themeMode = ThemeMode.light;

  // Locale
  Locale _locale = Constant.defaultLocale;

  @override
  void initState() {
    context.read<SystemBloc>().add(const RequestChangeLanguage(
        languageCd: Language.en, isStartLoad: true));

    context.read<SystemBloc>().add(
        const RequestChangeThemeEvent(isDarkTheme: true, isStartLoad: true));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SystemBloc, SystemState>(
      buildWhen: (previousState, currentState) =>
          currentState is ChangeThemeSuccess ||
          currentState is ChangeLanguageSuccess,
      listener: _appConfigFlag,
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: const [
            Constant.defaultLocale,
            Constant.secondaryLocale
          ],
          localeResolutionCallback: (locale, _) {
            return locale;
          },
          themeMode: _themeMode,
          darkTheme: AppTheme.darkTheme,
          theme: AppTheme.lightTheme,
          locale: _locale,
          navigatorKey: navigatorKey,
          builder: EasyLoading.init(builder: (context, widget) {
            // widget = Portal(child: widget ?? const SizedBox());
            widget = GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: widget,
            );
            return widget;
          }),
          initialRoute: '/',
          routes: {
            '/': (context) => const SplashScreen(),
            MainPage.routeName: (context) => const MainPage(),
          },
        );
      },
    );
  }

  _appConfigFlag(BuildContext context, dynamic state) {
    if (state is ChangeThemeSuccess) {
      _themeMode = state.themeMode;
    } else if (state is ChangeLanguageSuccess) {
      _locale = state.locale;
    }
  }
}

void configLoading() {
  EasyLoading.instance
    ..indicatorColor = const Color(0xfff1039A)
    ..backgroundColor = Colors.transparent
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..userInteractions = false
    ..loadingStyle = EasyLoadingStyle.custom
    ..textColor = Colors.white
    ..maskType = EasyLoadingMaskType.custom
    ..boxShadow = <BoxShadow>[]
    ..maskColor = const Color(0xfff1039A).withOpacity(0.15)
    ..dismissOnTap = false;
}
