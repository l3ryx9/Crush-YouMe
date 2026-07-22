import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/painters/tropical_paradise_painter.dart';
import '../../core/widgets/bubble_button.dart';
import '../../core/theme/colors.dart';
import '../../core/router/app_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      body: _TropicalHomeBody(),
    );
  }
}

class _TropicalHomeBody extends StatelessWidget {
  const _TropicalHomeBody();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TropicalParadise(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _GlassChip(
                    icon: Icons.eco_rounded,
                    label: 'YouMe',
                    iconColor: AppColors.appleGreen,
                  ),
                  _GlassChip(
                    icon: Icons.notifications_active_rounded,
                    label: '3',
                    iconColor: Colors.white,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: isDark ? AppColors.glassSurfaceDark : Colors.white.withOpacity(0.85),
                  border: Border.all(
                    color: isDark ? AppColors.glassBorderDark : AppColors.glassBorderLight,
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 30,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      '🌴 BIENVENUE 🌴',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? AppColors.mintSubtle : AppColors.emeraldPrimary,
                        letterSpacing: 3,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'YouMe',
                      style: TextStyle(
                        fontFamily: 'Playfair',
                        fontSize: 44,
                        fontWeight: FontWeight.w900,
                        color: isDark ? Colors.white : AppColors.textDark,
                        letterSpacing: 4,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.4),
                            blurRadius: 15,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'FORÊT TROPICALE PREMIUM 3D',
                      style: TextStyle(
                        fontSize: 10,
                        color: (isDark ? AppColors.mintSubtle : AppColors.textDark).withOpacity(0.7),
                        letterSpacing: 4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        _StatBubble(label: 'Messages', value: '24'),
                        _StatBubble(label: 'Contacts', value: '138'),
                        _StatBubble(label: 'En ligne', value: '7'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  BubbleButton(
                    label: 'Messages',
                    icon: Icons.chat_bubble_rounded,
                    color: AppColors.tropicalGreen,
                    width: size.width - 64,
                    onPressed: () => context.go('${AppRoutes.home}/conversations'),
                  ),
                  const SizedBox(height: 12),
                  BubbleButton(
                    label: 'Contacts',
                    icon: Icons.people_alt_rounded,
                    color: AppColors.emeraldPrimary,
                    width: size.width - 64,
                    onPressed: () => context.go('${AppRoutes.home}/contacts'),
                  ),
                  const SizedBox(height: 12),
                  BubbleButton(
                    label: 'Recherche IA',
                    icon: Icons.auto_awesome_rounded,
                    color: AppColors.appleGreen,
                    width: size.width - 64,
                    onPressed: () => context.go('${AppRoutes.home}/ai-search'),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: BubbleButton(
                          label: 'Profil',
                          icon: Icons.person_rounded,
                          color: AppColors.leafGreen,
                          width: double.infinity,
                          height: 50,
                          fontSize: 14,
                          onPressed: () => context.go('${AppRoutes.home}/profile'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: BubbleButton(
                          label: 'Réglages',
                          icon: Icons.tune_rounded,
                          color: AppColors.emeraldDark,
                          width: double.infinity,
                          height: 50,
                          fontSize: 14,
                          onPressed: () => context.go('${AppRoutes.home}/settings'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }
}

class _GlassChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;

  const _GlassChip({
    required this.icon,
    required this.label,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(0.12),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: 18),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatBubble extends StatelessWidget {
  final String label;
  final String value;

  const _StatBubble({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white.withOpacity(0.1),
        border: Border.all(color: Colors.white.withOpacity(0.15), width: 1),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
