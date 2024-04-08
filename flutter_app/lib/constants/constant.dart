import 'package:flutter/cupertino.dart';
import 'package:flutter_config/flutter_config.dart';

class Constant {
  // Empty String
  static const String empty = '';

  // App Id OneSignal
  static String oneSignalAppId = FlutterConfig.get('ONE_SIGNAL_APP_ID');

  // US locale
  static const Locale defaultLocale = Locale('en', 'US');

  // VI locale
  static const Locale secondaryLocale = Locale('vi', 'VN');

  // Shimmer gradient
  static const LinearGradient shimmerGradient = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  // Setup account step I
  static const int stepI = 1;

  // Setup account step II
  static const int stepII = 2;

  // Setup account step III
  static const int stepIII = 3;

  // Setup account step IV
  static const int stepIV = 4;

  // Gradient main colors
  static const List<Color> mainGradient = [
    Color(0xffF1039A),
    Color(0xff080058)
  ];

  // Visible range (images)
  static const int defaultVisibleRange = 2;

  // Default radius
  static const double defaultRadius = 8.0;

  // Obscure character default
  static const String defaultObscureChar = '●';

  // Default max line input
  static const int defaultMaxLines = 1;

  // Default upload files size
  static const queuePageSize = 3;

  // Event type: Pickup
  static const pickupType = 'pickup';

  // Event type: League
  static const leagueType = 'league';

  // Event type: Sport
  static const sportType = 'sport';

  // Event type: Session
  static const sessionType = 'session';

  // Date time format yyyy-MM-dd hh:mm:ss
  static const dateTimeFormat = 'yyyy-MM-dd hh:mm:ss';

  static const perPage = 20;

  static const iconSuffixInputSize = 21.0;
}

class DeepLinkPath {
  static const String changeEmail = '/api/user/change-email';
  static const String inviteTeam = '/api/invite';
}
