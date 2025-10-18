import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
  late final Animation<double> _anim = CurvedAnimation(parent: _ctrl, curve: Curves.bounceIn);

  @override
  void initState() {
    super.initState();
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ScaleTransition(
          scale: _anim,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                child: Image.asset("Asset/pet-care-logo.png"),
              ),
              const SizedBox(height: 12),
              const Text('PetCare', style: TextStyle(color: Color.fromARGB(255, 126, 15, 141), fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              const Text('Care. Love. Trust.', style: TextStyle(color:Color.fromARGB(255, 126, 15, 141), fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}