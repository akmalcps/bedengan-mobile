class WarungModel {
  final String name;
  final String time;
  final String description;
  final List<String> menus;
  final String waLink;

  const WarungModel({
    required this.name,
    required this.time,
    required this.description,
    required this.menus,
    required this.waLink,
  });
}

class RentalModel {
  final String name;
  final String description;
  final List<Map<String, String>> items;
  final String waLink;

  const RentalModel({
    required this.name,
    required this.description,
    required this.items,
    required this.waLink,
  });
}

class PhotographerModel {
  final String username;
  final String title;
  final List<String> imageUrls;
  final String description;
  final String igLink;
  final String? avatarInitials;

  const PhotographerModel({
    required this.username,
    required this.title,
    required this.imageUrls,
    required this.description,
    required this.igLink,
    this.avatarInitials,
  });
}

// ==================== DUMMY DATA ====================

final List<WarungModel> dummyWarungs = [
  const WarungModel(
    name: 'Warung Soto Bedengan',
    time: '08.00–20.00',
    description: 'Menyediakan Aneka Makanan Serta Minuman.',
    menus: [
      'Soto Ayam',
      'Aneka Minuman',
      'Aneka Mie',
      'Aneka Lalapan',
    ],
    waLink: 'https://wa.me/6281234567890?text=Halo%20Warung%20Soto%20Bedengan,%20saya%20ingin%20pesan%20makanan',
  ),
  const WarungModel(
    name: 'Warung Bu Diroh',
    time: '06.00 - 22.00',
    description: 'Menyediakan Aneka Makanan Serta Rental Tikar',
    menus: [
      'Nasi Rawon',
      'Aneka Lalapan',
      'Olahan Degan dan Susu Sapi Segar',
    ],
    waLink: 'https://wa.me/6281234567891?text=Halo%20Warung%20Bu%20Diroh,%20apakah%20buka%20hari%20ini?',
  ),
  const WarungModel(
    name: 'Warung Barokah',
    time: '07.00 - 23.00',
    description: 'Pusat Makanan Hangat Serta Menyediakan Jas Hujan',
    menus: [
      'Bakso dan Mie',
      'Aneka Soto',
      'Aneka Minuman Segar dan Hangat',
    ],
    waLink: 'https://wa.me/6281234567892?text=Halo%20Warung%20Barokah,%20saya%20ingin%20tanya%20menu%20dan%20jas%20hujan',
  ),
];

final List<RentalModel> dummyRentals = [
  const RentalModel(
    name: 'Bedengan Camp Rental',
    description: 'Penyedia resmi peralatan berkemah terlengkap siap pakai',
    items: [
      {
        'name': 'Tenda',
        'price': 'Rp 60.000 /mlm',
      },
      {
        'name': 'Paket Meja + Kursi',
        'price': 'Rp 90.000',
      },
      {
        'name': 'Kompor Kotak',
        'price': 'Rp 25.000 /set',
      },
      {
        'name': 'Lampu Tenda',
        'price': 'Rp 10.000 /pcs',
      },
    ],
    waLink: 'https://wa.me/6281234567893?text=Halo%20Bedengan%20Camp%20Rental,%20saya%20ingin%20sewa%20alat%20camping',
  ),
];

final List<PhotographerModel> dummyPhotographers = [
  const PhotographerModel(
    username: '@alanpicture.id',
    title: 'Foto & Video Wedding | Only-MLG',
    avatarInitials: 'AP',
    imageUrls: [
      'https://images.unsplash.com/photo-1519741497674-611481863552?q=80&w=600&auto=format&fit=crop',
      'https://images.unsplash.com/photo-1511285560929-80b456fea0bc?q=80&w=600&auto=format&fit=crop',
      'https://images.unsplash.com/photo-1465495976277-4387d4b0b4c6?q=80&w=600&auto=format&fit=crop',
    ],
    description:
        'Spesialis foto wedding dengan tema alam yang hangat dan bisa disesuaikan oleh customer.',
    igLink: 'https://instagram.com/alanpicture.id',
  ),
  const PhotographerModel(
    username: '@ziestoria',
    title: 'Fotografer Stories | Based-SDA- SBY',
    avatarInitials: 'ZS',
    imageUrls: [
      'https://images.unsplash.com/photo-1522673607200-164d1b6ce486?q=80&w=600&auto=format&fit=crop',
      'https://images.unsplash.com/photo-1583939003579-730e3918a45a?q=80&w=600&auto=format&fit=crop',
      'https://images.unsplash.com/photo-1532712938310-34cb3982ef74?q=80&w=600&auto=format&fit=crop',
    ],
    description:
        'Menyediakan properti piknik estetik kayu, kain etnik, hammock, dan lentera hangat untuk sesi romantis.',
    igLink: 'https://instagram.com/ziestoria',
  ),
];
