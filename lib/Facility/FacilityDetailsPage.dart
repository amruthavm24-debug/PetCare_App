import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:PetCare_App/Facility/viewmodels/FacilityViewModel.dart';
import 'package:PetCare_App/Booking/viewmodels/BookingViewModel.dart';
import 'package:PetCare_App/Booking/models/booking.dart';
import 'package:PetCare_App/Booking/MyBookingsPage.dart';


class FacilityDetailsPage extends StatefulWidget {
  final String facilityId;
  const FacilityDetailsPage({Key? key, required this.facilityId}) : super(key: key);

  @override
  State<FacilityDetailsPage> createState() => _FacilityDetailsPageState();
}

class _FacilityDetailsPageState extends State<FacilityDetailsPage> {
  String _petType = 'Dog';
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _selectedTime = const TimeOfDay(hour: 10, minute: 0);

  @override
  Widget build(BuildContext context) {
    final facilityVM = Provider.of<FacilityViewModel>(context, listen: false);
    final bookingVM = Provider.of<BookingViewModel>(context, listen: false);
    final f = facilityVM.getById(widget.facilityId);

    return Scaffold(
      appBar: AppBar(title: Text(f!.name,style: TextStyle(color:  Color.fromARGB(255, 126, 15, 141)),)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(height: 180, color: Colors.grey[300], child: const Center(child: Icon(Icons.image, size: 64))),
          const SizedBox(height: 12),
          Text(f.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color:  Color.fromARGB(255, 126, 15, 141))),
          const SizedBox(height: 6),
          Text('${f.category} • ★ ${f.rating.toStringAsFixed(1)} • From ₹${f.price}',style: TextStyle(color:  Color.fromARGB(255, 126, 15, 141)),),
          const SizedBox(height: 12),
          Text(f.description,style: TextStyle(color:  Color.fromARGB(255, 126, 15, 141)),),
          const Divider(),
          const SizedBox(height: 8),
          const Text('Select Pet Type',style: TextStyle(color:  Color.fromARGB(255, 126, 15, 141),fontSize: 16,fontWeight: FontWeight.bold),),
          Row(children: ['Dog', 'Cat', 'Other'].map((pt) => Padding(
            padding: const EdgeInsets.only(right:8.0),
            child: ChoiceChip(label: Text(pt,style: TextStyle(color:  Color.fromARGB(255, 126, 15, 141)),), selected: _petType==pt, onSelected: (_) { setState(()=>_petType=pt); }),
          )).toList()),

          const SizedBox(height: 12),
          const Text('Select Date',style: TextStyle(color:  Color.fromARGB(255, 126, 15, 141),fontSize: 16,fontWeight: FontWeight.bold),),
          Row(children: [
            Text(_selectedDate.toLocal().toString().split(' ')[0],style: TextStyle(color:  Color.fromARGB(255, 126, 15, 141)),),
            const SizedBox(width: 12),
            TextButton(onPressed: _pickDate, child: const Text('Change',style: TextStyle(color:  Color.fromARGB(255, 126, 15, 141),fontWeight: FontWeight.bold),))
          ]),

          const SizedBox(height: 12),
          const Text('Select Time Slot',style: TextStyle(color:  Color.fromARGB(255, 126, 15, 141),fontSize: 16,fontWeight: FontWeight.bold),),
          Row(children: [Text(_selectedTime.format(context),style: TextStyle(color:  Color.fromARGB(255, 126, 15, 141)),), const SizedBox(width: 12), 
          TextButton(onPressed: _pickTime, child: const Text('Change',style: TextStyle(color:  Color.fromARGB(255, 126, 15, 141),fontWeight: FontWeight.bold),))]),

          const SizedBox(height: 20),
          SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {
            // Confirm booking
            final id = DateTime.now().millisecondsSinceEpoch.toString();
            final dt = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day, _selectedTime.hour, _selectedTime.minute);
            final booking = Booking(id: id, facilityId: f.id, facilityName: f.name, petType: _petType, dateTime: dt);
            bookingVM.addBooking(booking);

            // Show dialog then navigate to My Bookings (pop to home and switch tab)
            showDialog(context: context, builder: (ctx) => AlertDialog(
              title: const Text('Success',style: TextStyle(color:  Color.fromARGB(255, 126, 15, 141)),),
              content: Text('Appointment booked successfully for ${f.name} on ${dt.toLocal().toString().split(".")[0]}.',
              style: TextStyle(color:  Color.fromARGB(255, 126, 15, 141)),),
              actions: [TextButton(onPressed: () {
                Navigator.of(ctx).pop();
                // pop back to root
                Navigator.of(context).popUntil((route) => route.isFirst);
                // attempt to switch to My Bookings tab by rebuilding HomeScaffold with index 1
                // Simpler: push MyBookings page full screen
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MyBookingsPage()));
              }, child: const Text('OK',style: TextStyle(color:  Color.fromARGB(255, 126, 15, 141)),))],
            ));
          },
          style: ElevatedButton.styleFrom(
          backgroundColor:  Color.fromARGB(255, 126, 15, 141),
          // foregroundColor: Colors.white, // Text & icon color
        ),
          child: const Text('Confirm Booking',style: TextStyle(color:  Colors.white),))),

        ]),
      ),
    );
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(context: context, initialDate: _selectedDate, firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 60)));
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _pickTime() async {
    final t = await showTimePicker(context: context, initialTime: _selectedTime);
    if (t != null) setState(() => _selectedTime = t);
  }
}