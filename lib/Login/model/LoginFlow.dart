import 'package:flutter/material.dart';
import 'package:PetCare_App/Login/model/MobileEntryScreen2.dart';

class LoginFlow extends StatelessWidget {
  const LoginFlow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => const MobileEntryScreen2(),
        );
      },
    );
  }
}
