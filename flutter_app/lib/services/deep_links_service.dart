import 'package:flutter_app/components/dialogs/alert_dialog.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/constants/global_constant.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/screens/auth/auth_page.dart';
import 'package:flutter_app/services/auth/auth_repository.dart';
import 'package:flutter_app/services/dio_client.dart';
import 'package:flutter_app/shared_pref_services.dart';
import 'package:flutter_app/utils/log_utils.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:uni_links/uni_links.dart';

class DeepLinksService {
  DeepLinksService._privateConstructor();

  static final DeepLinksService _instance =
      DeepLinksService._privateConstructor();

  static DeepLinksService get instance => _instance;

  void uriLogic(Uri uri) async {
    switch (uri.path) {
      case DeepLinkPath.changeEmail:
        final queryParams = uri.queryParameters;
        final token = queryParams['token'];

        showLoading();
        try {
          if (token != null) {
            final result =
                await AuthRepository.instance.updateEmailByToken(token: token);

            hideLoading();
            if (result) {
              AlertPopup(
                  title: 'Change email success!',
                  msg: 'You will be logged out and required to login again.',
                  declinedText: 'OK',
                  declinedAction: () async {
                    DioClient.logOut();
                    final pref = await SharedPreferencesService.instance;
                    pref.logOut();
                    kPop(navigatorKey.currentState!.overlay!.context);
                    kOpenPageAndRemove(
                        navigatorKey.currentState!.context, const AuthPage());
                  }).showAlertPopup(navigatorKey.currentState!.overlay!.context);
            } else {
              AlertPopup(
                      title: 'Error',
                      msg: 'Change email failed. Please try again later')
                  .showAlertPopup(navigatorKey.currentState!.overlay!.context);
            }
          }
        } catch (e) {
          hideLoading();
          AlertPopup(
                  title: 'Error',
                  msg: 'Change email failed. Please try again later')
              .showAlertPopup(navigatorKey.currentState!.overlay!.context);
        }
        break;
      default:
    }
  }

  void handleDeepLink() async {
    try {
      final uri = await getInitialUri();
      if (uri != null) {
        uriLogic(uri);
      }
    } catch (e) {
      LogUtils().error('Deep link initial error: $e');
    }

    // Attach a listener to the stream
    linkStream.listen((String? link) {
      // Parse the link and warn the user, if it is not correct
      if (link != null) {
        final uri = Uri.parse(link);
        uriLogic(uri);
      }
    }, onError: (err) {
      // Handle exception by warning the user their action did not succeed
      LogUtils().error('Deep link stream error: $err');
    });
  }
}
