import 'package:flutter/material.dart';
import 'package:PetCare_App/Login/model/Usersession.dart';


class AuthViewModel extends ChangeNotifier {
  UserSession? _session;
  UserSession? get session => _session;

  void loginWithOtp(String mobile, String otp) {
    if (otp == '123456') {
      _session = UserSession(mobile: mobile);
      notifyListeners();
    } else {
      throw Exception('Invalid OTP');
    }
  }

  void logout() {
    _session = null;
    notifyListeners();
  }
}