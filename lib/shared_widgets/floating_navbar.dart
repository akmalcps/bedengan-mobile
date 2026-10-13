import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../features/ai_assistant/presentation/widgets/floating_ai_dialog.dart';

class FloatingNavbar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onItemSelected;

  const FloatingNavbar({
    super.key,
    required this.currentIndex,
    required this.onItemSelected,
  });

  void _openAIDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss Tanya AI',
      barrierColor: Colors.black.withValues(alpha: 0.4),
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, anim1, anim2) {
        return const FloatingAIDialog();
      },
      transitionBuilder: (context, anim1, anim2, child) {
        final curve = CurvedAnimation(parent: anim1, curve: Curves.easeOutBack);
        return ScaleTransition(
          scale: curve,
          child: FadeTransition(
            opacity: anim1,
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: AppColors.sageBorder.withValues(alpha: 0.8),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            spreadRadius: 1,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            context: context,
            index: 0,
            label: 'Home',
            icon: Icons.home_rounded,
            isSelected: currentIndex == 0,
            onTap: () => onItemSelected(0),
          ),
          _buildNavItem(
            context: context,
            index: 1,
            label: 'Katalog',
            icon: Icons.menu_book_rounded,
            isSelected: currentIndex == 1,
            onTap: () => onItemSelected(1),
          ),
          _buildNavItem(
            context: context,
            index: 2,
            label: 'Tanya AI',
            icon: Icons.auto_awesome,
            isSelected: false,
            onTap: () => _openAIDialog(context),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required int index,
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.sageLight : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected
                  ? AppColors.forest
                  : (index == 2 ? AppColors.primaryDark : AppColors.forestMuted),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                color: isSelected
                    ? AppColors.forest
                    : (index == 2 ? AppColors.primaryDark : AppColors.forestMuted),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
