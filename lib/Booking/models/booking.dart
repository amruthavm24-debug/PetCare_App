class Booking {
  final String id;
  final String facilityId;
  final String facilityName;
  final String petType;
  final DateTime dateTime;

  Booking({
    required this.id,
    required this.facilityId,
    required this.facilityName,
    required this.petType,
    required this.dateTime,
  });
}