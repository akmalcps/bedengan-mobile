import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class PanduanScreen extends StatelessWidget {
  const PanduanScreen({super.key});

  final List<Map<String, dynamic>> _guides = const [
    {
      'title': 'Etika Menjaga Kebersihan (Leave No Trace)',
      'content': 'Bawa kantong sampah sendiri dan bawa kembali semua sampah plastik saat checkout. Jangan membuang puntung rokok atau sisa makanan ke aliran sungai.',
      'icon': Icons.delete_outline_rounded,
    },
    {
      'title': 'Tata Tertib Malam (Quiet Hours)',
      'content': 'Waktu tenang dimulai pukul 22.00 WIB. Dilarang menyalakan sound system berkekuatan besar demi kenyamanan seluruh pengunjung yang sedang beristirahat.',
      'icon': Icons.nightlight_round,
    },
    {
      'title': 'Keamanan Api Unggun & Masak',
      'content': 'Nyalakan api unggun hanya di tempat yang disediakan atau gunakan wadah/fire pit. Pastikan bara api padam sempurna sebelum tidur dan sebelum meninggalkan tenda.',
      'icon': Icons.local_fire_department_rounded,
    },
    {
      'title': 'Keselamatan di Sekitar Aliran Sungai',
      'content': 'Anak-anak harus selalu dalam pengawasan orang dewasa saat bermain di tepian sungai. Jika terjadi hujan lebat di hulu, segera jauhi bantaran sungai.',
      'icon': Icons.water_rounded,
    },
    {
      'title': 'Kelestarian Hutan Pinus',
      'content': 'Dilarang keras memaku pohon pinus, menggores batang pohon, atau merusak tanaman di sekitar area perkemahan.',
      'icon': Icons.park_rounded,
    },
    {
      'title': 'Pos Keamanan & Bantuan Darurat',
      'content': 'Petugas patroli berjaga 24 jam di Pos Registrasi 1. Jika membutuhkan bantuan darurat atau evakuasi medis ringan, segera hubungi petugas jaga.',
      'icon': Icons.health_and_safety_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Panduan & Tata Tertib',
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.forest,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: _guides.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final guide = _guides[index];
            return Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.cardShadow,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      guide['icon'] as IconData,
                      color: AppColors.forest,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    guide['title'] as String,
                    style: const TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.forest,
                    ),
                  ),
                  iconColor: AppColors.forest,
                  collapsedIconColor: AppColors.forestMuted,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 0, 18, 16),
                      child: Text(
                        guide['content'] as String,
                        style: const TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 13,
                          height: 1.5,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
