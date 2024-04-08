import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:flutter_app/blocs/common/common_bloc.dart';
import 'package:flutter_app/blocs/common/common_event.dart';
import 'package:flutter_app/blocs/teams/teams_bloc.dart';
import 'package:flutter_app/blocs/teams/teams_event.dart';
import 'package:flutter_app/constants/global_constant.dart';
import 'package:flutter_app/extensions/context_ext.dart';
// import 'package:flutter_app/models/home/event_home_model.dart';
import 'package:flutter_app/models/menu_model/menu_model.dart';
import 'package:flutter_app/screens/auth/signup/components/base_app_bar.dart';
import 'package:flutter_app/screens/calendar_screen/calendar_screen.dart';
// import 'package:flutter_app/screens/feed_detail/feed_detail_screen.dart';
// import 'package:flutter_app/screens/home/components/floating_action_menu.dart';
import 'package:flutter_app/screens/home/home_page.dart';
import 'package:flutter_app/screens/mail/message_screen.dart';
import 'package:flutter_app/screens/menu_screen/menu_screen.dart';
// import 'package:flutter_app/screens/notification/notification_screen.dart';
// import 'package:flutter_app/screens/posts/comments_list_screen.dart';
import 'package:flutter_app/screens/search/search_screen.dart';
import 'package:flutter_app/screens/user/profile_screen.dart';
// import 'package:flutter_app/screens/user/team_settings/team_request_screen.dart';
// import 'package:flutter_app/screens/venues/venue_booked_screen.dart';
import 'package:flutter_app/shared_pref_services.dart';

class MainPage extends StatefulWidget {
  static const String routeName = '/mainPage';

  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  // List screens
  final List<Widget> _screens = const [
    MyHomePage(),
    CalendarScreen(),
    SearchScreen(),
    MessageScreen(),
    ProfileScreen()
  ];

  // List menu
  final List<MenuModel> _icons = [
    MenuModel(iconActive: 'ic_home_active.png', iconInactive: 'ic_home.svg'),
    MenuModel(
        iconActive: 'ic_calendar_active.png', iconInactive: 'ic_calendar.svg'),
    MenuModel(
        iconActive: 'ic_search_active.png', iconInactive: 'ic_search.svg'),
    MenuModel(iconActive: 'ic_mail_active.png', iconInactive: 'ic_mail.svg'),
    MenuModel(iconActive: 'ic_user_active.png', iconInactive: 'ic_account.svg'),
  ];

  // Screen selected
  int _indexSelected = 0;

  @override
  void initState() {
    super.initState();
    // Display permission access images
    _accessImagesPermission();
    // initPlatformState();
  }

  // Display permission access images
  _accessImagesPermission() async {
    final pref = await SharedPreferencesService.instance;
    if (!pref.isAccessLimited) {
      final state = await PhotoManager.requestPermissionExtend();
      debugPrint('Permission State: $state');
      pref.setIsAccessLimited(state == PermissionState.limited);
    }
  }

  @override
  Widget build(BuildContext context) {
    final pos = context.watch<CommonBloc>().state.tabPosition;
    if (pos != null && pos != -1) {
      _indexSelected = pos;
      context.read<CommonBloc>().add(RequestChangeTab(position: -1));
    }
    return _buildUI(context);
  }

  // Build UI
  Widget _buildUI(BuildContext context) {
    return Scaffold(
      key: _key,
      extendBody: true,
      appBar: _indexSelected != 2
          ? BaseAppBar(
              type: AppBarType.homePage,
              appBar: AppBar(),
              leading: Builder(builder: (context) {
                return Builder(builder: (context) {
                  return IconButton(
                      splashRadius: 18,
                      onPressed: () {
                        context.read<TeamsBloc>().add(RequestGetMyTeamEvent());
                        Scaffold.of(context).openDrawer();
                      },
                      icon: SvgPicture.asset(
                        'assets/icons/ic_drawer.svg',
                        width: 29,
                        height: 29,
                      ));
                });
              }),
              actions: [
                Transform.rotate(
                  angle: 0.7,
                  // child: IconButton(
                  //     splashRadius: 18,
                  //     onPressed: () =>
                  //         kOpenPage(context, const NotificationScreen()),
                  //     icon: SvgPicture.asset('assets/icons/ic_notification.svg',
                  //         width: 20, height: 20)),
                ),
                IconButton(
                  splashRadius: 18,
                  onPressed: () => kOpenPage(context, const SearchScreen()),
                  icon: SvgPicture.asset(
                    'assets/icons/ic_search.svg',
                    width: 20,
                    height: 20,
                  ),
                )
              ],
            )
          : null,
      // Add icon floatingActionButton
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: const FloatingActionMenu(),
      drawer: const MenuScreen(),
      bottomNavigationBar: _bottomNavBar(context),
      body: IndexedStack(
        index: _indexSelected,
        children: _screens,
      ),
    );
  }

  // Handle display bottom nav item
  Widget _buildNavItem(BuildContext context, int index) {
    if (index == 2) {
      return const Expanded(child: SizedBox());
    }
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _indexSelected = index;
          });
        },
        behavior: HitTestBehavior.opaque,
        child: index == _indexSelected
            ? Image.asset(
                'assets/icons/${_icons[index].iconActive}',
                width: 21,
                height: 21,
              )
            : SvgPicture.asset(
                'assets/icons/${_icons[index].iconInactive}',
                width: 21,
                height: 21,
              ),
      ),
    );
  }

  // Bottom nav bar
  Widget _bottomNavBar(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          color: Colors.white.withOpacity(0.25),
          padding: EdgeInsets.only(bottom: context.bottomPadding + 16, top: 20),
          child: Row(
            children: List.generate(
                _icons.length, (index) => _buildNavItem(context, index)),
          ),
        ),
      ),
    );
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> initPlatformState() async {
  //   final pref = await SharedPreferencesService.instance;

  //   if (!mounted) return;
  //   // NOTE: Replace with your own app ID from https://www.onesignal.com
  //   await OneSignal.shared.setAppId(Constant.oneSignalAppId);

  //   OneSignal.shared.consentGranted(true);

  //   debugPrint("Prompting for Permission");
  //   await OneSignal.shared
  //       .promptUserForPushNotificationPermission()
  //       .then((accepted) {
  //     debugPrint("Accepted permission: $accepted");
  //   });

  //   final status = await OneSignal.shared.getDeviceState();
  //   final String? osUserID = status?.userId;
  //   debugPrint("PlayerID: $osUserID");

  //   // We will update this once he logged in and goes to dashboard.
  //   ////updateUserProfile(osUserID);
  //   // Store it into shared prefs, So that later we can use it.
  //   // Preferences.setOnesignalUserId(osUserID);
  //   OneSignal.shared.getDeviceState().then((value) {
  //     print('UserId: ${value?.userId}');
  //   });
  //   OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  //   OneSignal.shared.setRequiresUserPrivacyConsent(true);

  //   // Update by env (UAT|DEV|PROD)_{userId}
  //   if (pref.userId != -1) {
  //     OneSignal.shared.setExternalUserId(
  //         '${FlutterConfig.get('ONE_SIGNAL_EXTERNAL')}_${pref.userId}');
  //   }

  //   OneSignal.shared
  //       .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
  //     final value = result.notification.additionalData!;
  //     if (value["type"].toString() == "link" &&
  //         value["action"] == "event_detail") {
  //       kOpenPage(context, FeedDetailScreen(idEvent: value["source_id"]));
  //       // print();
  //     }
  //     if (value["type"].toString() == "link" && value["action"] == "home") {
  //       kOpenPage(context, const NotificationScreen());
  //     }
  //     if (value["type"].toString() == "link" &&
  //         value["action"] == "team_request_list") {
  //       kOpenPage(
  //           context,
  //           TeamRequestScreen(
  //               teamId: value["source_id"], teamName: value["team_name"]));
  //     }
  //     if (value["type"].toString() == "link" &&
  //         value["action"] == "post_detail") {
  //       var eventModel = EventHomeModel();
  //       eventModel.id = value["source_id"];
  //       kOpenPage(
  //           context,
  //           CommentsListScreen(
  //             isFromNotification: true,
  //             model: eventModel,
  //             updateCommentCnt: (postId, commentCnt) {},
  //           ));
  //     }
  //     if (value["type"].toString() == "link" &&
  //         value["action"] == "booking_detail") {
  //       kOpenPage(
  //           context,
  //           VenueBookedDetailScreen(
  //             bookedVenueId: value["source_id"],
  //           ));
  //     }
  //     // debugPrint('NOTIFICATION OPENED HANDLER CALLED WITH: $result');
  //     debugPrint(
  //         "Opened notification: \n${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}");
  //   });

  //   OneSignal.shared.setNotificationWillShowInForegroundHandler(
  //       (OSNotificationReceivedEvent event) {
  //     debugPrint('FOREGROUND HANDLER CALLED WITH: $event');

  //     /// Display Notification, send null to not display
  //     event.complete(event.notification);

  //     debugPrint(
  //         "Notification received in foreground notification: \n${event.notification.jsonRepresentation().replaceAll("\\n", "\n")}");
  //   });

  //   OneSignal.shared
  //       .setSubscriptionObserver((OSSubscriptionStateChanges changes) async {
  //     String onesignalUserId = changes.to.userId ?? 'empty';
  //     print('Player ID: $onesignalUserId');
  //   });

  //   OneSignal.shared
  //       .setInAppMessageClickedHandler((OSInAppMessageAction action) {
  //     debugPrint(
  //         "In App Message Clicked: \n${action.jsonRepresentation().replaceAll("\\n", "\n")}");
  //   });

  //   OneSignal.shared
  //       .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
  //     debugPrint("SUBSCRIPTION STATE CHANGED: ${changes.jsonRepresentation()}");
  //   });

  //   OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
  //     debugPrint("PERMISSION STATE CHANGED: ${changes.jsonRepresentation()}");
  //   });

  //   OneSignal.shared.setEmailSubscriptionObserver(
  //       (OSEmailSubscriptionStateChanges changes) {
  //     debugPrint(
  //         "EMAIL SUBSCRIPTION STATE CHANGED ${changes.jsonRepresentation()}");
  //   });

  //   OneSignal.shared
  //       .setSMSSubscriptionObserver((OSSMSSubscriptionStateChanges changes) {
  //     debugPrint(
  //         "SMS SUBSCRIPTION STATE CHANGED ${changes.jsonRepresentation()}");
  //   });

  //   OneSignal.shared.setOnWillDisplayInAppMessageHandler((message) {
  //     debugPrint("ON WILL DISPLAY IN APP MESSAGE ${message.messageId}");
  //   });

  //   OneSignal.shared.setOnDidDisplayInAppMessageHandler((message) {
  //     debugPrint("ON DID DISPLAY IN APP MESSAGE ${message.messageId}");
  //   });

  //   OneSignal.shared.setOnWillDismissInAppMessageHandler((message) {
  //     debugPrint("ON WILL DISMISS IN APP MESSAGE ${message.messageId}");
  //   });

  //   OneSignal.shared.setOnDidDismissInAppMessageHandler((message) {
  //     debugPrint("ON DID DISMISS IN APP MESSAGE ${message.messageId}");
  //   });

  //   // iOS-only method to open launch URLs in Safari when set to false
  //   OneSignal.shared.setLaunchURLsInApp(false);

  //   bool requiresConsent = await OneSignal.shared.requiresUserPrivacyConsent();

  //   // Some examples of how to use In App Messaging public methods with OneSignal SDK
  //   // oneSignalInAppMessagingTriggerExamples();

  //   OneSignal.shared.disablePush(false);

  //   // Some examples of how to use Outcome Events public methods with OneSignal SDK
  //   // oneSignalOutcomeEventsExamples();

  //   // bool userProvidedPrivacyConsent = await OneSignal.shared.userProvidedPrivacyConsent();
  //   // debugPrint("USER PROVIDED PRIVACY CONSENT: $userProvidedPrivacyConsent");
  // }
}
