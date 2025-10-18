import 'package:flutter/material.dart';
import 'package:PetCare_App/Login/model/OtpScreen.dart';

class MobileEntryScreen2 extends StatefulWidget {
  const MobileEntryScreen2({Key? key}) : super(key: key);

  @override
  State<MobileEntryScreen2> createState() => _MobileEntryScreen2State();
}

class _MobileEntryScreen2State extends State<MobileEntryScreen2> {
  final TextEditingController _mobileCtrl = TextEditingController();

  @override
  void dispose() {
    _mobileCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // allows layout to resize when keyboard appears
      body: SafeArea(
        child: SingleChildScrollView( // prevents overflow
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "Asset/Pet-care-background.png", 
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.8,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 15),
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 126, 15, 141),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _mobileCtrl,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Mobile number',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 126, 15, 141)),
                    ),
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 126, 15, 141)),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 126, 15, 141),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    final mobile = _mobileCtrl.text.trim();
                    if (mobile.isEmpty || mobile.length != 10) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Enter a valid 10-digit mobile number'),
                        ),
                      );
                      return;
                    }

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => OtpScreen(mobile: mobile),
                      ),
                    );
                  },
                  child: const Text(
                    'Send OTP',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Use OTP: 123456 (universal for demo)',
                  style: TextStyle(
                    color: Color.fromARGB(255, 126, 15, 141),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
