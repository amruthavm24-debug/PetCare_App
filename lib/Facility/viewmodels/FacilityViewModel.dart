import 'package:flutter/material.dart';
import 'package:PetCare_App/Facility/models/Facility.dart';
import 'dart:math';

class FacilityViewModel extends ChangeNotifier {
  final List<Facility> _all = [];
  String _query = '';
  String _categoryFilter = 'All';

  FacilityViewModel() {
    _seed();
  }

  void _seed() {
    // Mock facilities across cities
    final rnd = Random(42);
    final categories = ['Vet', 'Grooming', 'Boarding', 'Training', 'Pet Store'];
    final cities = ['Hyderabad', 'Bengaluru', 'Pune'];
    for (var city in cities) {
      for (int i = 1; i <= 6; i++) {
        final category = categories[(i - 1) % categories.length];
        _all.add(Facility(
          id: '${city[0]}_$i',
          name: '$category Care $i',
          category: category,
          rating: (3 + rnd.nextDouble() * 2),
          price: 300 + rnd.nextInt(1200),
          distanceKm: double.parse((1 + rnd.nextDouble() * 9).toStringAsFixed(1)),
          openNow: rnd.nextBool(),
          city: city,
          description: 'Trusted $category service in $city. Experienced staff and pet-friendly environment.',
        ));
      }
    }
    notifyListeners();
  }

  // set search query
  void setQuery(String q) {
    _query = q.toLowerCase();
    notifyListeners();
  }

  void setCategoryFilter(String cat) {
    _categoryFilter = cat;
    notifyListeners();
  }

  List<Facility> filtered(String city) {
    return _all.where((f) {
      if (f.city != city) return false;
      if (_categoryFilter != 'All' && f.category != _categoryFilter) return false;
      if (_query.isEmpty) return true;
      return f.name.toLowerCase().contains(_query) || f.category.toLowerCase().contains(_query) || f.description.toLowerCase().contains(_query);
    }).toList();
  }

  Facility? getById(String id) => _all.firstWhere((f) => f.id == id, orElse: () => throw Exception('Facility not found'));
}