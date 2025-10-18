import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Login/model/viewmodels/AuthViewmodel.dart';
import 'Location/viewmodels/LocationViewModel.dart';
import 'Facility/viewmodels/FacilityViewModel.dart';
import 'Booking/viewmodels/BookingViewModel.dart';
import 'RootScreen.dart';

void main() {
  runApp(const PetCare());
}

class PetCare extends StatelessWidget {
  const PetCare({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => LocationViewModel()),
        ChangeNotifierProvider(create: (_) => FacilityViewModel()),
        ChangeNotifierProvider(create: (_) => BookingViewModel()),
      ],
      child: MaterialApp(
        title: 'PetCare',
        theme: ThemeData(primarySwatch: Colors.teal),
        home: const RootScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}


