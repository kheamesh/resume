import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../controllers/background_controller.dart';

class PremiumBackground extends StatelessWidget {
  final Widget child;
  const PremiumBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BackgroundController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onHover: (event) => controller.updateMousePos(event.localPosition),
      child: Stack(
        children: [
          // 1. Base color
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          
          // 2. Animated Mesh Gradients (Professional Blurs)
          // For Dark Mode: Deep cosmic tones
          if (isDark) ...[
            _buildAnimatedGlow(
              color: const Color(0xFF1A1033).withValues(alpha: 0.35), 
              size: 900,
              offset: const Offset(-0.4, -0.3),
              animation: controller.animationController,
            ),
            _buildAnimatedGlow(
              color: AppColors.gold.withValues(alpha: 0.04), 
              size: 700,
              offset: const Offset(0.6, 0.4),
              animation: controller.animationController,
              reverse: true,
            ),
            _buildAnimatedGlow(
              color: const Color(0xFF001F3F).withValues(alpha: 0.25), 
              size: 800,
              offset: const Offset(0.7, -0.5),
              animation: controller.animationController,
            ),
          ],
          
          // For Light Mode: Professional soft pastels with Sunlight
          if (!isDark) ...[
            // Primary Sunlight (Top Right)
            _buildAnimatedGlow(
              color: const Color(0xFFFFF7ED).withValues(alpha: 0.7), // Warm Sunlight
              size: 1200,
              offset: const Offset(0.8, -0.8),
              animation: controller.animationController,
            ),
            // Secondary Sun Reflection
            _buildAnimatedGlow(
              color: const Color(0xFFFEF3C7).withValues(alpha: 0.4), // Amber Sun Light
              size: 800,
              offset: const Offset(0.4, -0.4),
              animation: controller.animationController,
              reverse: true,
            ),
            _buildAnimatedGlow(
              color: const Color(0xFFE0F2FE).withValues(alpha: 0.5), // Soft Sky Blue
              size: 1000,
              offset: const Offset(-0.5, -0.4),
              animation: controller.animationController,
            ),
            _buildAnimatedGlow(
              color: AppColors.gold.withValues(alpha: 0.05), 
              size: 600,
              offset: const Offset(-0.2, 0.6),
              animation: controller.animationController,
            ),
          ],

          // 3. Technical Grid Pattern
          Positioned.fill(
            child: CustomPaint(
              painter: TechnicalGridPainter(
                gridColor: isDark 
                    ? Colors.white.withValues(alpha: 0.015) 
                    : Colors.black.withValues(alpha: 0.01),
              ),
            ),
          ),

          // 4. Starfield (Dark Mode only)
          if (isDark)
            Positioned.fill(
              child: IgnorePointer(
                child: AnimatedBuilder(
                  animation: controller.animationController,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: StarfieldPainter(
                        progress: controller.animationController.value,
                      ),
                    );
                  },
                ),
              ),
            ),

          // 5. Floating Geometric Shapes (Very subtle)
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: controller.animationController,
                builder: (context, child) {
                  return CustomPaint(
                    painter: GeometricPainter(
                      progress: controller.animationController.value,
                      color: isDark ? Colors.white.withValues(alpha: 0.02) : Colors.black.withValues(alpha: 0.01),
                    ),
                  );
                },
              ),
            ),
          ),

          // 5. Interactive Mouse Tracker (Soft Halo)
          Obx(() => controller.mousePos.value == Offset.zero 
            ? const SizedBox.shrink()
            : Positioned(
              left: controller.mousePos.value.dx - 400,
              top: controller.mousePos.value.dy - 400,
              child: IgnorePointer(
                child: Container(
                  width: 800,
                  height: 800,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        isDark 
                            ? AppColors.gold.withValues(alpha: 0.025) 
                            : const Color(0xFFFDE68A).withValues(alpha: 0.1), // Warm Sunlight halo
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            )),

          // 6. Subtle Texture Overlay (Simplified to avoid network issues)
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                color: isDark ? Colors.white.withValues(alpha: 0.01) : Colors.black.withValues(alpha: 0.005),
              ),
            ),
          ),

          // 7. Vignette for Focus
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Colors.transparent,
                    isDark ? Colors.black.withValues(alpha: 0.3) : Colors.black.withValues(alpha: 0.03),
                  ],
                  stops: const [0.7, 1.0],
                ),
              ),
            ),
          ),
          
          // 8. Content
          child,
        ],
      ),
    );
  }

  Widget _buildAnimatedGlow({
    required Color color,
    required double size,
    required Offset offset,
    required Animation<double> animation,
    bool reverse = false,
  }) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final angle = reverse ? -animation.value * 2 * pi : animation.value * 2 * pi;
        final x = offset.dx + 0.1 * cos(angle);
        final y = offset.dy + 0.1 * sin(angle);

        return Align(
          alignment: Alignment(x, y),
          child: IgnorePointer(
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    color,
                    color.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class TechnicalGridPainter extends CustomPainter {
  final Color gridColor;
  TechnicalGridPainter({required this.gridColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = 0.5;

    const double spacing = 60.0;

    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class GeometricPainter extends CustomPainter {
  final double progress;
  final Color color;
  final List<_Shape> _shapes;

  GeometricPainter({required this.progress, required this.color})
      : _shapes = List.generate(15, (index) {
          final random = Random(index);
          return _Shape(
            pos: Offset(random.nextDouble(), random.nextDouble()),
            size: 20 + random.nextDouble() * 40,
            rotation: random.nextDouble() * 2 * pi,
            type: random.nextInt(3),
          );
        });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    for (var s in _shapes) {
      final x = s.pos.dx * size.width;
      final y = (s.pos.dy * size.height + (progress * 50)) % size.height;
      
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(s.rotation + progress * pi);
      
      if (s.type == 0) {
        canvas.drawRect(Rect.fromCenter(center: Offset.zero, width: s.size, height: s.size), paint);
      } else if (s.type == 1) {
        canvas.drawCircle(Offset.zero, s.size / 2, paint);
      } else {
        final path = Path()
          ..moveTo(0, -s.size / 2)
          ..lineTo(s.size / 2, s.size / 2)
          ..lineTo(-s.size / 2, s.size / 2)
          ..close();
        canvas.drawPath(path, paint);
      }
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class StarfieldPainter extends CustomPainter {
  final double progress;
  final List<_Star> _stars;

  StarfieldPainter({required this.progress})
      : _stars = List.generate(15, (index) {
          final random = Random(index);
          return _Star(
            pos: Offset(random.nextDouble(), random.nextDouble()),
            size: 0.5 + random.nextDouble() * 1.5,
            twinkleSpeed: 0.5 + random.nextDouble() * 2.0,
          );
        });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (var s in _stars) {
      final x = s.pos.dx * size.width;
      final y = s.pos.dy * size.height;
      
      // Calculate twinkling opacity
      final opacity = 0.1 + 0.6 * (0.5 + 0.5 * sin(progress * 2 * pi * s.twinkleSpeed));
      
      paint.color = Colors.white.withValues(alpha: opacity);
      canvas.drawCircle(Offset(x, y), s.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _Star {
  final Offset pos;
  final double size;
  final double twinkleSpeed;
  _Star({required this.pos, required this.size, required this.twinkleSpeed});
}

class _Shape {
  final Offset pos;
  final double size;
  final double rotation;
  final int type;
  _Shape({required this.pos, required this.size, required this.rotation, required this.type});
}
