import '../../models/photographer.dart';

class PhotographerMockData {
  static const List<Photographer> photographers = [
    Photographer(
      id: 'p1',
      name: 'The Prime Photography',
      instagramUsername: '@theprimephotography',
      instagramUrl: 'https://instagram.com/theprimephotography',
      whatsapp: '6281234567894',
      location: 'Malang',
      description: 'Nature, love, and timeless memories.',
      profileImage: 'assets/images/photo_prime.jpg',
      status: 'Tersedia',
      gallery: [
        'assets/images/gallery_1.jpg',
        'assets/images/gallery_2.jpg',
        'assets/images/gallery_3.jpg',
      ],
      services: [
        PhotographerService(
          id: 's1',
          name: 'Prewedding Outdoor',
          description: 'Sesi foto di alam Bedengan',
          startingPrice: '1500000',
        ),
      ],
    ),
    Photographer(
      id: 'p2',
      name: 'Alan Picture',
      instagramUsername: '@alanpicture.id',
      instagramUrl: 'https://instagram.com/alanpicture.id',
      whatsapp: '6281234567895',
      location: 'Malang',
      description: 'Menangkap momen indah Anda.',
      profileImage: 'assets/images/photo_alan.jpg',
      status: 'Tersedia',
      gallery: [
        'assets/images/gallery_4.jpg',
        'assets/images/gallery_5.jpg',
        'assets/images/gallery_6.jpg',
      ],
      services: [
        PhotographerService(
          id: 's2',
          name: 'Wedding Photography',
          description: 'Full day wedding coverage',
          startingPrice: '3000000',
        ),
      ],
    ),
    Photographer(
      id: 'p3',
      name: 'Ziestoria',
      instagramUsername: '@ziestoria',
      instagramUrl: 'https://instagram.com/ziestoria',
      whatsapp: '6281234567896',
      location: 'Malang Raya',
      description: 'Cerita cinta yang abadi.',
      profileImage: 'assets/images/photo_zie.jpg',
      status: 'Sibuk',
      gallery: [
        'assets/images/gallery_7.jpg',
        'assets/images/gallery_8.jpg',
        'assets/images/gallery_9.jpg',
      ],
      services: [
        PhotographerService(
          id: 's3',
          name: 'Prewedding Casual',
          description: 'Sesi santai 2 jam',
          startingPrice: '800000',
        ),
      ],
    ),
  ];
}
