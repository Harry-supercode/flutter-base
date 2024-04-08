import 'package:flutter/cupertino.dart';
import 'package:flutter_app/app_localizations.dart';

extension ContextX on BuildContext {
  // Application localizations
  String translate(String key) => AppLocalizations.of(this).translate(key);

  // Screen height
  double get height => MediaQuery.of(this).size.height;

  // Screen width
  double get width => MediaQuery.of(this).size.width;

  // Status bar height
  double get statusBar => MediaQuery.of(this).viewPadding.top;

  // Bottom padding height
  double get bottomPadding => MediaQuery.of(this).padding.bottom;
}
