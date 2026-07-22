import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/router/app_router.dart';
import '../../core/theme/colors.dart';

/// Animation d'introduction : Ananas 3D + Explosion + Révélation YouMe
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _timelineCtrl;
  late final AnimationController _shimmerCtrl;

  late final Animation<double> _pineappleScale;
  late final Animation<double> _pineappleOpacity;
  late final Animation<double> _explosionProgress;
  late final Animation<double> _textOpacity;
  late final Animation<double> _textScale;
  late final Animation<double> _fadeOut;

  final List<_TropicalPiece> _pieces = [];
  final _rng = math.Random(42);

  static const _pieceColors = [
    Color(0xFFFFEA00), Color(0xFFFF9100), Color(0xFF76FF03),
    Color(0xFF1B5E3A), Color(0xFF00E676), Color(0xFFFF3D00),
  ];

  @override
  void initState() {
    super.initState();
    _buildPieces();

    _timelineCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3600),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed && mounted) {
          context.go(AppRoutes.login);
        }
      });

    _shimmerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _pineappleScale = CurvedAnimation(
      parent: _timelineCtrl,
      curve: const Interval(0.00, 0.25, curve: Curves.elasticOut),
    );

    _pineappleOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _timelineCtrl,
        curve: const Interval(0.32, 0.44, curve: Curves.easeOut),
      ),
    );

    _explosionProgress = CurvedAnimation(
      parent: _timelineCtrl,
      curve: const Interval(0.32, 0.78, curve: Curves.easeOutCubic),
    );

    _textOpacity = CurvedAnimation(
      parent: _timelineCtrl,
      curve: const Interval(0.48, 0.75, curve: Curves.easeIn),
    );

    _textScale = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(
        parent: _timelineCtrl,
        curve: const Interval(0.48, 0.78, curve: Curves.elasticOut),
      ),
    );

    _fadeOut = CurvedAnimation(
      parent: _timelineCtrl,
      curve: const Interval(0.88, 1.00, curve: Curves.easeInOut),
    );

    _timelineCtrl.forward();
  }

  void _buildPieces() {
    for (int i = 0; i < 40; i++) {
      final angle = (i / 40) * 2 * math.pi + _rng.nextDouble() * 0.2;
      _pieces.add(_TropicalPiece(
        angle: angle,
        speed: 150 + _rng.nextDouble() * 350,
        rotSpeed: (_rng.nextDouble() - 0.5) * 14,
        size: 8 + _rng.nextDouble() * 22,
        color: _pieceColors[_rng.nextInt(_pieceColors.length)],
        isLeaf: i.isEven,
      ));
    }
  }

  @override
  void dispose() {
    _timelineCtrl.dispose();
    _shimmerCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([_timelineCtrl, _shimmerCtrl]),
        builder: (context, _) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: AppColors.tropicalNightGradient,
                ),
              ),
              CustomPaint(
                painter: _TropicalLightRaysPainter(_timelineCtrl.value),
                size: size,
              ),
              if (_explosionProgress.value > 0)
                CustomPaint(
                  painter: _PineappleExplosionPainter(
                    pieces: _pieces,
                    progress: _explosionProgress.value,
                    center: Offset(size.width / 2, size.height / 2),
                  ),
                  size: size,
                ),
              if (_pineappleOpacity.value > 0)
                Center(
                  child: Opacity(
                    opacity: _pineappleOpacity.value.clamp(0.0, 1.0),
                    child: Transform.scale(
                      scale: _pineappleScale.value,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.appleGreen.withOpacity(0.4),
                              blurRadius: 40,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                        child: CustomPaint(
                          painter: _Pineapple3DSplashPainter(),
                          size: const Size(140, 180),
                        ),
                      ),
                    ),
                  ),
                ),
              if (_textOpacity.value > 0)
                Center(
                  child: Opacity(
                    opacity: _textOpacity.value.clamp(0.0, 1.0),
                    child: Transform.scale(
                      scale: _textScale.value,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'YouMe',
                            style: TextStyle(
                              fontFamily: 'Playfair',
                              fontSize: 72,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 6,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.8),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                                Shadow(
                                  color: AppColors.appleGreen.withOpacity(0.8),
                                  blurRadius: 30,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '🌴 FORÊT TROPICALE 🌴',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 4,
                              color: AppColors.mintSubtle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              if (_fadeOut.value > 0)
                Opacity(
                  opacity: _fadeOut.value.clamp(0.0, 1.0),
                  child: Container(color: AppColors.jungleDark),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _TropicalPiece {
  final double angle, speed, rotSpeed, size;
  final Color color;
  final bool isLeaf;
  const _TropicalPiece({
    required this.angle,
    required this.speed,
    required this.rotSpeed,
    required this.size,
    required this.color,
    required this.isLeaf,
  });
}

class _PineappleExplosionPainter extends CustomPainter {
  final List<_TropicalPiece> pieces;
  final double progress;
  final Offset center;

  const _PineappleExplosionPainter({
    required this.pieces,
    required this.progress,
    required this.center,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final t = progress;
    final distFactor = math.pow(t, 0.6).toDouble();

    for (final p in pieces) {
      final d = p.speed * distFactor;
      final x = center.dx + math.cos(p.angle) * d;
      final y = center.dy + math.sin(p.angle) * d + (t * t * 120);
      final rot = p.rotSpeed * t * math.pi;
      final alpha = (1.0 - math.pow(t, 1.4)).clamp(0.0, 1.0).toDouble();

      if (alpha <= 0) continue;

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(rot);

      final paint = Paint()..color = p.color.withOpacity(alpha);

      if (p.isLeaf) {
        final path = Path()
          ..moveTo(0, -p.size)
          ..quadraticBezierTo(p.size * 0.5, 0, 0, p.size)
          ..quadraticBezierTo(-p.size * 0.5, 0, 0, -p.size);
        canvas.drawPath(path, paint);
      } else {
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(center: Offset.zero, width: p.size, height: p.size * 0.8),
            const Radius.circular(4),
          ),
          paint,
        );
      }
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_PineappleExplosionPainter old) => old.progress != progress;
}

class _Pineapple3DSplashPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height * 0.55;

    final bodyRect = Rect.fromCenter(
      center: Offset(cx, cy),
      width: size.width * 0.8,
      height: size.height * 0.65,
    );

    canvas.drawOval(
      bodyRect,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.3, -0.4),
          radius: 0.85,
          colors: const [
            Color(0xFFFFEA00),
            Color(0xFFFF9100),
            Color(0xFFE65100),
          ],
        ).createShader(bodyRect),
    );
  }

  @override
  bool shouldRepaint(_) => false;
}

class _TropicalLightRaysPainter extends CustomPainter {
  final double t;
  _TropicalLightRaysPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.appleGreen.withOpacity(0.15),
          Colors.transparent,
        ],
      ).createShader(Offset.zero & size);

    canvas.drawCircle(Offset(size.width * 0.5, 0), size.width * 0.8, paint);
  }

  @override
  bool shouldRepaint(_TropicalLightRaysPainter old) => old.t != t;
}
