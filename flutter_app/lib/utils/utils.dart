import 'package:flutter_easyloading/flutter_easyloading.dart';

// Call anywhere show loading
void showLoading() {
  if (!EasyLoading.isShow) {
    EasyLoading.show();
  }
}

// Call anywhere hide loading
void hideLoading() {
  if (EasyLoading.isShow) {
    EasyLoading.dismiss();
  }
}
