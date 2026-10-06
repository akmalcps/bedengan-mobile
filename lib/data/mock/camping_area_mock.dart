import '../../models/camping_area.dart';

class CampingAreaMockData {
  static const List<CampingArea> areas = [
    CampingArea(
      id: 'c1',
      number: 'Area 1',
      name: 'Zona Pinus',
      description: 'Area camping di bawah rimbunnya pohon pinus. Sangat cocok untuk keluarga dan grup.',
      image: 'assets/images/camp_1.jpg',
      facilities: ['Toilet dekat', 'Akses listrik', 'Dekat warung'],
      status: 'Tersedia',
    ),
    CampingArea(
      id: 'c2',
      number: 'Area 2',
      name: 'Zona Sungai',
      description: 'Area camping persis di pinggir sungai dengan suara gemericik air yang menenangkan.',
      image: 'assets/images/camp_2.jpg',
      facilities: ['Dekat sungai', 'Spot api unggun'],
      status: 'Penuh',
    ),
    CampingArea(
      id: 'c3',
      number: 'Area 3',
      name: 'Zona Bukit',
      description: 'Area camping di bagian lebih tinggi dengan pemandangan terbuka luas.',
      image: 'assets/images/camp_3.jpg',
      facilities: ['Pemandangan luas', 'Jauh dari keramaian'],
      status: 'Tersedia',
    ),
  ];
}
