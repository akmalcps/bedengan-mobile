import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_colors.dart';

class RegisterVendorScreen extends StatefulWidget {
  const RegisterVendorScreen({super.key});

  @override
  State<RegisterVendorScreen> createState() => _RegisterVendorScreenState();
}

class _RegisterVendorScreenState extends State<RegisterVendorScreen> {
  // ── State ──────────────────────────────────────────────
  String? selectedCategory;
  final TextEditingController namaUsahaController = TextEditingController();
  final TextEditingController namaPemilikController = TextEditingController();
  final TextEditingController whatsappController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();
  final TextEditingController menuUnggulanController = TextEditingController();
  final TextEditingController jamOperasionalController =
      TextEditingController(text: '07.00 - 22.00');
  bool is24Hours = false;
  bool isCommitted = false;
  List<String> uploadedPhotos = ['Foto 1\nTampak Depan', 'Foto 2\nMenu / Price List'];

  @override
  void dispose() {
    namaUsahaController.dispose();
    namaPemilikController.dispose();
    whatsappController.dispose();
    instagramController.dispose();
    menuUnggulanController.dispose();
    jamOperasionalController.dispose();
    super.dispose();
  }

  // ── Helpers ─────────────────────────────────────────────
  void _onSubmit() {
    if (!isCommitted || selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.forest,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: Text(
            selectedCategory == null
                ? 'Pilih kategori usaha terlebih dahulu.'
                : 'Centang komitmen kebersihan alam terlebih dahulu.',
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 13,
              color: Colors.white,
            ),
          ),
        ),
      );
      return;
    }
    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogCtx) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 40),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 16, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Close button row
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(dialogCtx).pop(); // close dialog
                    Navigator.of(context).pop();   // return to KatalogScreen
                  },
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      size: 16,
                      color: AppColors.forestMuted,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              // Success Icon
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.sageLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_outline_rounded,
                  size: 36,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 16),
              // Title
              const Text(
                'Pendaftaran Terkirim!',
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.forest,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Kami akan meninjau pendaftaran Anda dan menghubungi via WhatsApp dalam 1–3 hari kerja.',
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(dialogCtx).pop();
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.forest,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'Kembali ke Katalog',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Category Card ────────────────────────────────────────
  Widget _buildCategoryCard(String title, String subtitle) {
    final isSelected = selectedCategory == title;
    return GestureDetector(
      onTap: () => setState(() => selectedCategory = title),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.06)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.sageBorder,
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? AppColors.forest : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_rounded, size: 13, color: AppColors.forest),
              ),
          ],
        ),
      ),
    );
  }

  // ── Section Label ────────────────────────────────────────
  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: AppColors.forest,
      ),
    );
  }

  // ── Field Label ──────────────────────────────────────────
  Widget _buildFieldLabel(String label, {bool required = false, String? action}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          if (required)
            const Text(
              ' *',
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          const Spacer(),
          if (action != null)
            Text(
              action,
              style: const TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
        ],
      ),
    );
  }

  // ── Text Field ───────────────────────────────────────────
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    String? prefixText,
    String? helperText,
    bool multiline = false,
    int maxLines = 1,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          maxLines: multiline ? null : maxLines,
          minLines: multiline ? 4 : null,
          keyboardType: multiline ? TextInputType.multiline : keyboardType,
          inputFormatters: inputFormatters,
          style: const TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 13,
            color: AppColors.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 13,
              color: AppColors.textLight,
            ),
            prefixText: prefixText,
            prefixStyle: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            filled: true,
            fillColor: AppColors.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.sageBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.sageBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
            ),
          ),
        ),
        if (helperText != null) ...[
          const SizedBox(height: 5),
          Text(
            helperText,
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 11,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ],
    );
  }

  // ── Section Card wrapper ─────────────────────────────────
  Widget _buildSectionCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.sageBorder),
      ),
      child: child,
    );
  }

  // ────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: AppColors.forest),
        ),
        title: const Text(
          'Daftar Mitra Katalog',
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColors.forest,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // ── Scrollable form ──────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Header ────────────────────────────────
                  _buildHeader(),
                  const SizedBox(height: 20),

                  // ── Section 1: Kategori ───────────────────
                  _buildSectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionLabel('1. Pilih Kategori'),
                        const SizedBox(height: 14),
                        _buildCategoryCard(
                          'Warung & Kuliner',
                          'Makanan, snack, mie instan, & minuman',
                        ),
                        _buildCategoryCard(
                          'Fotografer Prewed',
                          'Dokumentasi wedding, video reel & piknik',
                        ),
                        _buildCategoryCard(
                          'Sewa Alat Camp',
                          'Tenda, matras, kompor, hammock, kayu',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ── Section 2: Profil Usaha ───────────────
                  _buildSectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionLabel('2. Profil Usaha / Brand'),
                        const SizedBox(height: 16),

                        _buildFieldLabel('Nama Usaha atau Nama Jasa', required: true),
                        _buildTextField(
                          controller: namaUsahaController,
                          hint: 'Contoh: Warung Berkah Mak Siti / @rimba.visuals',
                        ),
                        const SizedBox(height: 14),

                        _buildFieldLabel('Nama Pemilik / Pengelola', required: true),
                        _buildTextField(
                          controller: namaPemilikController,
                          hint: 'Nama lengkap Anda',
                        ),
                        const SizedBox(height: 14),

                        _buildFieldLabel(
                          'Nomor WhatsApp Aktif',
                          required: true,
                          action: 'Tautan tombol Hubungi WA',
                        ),
                        _buildTextField(
                          controller: whatsappController,
                          hint: '812–3456–7890',
                          prefixText: '+62  ',
                          keyboardType: TextInputType.phone,
                          helperText:
                              'Pastikan nomor aktif WhatsApp untuk menerima order dari pengunjung Bedengan.',
                        ),
                        const SizedBox(height: 14),

                        _buildFieldLabel('Akun Instagram / TikTok', required: false),
                        _buildTextField(
                          controller: instagramController,
                          hint: 'username.usaha (untuk portofolio / katalog)',
                          prefixText: '@  ',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ── Section 3: Jam Operasional (CONDITIONAL) ──
                  if (selectedCategory != 'Fotografer Prewed') ...[
                    _buildSectionCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionLabel('3. Jam Operasional'),
                          const SizedBox(height: 14),

                          _buildFieldLabel('Jam Operasional Warung / Layanan', required: true),
                          Row(
                            children: [
                              // Checkbox Buka 24 Jam
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => setState(() {
                                    is24Hours = !is24Hours;
                                    if (is24Hours) {
                                      jamOperasionalController.text = '00.00 - 24.00';
                                    } else {
                                      jamOperasionalController.text = '07.00 - 22.00';
                                    }
                                  }),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 13),
                                    decoration: BoxDecoration(
                                      color: AppColors.surface,
                                      borderRadius: BorderRadius.circular(12),
                                      border:
                                          Border.all(color: AppColors.sageBorder),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: Checkbox(
                                            value: is24Hours,
                                            onChanged: (val) => setState(() {
                                              is24Hours = val ?? false;
                                              jamOperasionalController.text = is24Hours
                                                  ? '00.00 - 24.00'
                                                  : '07.00 - 22.00';
                                            }),
                                            activeColor: AppColors.primary,
                                            checkColor: AppColors.forest,
                                            side: const BorderSide(
                                                color: AppColors.sageBorder),
                                            materialTapTargetSize:
                                                MaterialTapTargetSize.shrinkWrap,
                                            visualDensity: VisualDensity.compact,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          'Buka 24 Jam',
                                          style: TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              // Custom hours field
                              Expanded(
                                child: TextField(
                                  controller: jamOperasionalController,
                                  enabled: !is24Hours,
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontSize: 13,
                                    color: is24Hours
                                        ? AppColors.textLight
                                        : AppColors.textPrimary,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Atau: 07.00 - 22.00',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      fontSize: 12,
                                      color: AppColors.textLight,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 13),
                                    filled: true,
                                    fillColor: is24Hours
                                        ? AppColors.surfaceLight
                                        : AppColors.surface,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                          color: AppColors.sageBorder),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                          color: AppColors.sageBorder),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                          color: AppColors.primary, width: 1.5),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                          color: AppColors.sageBorder),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),

                          _buildFieldLabel('Menu Utama / Item Layanan Unggulan', required: true),
                          _buildTextField(
                            controller: menuUnggulanController,
                            hint:
                                'Contoh:\n• Soto Ayam & Mie Rebus Spesial\n• Aneka Gorengan Hangat & Teh Tarik\n• Rental Tenda Dome 4P + Matras',
                            multiline: true,
                            helperText:
                                'Item ini akan ditampilkan sebagai badge filter pada kartu katalog Anda.',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ] else ...[
                    const SizedBox.shrink(),
                  ],

                  // ── Section 4: Foto Upload ────────────────
                  _buildSectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildSectionLabel('4. Foto Usaha / Brosur / Sampel Layanan'),
                            Text(
                              'Maks. 10 foto',
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textLight,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Upload area
                        GestureDetector(
                          onTap: () {
                            if (uploadedPhotos.length < 10) {
                              setState(() => uploadedPhotos
                                  .add('Foto ${uploadedPhotos.length + 1}'));
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 28),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF6FAF4),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: AppColors.primary.withValues(alpha: 0.45),
                                width: 1.5,
                                strokeAlign: BorderSide.strokeAlignInside,
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: AppColors.sageLight,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.photo_camera_outlined,
                                    size: 24,
                                    color: AppColors.forest,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Ketuk untuk Upload Foto',
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.forest,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Format JPG/PNG foto warung, daftar menu, atau hasil foto kamera',
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontSize: 11,
                                    color: AppColors.textSecondary,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Uploaded photo chips
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            ...uploadedPhotos.map((label) => _buildPhotoChip(label)),
                            // + Tambah button
                            if (uploadedPhotos.length < 10)
                              GestureDetector(
                                onTap: () {
                                  setState(() => uploadedPhotos
                                      .add('Foto ${uploadedPhotos.length + 1}'));
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: AppColors.surface,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: AppColors.sageBorder,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                  child: const Text(
                                    '+ Tambah',
                                    style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ── Commitment Checkbox ───────────────────
                  _buildCommitmentRow(),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),

          // ── Sticky Submit Button ─────────────────────────
          _buildSubmitBar(),
        ],
      ),
    );
  }

  // ────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Daftarkan Usaha & Jasamu',
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: AppColors.forest,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Hubungkan lapak warung, sewa peralatan kemah, atau jasa dokumentasi foto Anda langsung dengan ribuan pengunjung Bedengan Malang.',
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 13,
            color: AppColors.textSecondary,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 14),
        // Dashed benefit card
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF2FAF0),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.5),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.sageLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.verified_outlined,
                  size: 16,
                  color: AppColors.forest,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Gratis & Terhubung Langsung ke WhatsApp',
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.forest,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Bebas biaya pendaftaran untuk warga lokal kawasan & fotografer mitra. Pengunjung dapat menghubungi kontak Anda dalam 1 klik.',
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 11,
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPhotoChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.sageLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.image_outlined, size: 18, color: AppColors.forest),
          const SizedBox(height: 3),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: AppColors.forest,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCommitmentRow() {
    return GestureDetector(
      onTap: () => setState(() => isCommitted = !isCommitted),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 22,
            height: 22,
            child: Checkbox(
              value: isCommitted,
              onChanged: (val) => setState(() => isCommitted = val ?? false),
              activeColor: AppColors.primary,
              checkColor: AppColors.forest,
              side: const BorderSide(color: AppColors.sageBorder, width: 1.5),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Saya berkomitmen menjaga kebersihan alam, tidak membuang sampah sembarangan ke aliran sungai, dan mematuhi tata tertib pengelola Bedengan Xplore.',
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 12,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitBar() {
    final bool canSubmit = isCommitted && selectedCategory != null;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _onSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: canSubmit
                  ? AppColors.primary
                  : AppColors.primary.withValues(alpha: 0.45),
              foregroundColor: AppColors.forest,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text(
              'Kirim Pendaftaran',
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
