import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic_notes/utils/constants.dart';

class PasswordNotifier extends StateNotifier<bool> {
  PasswordNotifier() : super(prefs!.getBool('savePass') == null ? false : prefs!.getBool('savePass')!);

  void savePassword(bool value, String email, String password) {
    if (value) {
      state = true;
      prefs!.setBool('savePass', value);
      prefs!.setString('email', email);
      prefs!.setString('password', password);
    } else {
      state = false;
      prefs!.setBool('savePass', value);
      prefs!.setString('email', "");
      prefs!.setString('password', "");
    }
  }
}

final passwordPr = StateNotifierProvider<PasswordNotifier, bool>((ref) => PasswordNotifier());
