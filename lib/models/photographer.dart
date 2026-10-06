class PhotographerService {
  final String id;
  final String name;
  final String description;
  final String startingPrice;

  const PhotographerService({
    required this.id,
    required this.name,
    required this.description,
    required this.startingPrice,
  });
}

class Photographer {
  final String id;
  final String name;
  final String instagramUsername;
  final String instagramUrl;
  final String whatsapp;
  final String location;
  final String description;
  final String profileImage;
  final List<String> gallery;
  final List<PhotographerService> services;
  final String status;

  const Photographer({
    required this.id,
    required this.name,
    required this.instagramUsername,
    required this.instagramUrl,
    required this.whatsapp,
    required this.location,
    required this.description,
    required this.profileImage,
    required this.gallery,
    required this.services,
    required this.status,
  });
}
