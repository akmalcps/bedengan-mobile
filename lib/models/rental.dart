class RentalItem {
  final String id;
  final String name;
  final String price;
  final String unit;
  final bool availability;
  final String image;

  const RentalItem({
    required this.id,
    required this.name,
    required this.price,
    required this.unit,
    required this.availability,
    required this.image,
  });
}

class Rental {
  final String id;
  final String name;
  final String description;
  final String whatsapp;
  final String openingTime;
  final String closingTime;
  final String image;
  final List<RentalItem> items;
  final String status;

  const Rental({
    required this.id,
    required this.name,
    required this.description,
    required this.whatsapp,
    required this.openingTime,
    required this.closingTime,
    required this.image,
    required this.items,
    required this.status,
  });
}
