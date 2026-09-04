import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../services/tts_service.dart';
import 'nenil_button.dart';

/// CelebrationOverlay — Animated visual feedback, star particles, and celebratory TTS spoken reinforcement.
class CelebrationOverlay extends StatefulWidget {
  final String title;
  final String message;
  final VoidCallback onDismiss;

  const CelebrationOverlay({
    super.key,
    this.title = 'Wonderful Job!',
    this.message = 'You completed the activity with great care and attention.',
    required this.onDismiss,
  });

  @override
  State<CelebrationOverlay> createState() => _CelebrationOverlayState();
}

class _CelebrationOverlayState extends State<CelebrationOverlay> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();

    // Spoken audio celebration
    TTSService.speak('${widget.title}. ${widget.message}');
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
      insetPadding: const EdgeInsets.all(AppDimensions.spaceL),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 48),
                padding: const EdgeInsets.all(AppDimensions.spaceXL),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.25),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 36),
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: AppDimensions.fontXL,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppDimensions.spaceM),
                    Text(
                      widget.message,
                      style: const TextStyle(
                        fontSize: AppDimensions.fontL,
                        color: AppColors.onSurface,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppDimensions.spaceXL),
                    CustomPaint(
                      size: const Size(double.infinity, 30),
                      painter: _StarParticlePainter(progress: _controller.value),
                    ),
                    const SizedBox(height: AppDimensions.spaceM),
                    NenilButton(
                      label: 'Continue Journey',
                      icon: Icons.check_circle_rounded,
                      onPressed: () {
                        widget.onDismiss();
                      },
                    ),
                  ],
                ),
              ),

              // Top Star Trophy Badge
              CircleAvatar(
                radius: 48,
                backgroundColor: AppColors.accentGold,
                child: CircleAvatar(
                  radius: 42,
                  backgroundColor: AppColors.primary,
                  child: const Icon(
                    Icons.star_rounded,
                    size: 56,
                    color: AppColors.accentGold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StarParticlePainter extends CustomPainter {
  final double progress;

  _StarParticlePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.accentGold
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);

    for (int i = 0; i < 6; i++) {
      final angle = (i * 60) * (math.pi / 180);
      final radius = 20.0 + (i % 3) * 10.0;
      final x = center.dx + math.cos(angle) * radius;
      final y = center.dy + math.sin(angle) * radius;
      canvas.drawCircle(Offset(x, y), 4.0, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _StarParticlePainter oldDelegate) => true;
}
