import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class FloatingAIDialog extends StatefulWidget {
  const FloatingAIDialog({super.key});

  @override
  State<FloatingAIDialog> createState() => _FloatingAIDialogState();
}

class _FloatingAIDialogState extends State<FloatingAIDialog> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      'isUser': false,
      'text': 'Halo Camper! 🌲 Saya asisten AI Bedengan. Tanyakan apa saja tentang spot kemping, sewa tenda, fasilitas, atau rute lokasi.'
    }
  ];

  final List<String> _quickPrompts = [
    'Spot dekat sungai?',
    'Sewa tenda & matras?',
    'Warung yang buka malam?',
    'Akses mobil & parkir?'
  ];

  void _sendMessage([String? customText]) {
    final text = customText ?? _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({'isUser': true, 'text': text});
      if (customText == null) _controller.clear();
      
      // Simulated intelligent response
      String reply = 'Spot di Zona B dan C berada tepat di tepi aliran sungai yang jernih dan sangat ramah untuk keluarga.';
      if (text.toLowerCase().contains('sewa') || text.toLowerCase().contains('tenda')) {
        reply = 'Di Bedengan tersedia rental tenda kapasitas 2-6 orang, matras, nesting, dan flysheet di area pos utama.';
      } else if (text.toLowerCase().contains('warung') || text.toLowerCase().contains('makan')) {
        reply = 'Tersedia Warung Barokah dan beberapa warung warga di dekat pos registrasi yang buka hingga malam menyediakan mie hangat, kopi, dan makanan ringan.';
      } else if (text.toLowerCase().contains('mobil') || text.toLowerCase().contains('parkir')) {
        reply = 'Akses jalan cor halus dan aman untuk mobil maupun motor. Area parkir luas tersedia dekat Pos 1 dan Pos 2.';
      }

      _messages.add({'isUser': false, 'text': reply});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 420, maxHeight: 600),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: const BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.auto_awesome,
                      color: AppColors.forest,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Tanya AI Bedengan',
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.forest,
                          ),
                        ),
                        Text(
                          'Asisten Pintar Info & Wisata',
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: AppColors.forest),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            // Chat Messages List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  final isUser = msg['isUser'] as bool;
                  return Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      constraints: const BoxConstraints(maxWidth: 280),
                      decoration: BoxDecoration(
                        color: isUser ? AppColors.primary : AppColors.background,
                        borderRadius: BorderRadius.circular(16).copyWith(
                          bottomRight: isUser ? const Radius.circular(4) : const Radius.circular(16),
                          bottomLeft: isUser ? const Radius.circular(16) : const Radius.circular(4),
                        ),
                      ),
                      child: Text(
                        msg['text'] as String,
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 13,
                          height: 1.4,
                          fontWeight: isUser ? FontWeight.w600 : FontWeight.w400,
                          color: isUser ? AppColors.forest : AppColors.textPrimary,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Quick Prompt Chips
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              height: 44,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _quickPrompts.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final prompt = _quickPrompts[index];
                  return ActionChip(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    label: Text(prompt),
                    labelStyle: const TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.forest,
                    ),
                    backgroundColor: AppColors.sageLight.withValues(alpha: 0.6),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    onPressed: () => _sendMessage(prompt),
                  );
                },
              ),
            ),

            // Input Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onSubmitted: (_) => _sendMessage(),
                      decoration: InputDecoration(
                        hintText: 'Tanyakan sesuatu...',
                        hintStyle: const TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 13,
                          color: AppColors.textLight,
                        ),
                        filled: true,
                        fillColor: AppColors.background,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.send_rounded, color: AppColors.forest, size: 18),
                      onPressed: () => _sendMessage(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
