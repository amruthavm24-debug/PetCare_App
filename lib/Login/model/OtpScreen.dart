import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/Login/model/viewmodels/AuthViewmodel.dart';
import '/Home/HomeScaffold.dart';

class OtpScreen extends StatefulWidget {
  final String mobile;
  const OtpScreen({Key? key, required this.mobile}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpCtrl = TextEditingController();

  @override
  void dispose() {
    _otpCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final viewInsets = MediaQuery.of(context).viewInsets.bottom; // height of keyboard

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          'Enter OTP',
          style: TextStyle(color: Color.fromARGB(255, 126, 15, 141)),
        ),
        backgroundColor: Colors.white,
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 126, 15, 141)),
        elevation: 0,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: viewInsets > 0 ? viewInsets + 20 : 20,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Image.asset(
                          "Asset/pet-care-png.jpg", 
                          height: screenHeight * 0.3,
                          width: screenWidth * 0.8,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'OTP sent to ${widget.mobile}',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 126, 15, 141),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _otpCtrl,
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        decoration: const InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(),
                          hintText: 'Enter 6-digit OTP',
                          hintStyle:
                              TextStyle(color: Color.fromARGB(230, 166, 164, 167)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 126, 15, 141),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 126, 15, 141),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 60, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          final otp = _otpCtrl.text.trim();
                          if (otp.isEmpty || otp.length != 6) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please enter a valid 6-digit OTP'),
                              ),
                            );
                            return;
                          }

                          try {
                            Provider.of<AuthViewModel>(context, listen: false)
                                .loginWithOtp(widget.mobile, otp);

                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (_) => const HomeScaffold()),
                              (route) => false,
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Invalid OTP')),
                            );
                          }
                        },
                        child: const Text(
                          'Verify & Continue',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
