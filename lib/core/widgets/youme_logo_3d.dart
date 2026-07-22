import 'package:flutter/material.dart';

/// Logo central réutilisable « Ananas 3D + YouMe Blanc 3D »
class YouMeLogo3D extends StatelessWidget {
  final double scale;
  final bool isDarkTheme;

  const YouMeLogo3D({
    super.key,
    this.scale = 1.0,
    this.isDarkTheme = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Ananas 3D Sculpté
        SizedBox(
          width: 100 * scale,
          height: 120 * scale,
          child: CustomPaint(
            painter: _Pineapple3DLogoPainter(),
          ),
        ),
        SizedBox(height: 10 * scale),
        // Texte YouMe Blanc 3D
        Stack(
          children: [
            // Ombre portée 3D du texte
            Text(
              'YouMe',
              style: TextStyle(
                fontFamily: 'Playfair',
                fontSize: 38 * scale,
                fontWeight: FontWeight.w900,
                letterSpacing: 4,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 3
                  ..color = Colors.black.withOpacity(0.6),
              ),
            ),
            // Effet d'extrusion 3D sous-jacent
            Positioned(
              top: 2,
              left: 2,
              child: Text(
                'YouMe',
                style: TextStyle(
                  fontFamily: 'Playfair',
                  fontSize: 38 * scale,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 4,
                  color: isDarkTheme ? const Color(0xFF1B5E3A) : const Color(0xFF2E8B57),
                ),
              ),
            ),
            // Face avant brillante du texte Blanc 3D
            Text(
              'YouMe',
              style: TextStyle(
                fontFamily: 'Playfair',
                fontSize: 38 * scale,
                fontWeight: FontWeight.w900,
                letterSpacing: 4,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                  Shadow(
                    color: const Color(0xFF76FF03).withOpacity(0.6),
                    blurRadius: 15,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 4 * scale),
        Text(
          'FORÊT TROPICALE PREMIUM',
          style: TextStyle(
            fontSize: 10 * scale,
            fontWeight: FontWeight.w600,
            letterSpacing: 3,
            color: isDarkTheme ? const Color(0xFFA7F3D0) : const Color(0xFF1B5E3A),
          ),
        ),
      ],
    );
  }
}

class _Pineapple3DLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height * 0.62;

    // Ombre 3D réaliste au sol
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx, cy + 22), width: size.width * 0.7, height: 16),
      Paint()
        ..color = Colors.black.withOpacity(0.35)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
    );

    // Corps de l'ananas (Forme 3D)
    final bodyRect = Rect.fromCenter(
      center: Offset(cx, cy),
      width: size.width * 0.65,
      height: size.height * 0.6,
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
            Color(0xFFBF360C),
          ],
          stops: const [0.0, 0.45, 0.8, 1.0],
        ).createShader(bodyRect),
    );

    // Biseautage et losanges 3D de la peau de l'ananas
    canvas.save();
    canvas.clipOval(bodyRect);
    final gridPaint = Paint()
      ..color = const Color(0xFF5D4037).withOpacity(0.4)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    for (double i = -size.width; i < size.width * 2; i += 12) {
      canvas.drawLine(Offset(i, 0), Offset(i + size.height, size.height), gridPaint);
      canvas.drawLine(Offset(i, size.height), Offset(i + size.height, 0), gridPaint);
    }
    canvas.restore();

    // Reflet de lumière 3D (Gloss)
    canvas.drawOval(
      bodyRect,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.45, -0.5),
          radius: 0.4,
          colors: [Colors.white.withOpacity(0.5), Colors.transparent],
        ).createShader(bodyRect),
    );

    // Couronne de feuilles vertes 3D
    _drawCrown(canvas, cx, cy - (size.height * 0.3));
  }

  void _drawCrown(Canvas canvas, double cx, double baseY) {
    final leafAngles = [-45.0, -25.0, 0.0, 25.0, 45.0];
    for (final angle in leafAngles) {
      canvas.save();
      canvas.translate(cx, baseY);
      canvas.rotate(angle * 3.14159 / 180);

      final path = Path()
        ..moveTo(0, 0)
        ..quadraticBezierTo(-8, -20, 0, -35)
        ..quadraticBezierTo(8, -20, 0, 0);

      canvas.drawPath(
        path,
        Paint()
          ..shader = const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF76FF03), Color(0xFF1B5E3A)],
          ).createShader(Rect.fromLTWH(-10, -35, 20, 35)),
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_) => false;
}
