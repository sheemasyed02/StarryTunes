import 'package:flutter/material.dart';
import 'dart:math' as math;

// Main Pixel Art Background Factory
class PixelBackgrounds {
  // Home Screen: Starry Night Sky with Twinkling Stars
  static Widget starryNight({required Widget child}) {
    return PixelStarryNightBackground(child: child);
  }

  // Playlists Screen: Floating Music Notes and Instruments
  static Widget musicNotes({required Widget child}) {
    return PixelMusicNotesBackground(child: child);
  }

  // Songs Screen: Pixelated Clouds with Rainbow Drops
  static Widget cloudyRainbow({required Widget child}) {
    return PixelCloudyRainbowBackground(child: child);
  }

  // Player Screen: Retro Cassette Tape with Spinning Reels
  static Widget cassetteTape({required Widget child}) {
    return PixelCassetteTapeBackground(child: child);
  }

  // Favorites Screen: Heart Particles with Sparkles
  static Widget heartSparkles({required Widget child}) {
    return PixelHeartSparklesBackground(child: child);
  }
}

// 5. Pixel Heart Sparkles Background for Favorites Screen
class PixelHeartSparklesBackground extends StatefulWidget {
  final Widget child;

  const PixelHeartSparklesBackground({super.key, required this.child});

  @override
  State<PixelHeartSparklesBackground> createState() => _PixelHeartSparklesBackgroundState();
}

class _PixelHeartSparklesBackgroundState extends State<PixelHeartSparklesBackground>
    with TickerProviderStateMixin {
  late AnimationController _heartController;
  late AnimationController _sparkleController;

  @override
  void initState() {
    super.initState();
    _heartController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _sparkleController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _heartController.dispose();
    _sparkleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFDF2F8), // Light pink
            Color(0xFFFCE7F3), // Pink
            Color(0xFFF9A8D4), // Medium pink
            Color(0xFFF472B6), // Bright pink
          ],
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              // Floating Hearts
              ...List.generate(25, (index) {
                return AnimatedBuilder(
                  animation: _heartController,
                  builder: (context, child) {
                    final random = math.Random(index);
                    final x = random.nextDouble() * constraints.maxWidth;
                    final baseY = random.nextDouble() * constraints.maxHeight;
                    final heartBeat = 1.0 + 0.3 * math.sin(_heartController.value * 2 * math.pi + index);
                    
                    return Positioned(
                      left: x,
                      top: baseY,
                      child: Transform.scale(
                        scale: heartBeat,
                        child: Opacity(
                          opacity: 0.2 + (index % 4) * 0.1,
                          child: PixelHeart(
                            size: 16.0 + (index % 3) * 12,
                            color: [
                              const Color(0xFFEF4444),
                              const Color(0xFFEC4899),
                              const Color(0xFFF59E0B),
                              const Color(0xFF8B5CF6),
                            ][index % 4],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),

              // Sparkling Stars
              ...List.generate(50, (index) {
                return AnimatedBuilder(
                  animation: _sparkleController,
                  builder: (context, child) {
                    final random = math.Random(index + 100);
                    final x = random.nextDouble() * constraints.maxWidth;
                    final y = random.nextDouble() * constraints.maxHeight;
                    final sparklePhase = (index % 8) * 0.125;
                    final opacity = math.sin(_sparkleController.value * 2 * math.pi + sparklePhase);
                    
                    return Positioned(
                      left: x,
                      top: y,
                      child: Opacity(
                        opacity: (opacity * 0.5 + 0.5).clamp(0.0, 1.0),
                        child: PixelSparkle(
                          size: 4.0 + (index % 2) * 4,
                        ),
                      ),
                    );
                  },
                );
              }),

              // Love Letter Envelopes
              ...List.generate(6, (index) {
                return Positioned(
                  left: (index * 120.0) % constraints.maxWidth,
                  top: (index * 160.0) % constraints.maxHeight,
                  child: Opacity(
                    opacity: 0.1,
                    child: Transform.rotate(
                      angle: index * 0.3,
                      child: PixelLoveEnvelope(size: 50.0),
                    ),
                  ),
                );
              }),

              widget.child,
            ],
          );
        },
      ),
    );
  }
}

// Other background classes (simplified versions for now)
class PixelStarryNightBackground extends StatelessWidget {
  final Widget child;
  const PixelStarryNightBackground({super.key, required this.child});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1A1B3A),
            Color(0xFF2D1B69),
            Color(0xFF4C1D95),
            Color(0xFF6B46C1),
          ],
        ),
      ),
      child: child,
    );
  }
}

class PixelMusicNotesBackground extends StatelessWidget {
  final Widget child;
  const PixelMusicNotesBackground({super.key, required this.child});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFF0F9FF),
            Color(0xFFE8D5FF),
            Color(0xFFFDF2F8),
            Color(0xFFFEF7FF),
          ],
        ),
      ),
      child: child,
    );
  }
}

class PixelCloudyRainbowBackground extends StatelessWidget {
  final Widget child;
  const PixelCloudyRainbowBackground({super.key, required this.child});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF87CEEB),
            Color(0xFFB8E6FF),
            Color(0xFFE8F4FD),
            Color(0xFFF8FBFF),
          ],
        ),
      ),
      child: child,
    );
  }
}

class PixelCassetteTapeBackground extends StatelessWidget {
  final Widget child;
  const PixelCassetteTapeBackground({super.key, required this.child});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2D1B69),
            Color(0xFF4C1D95),
            Color(0xFF7C2D12),
            Color(0xFF92400E),
          ],
        ),
      ),
      child: child,
    );
  }
}

// Pixel Heart
class PixelHeart extends StatelessWidget {
  final double size;
  final Color color;

  const PixelHeart({super.key, required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(size * 0.2),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 2,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: const Icon(
        Icons.favorite,
        color: Colors.white,
      ),
    );
  }
}

// Pixel Sparkle
class PixelSparkle extends StatelessWidget {
  final double size;

  const PixelSparkle({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(1),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.5),
            blurRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
      ),
    );
  }
}

// Pixel Love Envelope
class PixelLoveEnvelope extends StatelessWidget {
  final double size;

  const PixelLoveEnvelope({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size * 0.7,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8DC),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: const Color(0xFFDDA0DD),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFDDA0DD).withOpacity(0.3),
            blurRadius: 2,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: const Center(
        child: Icon(
          Icons.mail,
          color: Color(0xFFFF69B4),
        ),
      ),
    );
  }
}