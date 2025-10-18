import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'SplashScreen.dart';
import 'Login/model/viewmodels/AuthViewmodel.dart';
import 'Login/model/LoginFlow.dart';
import 'Home/HomeScaffold.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    // Start splash timer then navigate accordingly
    Timer(const Duration(milliseconds: 2500), () {
      setState(() => _isReady = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthViewModel>();
    if (!_isReady) return const SplashScreen();
    return auth.session == null ? const LoginFlow() : const HomeScaffold();
  }
}