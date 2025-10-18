import 'package:flutter/material.dart';
import 'package:PetCare_App/Booking/viewmodels/BookingViewModel.dart';
import 'package:provider/provider.dart';

class MyBookingsPage extends StatelessWidget {
  const MyBookingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookings = context.watch<BookingViewModel>().bookings;
    return Scaffold(
      appBar: AppBar(title: const Text('My Bookings',style: TextStyle(color: Color.fromARGB(255, 126, 15, 141)),)),
      body: bookings.isEmpty
          ? Center(child: Column(mainAxisSize: MainAxisSize.min, 
          children: [const Icon(Icons.event_busy, size: 72, color: Color.fromARGB(255, 126, 15, 141)), const SizedBox(height: 16), 
          const Text('No bookings yet', style: TextStyle(fontSize: 18,color: Color.fromARGB(255, 126, 15, 141)))]))
          : ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (ctx, i) {
                final b = bookings[i];
                return ListTile(
                  leading: const Icon(Icons.event_available,color: Color.fromARGB(255, 126, 15, 141),),
                  title: Text(b.facilityName,style: TextStyle(color: Color.fromARGB(255, 126, 15, 141))),
                  subtitle: Text('${b.petType} • ${b.dateTime.toLocal().toString().split('.')[0]}',style: TextStyle(color: Color.fromARGB(255, 126, 15, 141))),
                  trailing: Text('ID: ${b.id.substring(b.id.length - 6)}',style: TextStyle(color: Color.fromARGB(255, 126, 15, 141))),
                );
              },
            ),
    );
  }
}