import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/Login/model/viewmodels/AuthViewmodel.dart';
import '/Login/model/LoginFlow.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Profile',style: TextStyle(color: Color.fromARGB(255, 126, 15, 141)),)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const CircleAvatar(radius: 36, child: Icon(Icons.person, size: 36)),
          const SizedBox(height: 12),
          Text('Mobile: ${auth.session?.mobile ?? '-'}',style: TextStyle(color: Color.fromARGB(255, 126, 15, 141))),
          const SizedBox(height: 12),
          ElevatedButton(
             style: ElevatedButton.styleFrom(
          backgroundColor:  Color.fromARGB(255, 126, 15, 141),
          // foregroundColor: Colors.white, // Text & icon color
        ),
            onPressed: () 
          { Provider.of<AuthViewModel>(context, listen: false).logout(); Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const LoginFlow()), (r) => false); },
           child: const Text('Logout',style: TextStyle(color: Colors.white)),
           )
        ]),
      ),
    );
  }
}