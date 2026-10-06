import '../../models/rental.dart';

class RentalMockData {
  static const List<Rental> rentals = [
    Rental(
      id: 'r1',
      name: 'Bedengan Camp Rental',
      description: 'Rental perlengkapan resmi di Bedengan',
      whatsapp: '6281234567893',
      openingTime: '07.00',
      closingTime: '17.00',
      image: 'assets/images/rental_1.jpg',
      status: 'Buka',
      items: [
        RentalItem(
          id: 'ri1',
          name: 'Tenda',
          price: '60000',
          unit: 'malam',
          availability: true,
          image: 'assets/images/tenda.jpg',
        ),
        RentalItem(
          id: 'ri2',
          name: 'Paket Meja + Kursi',
          price: '90000',
          unit: 'paket',
          availability: true,
          image: 'assets/images/meja_kursi.jpg',
        ),
        RentalItem(
          id: 'ri3',
          name: 'Kompor Kotak',
          price: '25000',
          unit: 'set',
          availability: true,
          image: 'assets/images/kompor.jpg',
        ),
        RentalItem(
          id: 'ri4',
          name: 'Lampu Tenda',
          price: '10000',
          unit: 'pcs',
          availability: false,
          image: 'assets/images/lampu.jpg',
        ),
      ],
    ),
  ];
}
