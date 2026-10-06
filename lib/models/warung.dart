class Warung {
  final String id;
  final String name;
  final String description;
  final String whatsapp;
  final String openingTime;
  final String closingTime;
  final List<String> tags;
  final String image;
  final String status;

  const Warung({
    required this.id,
    required this.name,
    required this.description,
    required this.whatsapp,
    required this.openingTime,
    required this.closingTime,
    required this.tags,
    required this.image,
    required this.status,
  });
}
