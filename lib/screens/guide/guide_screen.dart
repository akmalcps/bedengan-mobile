import 'package:flutter/material.dart';
import '../../theme/app_typography.dart';
import '../../theme/app_colors.dart';

class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});

  final List<Map<String, String>> _guides = const [
    {
      'title': 'Kebersihan',
      'content': 'Selalu bawa turun kembali sampah Anda. Jangan meninggalkan sampah di area camping. Gunakan tempat sampah yang telah disediakan di pintu keluar atau pos.'
    },
    {
      'title': 'Keamanan',
      'content': 'Jaga barang bawaan berharga Anda. Meskipun aman, disarankan untuk tidak meninggalkan barang berharga tanpa pengawasan di dalam tenda.'
    },
    {
      'title': 'Tata Tertib',
      'content': 'Hargai pengunjung lain. Kurangi kebisingan setelah jam 22.00 WIB. Dilarang membawa minuman keras, senjata tajam (selain untuk memasak), atau obat terlarang.'
    },
    {
      'title': 'Etika Camping',
      'content': 'Gunakan fasilitas umum dengan baik. Matikan keran air setelah digunakan. Jangan merusak flora dan fauna setempat.'
    },
    {
      'title': 'Menjaga Lingkungan',
      'content': 'Dilarang menebang pohon atau mematahkan ranting sembarangan. Gunakan kayu bakar yang sudah tersedia dari pengelola atau bawa sendiri.'
    },
    {
      'title': 'Informasi Penting',
      'content': 'Jika terjadi keadaan darurat, hubungi nomor pos pengelola yang tertera di pintu masuk atau hubungi petugas yang berpatroli.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Panduan & Tata Tertib Pengunjung'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: _guides.length,
        itemBuilder: (context, index) {
          final guide = _guides[index];
          return Card(
            elevation: 0,
            color: AppColors.white,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                iconColor: AppColors.primary,
                collapsedIconColor: AppColors.primary,
                title: Text(guide['title']!, style: AppTypography.heading3),
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Text(guide['content']!, style: AppTypography.bodyMedium),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
