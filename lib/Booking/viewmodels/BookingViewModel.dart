import 'package:flutter/material.dart';
import 'package:PetCare_App/Booking/models/booking.dart';

class BookingViewModel extends ChangeNotifier {
  final List<Booking> _bookings = [];
  List<Booking> get bookings => List.unmodifiable(_bookings);

  void addBooking(Booking b) {
    _bookings.add(b);
    notifyListeners();
  }

  void clear() {
    _bookings.clear();
    notifyListeners();
  }
}