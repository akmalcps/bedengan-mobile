class CampingArea {
  final String id;
  final String number;
  final String name;
  final String description;
  final String image;
  final List<String> facilities;
  final String status;

  const CampingArea({
    required this.id,
    required this.number,
    required this.name,
    required this.description,
    required this.image,
    required this.facilities,
    required this.status,
  });
}
