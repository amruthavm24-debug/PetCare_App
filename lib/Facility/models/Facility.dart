
class Facility {
  final String id;
  final String name;
  final String category; // Vet / Grooming / Boarding / Training / Pet Store
  final double rating;
  final int price;
  final double distanceKm;
  final bool openNow;
  final String city;
  final String description;

  Facility({
    required this.id,
    required this.name,
    required this.category,
    required this.rating,
    required this.price,
    required this.distanceKm,
    required this.openNow,
    required this.city,
    required this.description,
  });
}