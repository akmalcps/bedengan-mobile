import '../../models/warung.dart';

class WarungMockData {
  static const List<Warung> warungs = [
    Warung(
      id: 'w1',
      name: 'Warung Soto Bedengan',
      description: 'Menyediakan Aneka Makanan Serta Minuman.',
      whatsapp: '6281234567890',
      openingTime: '08.00',
      closingTime: '20.00',
      tags: ['Soto Ayam', 'Aneka Minuman', 'Aneka Mie', 'Aneka Lalapan'],
      image: 'assets/images/warung_1.jpg',
      status: 'Buka',
    ),
    Warung(
      id: 'w2',
      name: 'Warung Bu Diroh',
      description: 'Menyediakan makanan khas dan kopi panas.',
      whatsapp: '6281234567891',
      openingTime: '07.00',
      closingTime: '21.00',
      tags: ['Kopi', 'Gorengan', 'Nasi Bungkus'],
      image: 'assets/images/warung_2.jpg',
      status: 'Buka',
    ),
    Warung(
      id: 'w3',
      name: 'Warung Barokah',
      description: 'Tempat istirahat nyaman dengan aneka cemilan.',
      whatsapp: '6281234567892',
      openingTime: '06.00',
      closingTime: '22.00',
      tags: ['Mie Rebus', 'Teh Hangat', 'Roti Bakar'],
      image: 'assets/images/warung_3.jpg',
      status: 'Tutup',
    ),
  ];
}
