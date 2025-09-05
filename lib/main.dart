import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const StarryTunesApp());
}

class StarryTunesApp extends StatelessWidget {
  const StarryTunesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StarryTunes',
      theme: ThemeData(
        // Pixel-style theme with pastel colors
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: const Color(0xFFF5F3FF), // Light lavender
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFFE8D5FF), // Pastel lavender
          elevation: 0,
          titleTextStyle: GoogleFonts.pressStart2p(
            color: const Color(0xFF6B46C1), // Deep purple
            fontSize: 16,
          ),
          iconTheme: const IconThemeData(
            color: Color(0xFF6B46C1),
          ),
        ),
        textTheme: TextTheme(
          displayLarge: GoogleFonts.pressStart2p(
            color: const Color(0xFF6B46C1),
            fontSize: 24,
          ),
          bodyLarge: GoogleFonts.pressStart2p(
            color: const Color(0xFF374151),
            fontSize: 12,
          ),
          bodyMedium: GoogleFonts.pressStart2p(
            color: const Color(0xFF374151),
            fontSize: 10,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFDF2F8), // Light pink
            foregroundColor: const Color(0xFF831843), // Deep pink
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4), // Blocky corners
              side: const BorderSide(
                color: Color(0xFF831843),
                width: 2,
              ),
            ),
            textStyle: GoogleFonts.pressStart2p(fontSize: 10),
            elevation: 0,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/playlists': (context) => const PlaylistsScreen(),
        '/songs': (context) => const SongsScreen(),
        '/favourites': (context) => const FavouritesScreen(),
        '/player': (context) => const PlayerScreen(),
      },
    );
  }
}

// Reusable pixel-style container
class PixelContainer extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;

  const PixelContainer({
    super.key,
    required this.child,
    this.backgroundColor,
    this.borderColor,
    this.width,
    this.height,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color(0xFFFEF7FF), // Light cream
        border: Border.all(
          color: borderColor ?? const Color(0xFF93C5FD), // Light blue
          width: 2,
        ),
        borderRadius: BorderRadius.circular(4), // Blocky pixel corners
      ),
      child: child,
    );
  }
}

// Reusable pixel-style navigation button
class PixelButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;

  const PixelButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? const Color(0xFFFDF2F8),
        foregroundColor: textColor ?? const Color(0xFF831843),
      ),
      child: Text(text),
    );
  }
}

// Pixel Sky Background with Stars
class PixelSkyBackground extends StatelessWidget {
  final Widget child;

  const PixelSkyBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFE8D5FF), // Lavender top
            Color(0xFFFDF2F8), // Pink bottom
          ],
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              // Pixel stars scattered across the background
              ...List.generate(15, (index) {
                return Positioned(
                  left: (index * 47.3) % constraints.maxWidth,
                  top: (index * 71.7) % constraints.maxHeight,
                  child: PixelStar(
                    size: index % 3 == 0 ? 12.0 : 8.0,
                    color: index % 2 == 0 
                        ? const Color(0xFFFFFFFF).withOpacity(0.7)
                        : const Color(0xFFFEF7FF).withOpacity(0.5),
                  ),
                );
              }),
              child,
            ],
          );
        },
      ),
    );
  }
}

// Pixel Star Widget
class PixelStar extends StatelessWidget {
  final double size;
  final Color color;

  const PixelStar({super.key, required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(1),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 2,
            offset: const Offset(1, 1),
          ),
        ],
      ),
    );
  }
}

// Enhanced Pixel Button for "Start Listening"
class StartListeningButton extends StatelessWidget {
  final VoidCallback onPressed;

  const StartListeningButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B46C1).withOpacity(0.3),
            offset: const Offset(4, 4),
            blurRadius: 0,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE8D5FF), // Lavender
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4), // Blocky corners
            side: const BorderSide(
              color: Color(0xFF6B46C1),
              width: 3,
            ),
          ),
          elevation: 0,
          textStyle: GoogleFonts.pressStart2p(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: const Text('Start Listening'),
      ),
    );
  }
}

// Home Screen
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StarryTunes'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: PixelSkyBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Large pixel-art headphone placeholder
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFF6B46C1),
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6B46C1).withOpacity(0.2),
                        offset: const Offset(4, 4),
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: const Text(
                    '🎧',
                    style: TextStyle(fontSize: 120),
                  ),
                ),
                const SizedBox(height: 40),
                
                // Welcome text
                PixelContainer(
                  backgroundColor: Colors.white.withOpacity(0.9),
                  borderColor: const Color(0xFF6B46C1),
                  child: Column(
                    children: [
                      Text(
                        'Welcome to StarryTunes!',
                        style: GoogleFonts.pressStart2p(
                          fontSize: 14,
                          color: const Color(0xFF6B46C1),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Your retro music experience',
                        style: GoogleFonts.pressStart2p(
                          fontSize: 10,
                          color: const Color(0xFF374151),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                
                // Start Listening button
                StartListeningButton(
                  onPressed: () => Navigator.pushNamed(context, '/playlists'),
                ),
                const SizedBox(height: 32),
                
                // Secondary navigation buttons in a more compact layout
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      child: PixelButton(
                        text: 'Songs',
                        backgroundColor: const Color(0xFFF0F9FF), // Light blue
                        textColor: const Color(0xFF1E40AF),
                        onPressed: () => Navigator.pushNamed(context, '/songs'),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: PixelButton(
                        text: 'Favs',
                        backgroundColor: const Color(0xFFFEF7FF), // Cream
                        textColor: const Color(0xFF7C2D12),
                        onPressed: () => Navigator.pushNamed(context, '/favourites'),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: PixelButton(
                        text: 'Player',
                        backgroundColor: const Color(0xFFE8D5FF), // Lavender
                        textColor: const Color(0xFF6B46C1),
                        onPressed: () => Navigator.pushNamed(context, '/player'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Playlists Screen
class PlaylistsScreen extends StatelessWidget {
  const PlaylistsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Playlists'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: PixelContainer(
                backgroundColor: const Color(0xFFFDF2F8), // Pink
                borderColor: const Color(0xFF831843),
                child: Center(
                  child: Text(
                    'Your playlists\nwill appear here',
                    style: GoogleFonts.pressStart2p(
                      fontSize: 12,
                      color: const Color(0xFF831843),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PixelButton(
                  text: '← Back',
                  onPressed: () => Navigator.pop(context),
                ),
                PixelButton(
                  text: 'Songs →',
                  backgroundColor: const Color(0xFFF0F9FF),
                  textColor: const Color(0xFF1E40AF),
                  onPressed: () => Navigator.pushNamed(context, '/songs'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Songs Screen
class SongsScreen extends StatelessWidget {
  const SongsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Songs'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: PixelContainer(
                backgroundColor: const Color(0xFFF0F9FF), // Light blue
                borderColor: const Color(0xFF1E40AF),
                child: Center(
                  child: Text(
                    'Your song library\nwill appear here',
                    style: GoogleFonts.pressStart2p(
                      fontSize: 12,
                      color: const Color(0xFF1E40AF),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PixelButton(
                  text: '← Playlists',
                  backgroundColor: const Color(0xFFFDF2F8),
                  onPressed: () => Navigator.pushNamed(context, '/playlists'),
                ),
                PixelButton(
                  text: 'Favourites →',
                  backgroundColor: const Color(0xFFFEF7FF),
                  textColor: const Color(0xFF7C2D12),
                  onPressed: () => Navigator.pushNamed(context, '/favourites'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Favourites Screen
class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: PixelContainer(
                backgroundColor: const Color(0xFFFEF7FF), // Cream
                borderColor: const Color(0xFF7C2D12),
                child: Center(
                  child: Text(
                    'Your favourite songs\nwill appear here',
                    style: GoogleFonts.pressStart2p(
                      fontSize: 12,
                      color: const Color(0xFF7C2D12),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PixelButton(
                  text: '← Songs',
                  backgroundColor: const Color(0xFFF0F9FF),
                  textColor: const Color(0xFF1E40AF),
                  onPressed: () => Navigator.pushNamed(context, '/songs'),
                ),
                PixelButton(
                  text: 'Player →',
                  backgroundColor: const Color(0xFFE8D5FF),
                  textColor: const Color(0xFF6B46C1),
                  onPressed: () => Navigator.pushNamed(context, '/player'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Player Screen
class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Player'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: PixelContainer(
                backgroundColor: const Color(0xFFE8D5FF), // Lavender
                borderColor: const Color(0xFF6B46C1),
                child: Center(
                  child: Text(
                    'Music player\ncontrols will\nappear here',
                    style: GoogleFonts.pressStart2p(
                      fontSize: 12,
                      color: const Color(0xFF6B46C1),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PixelButton(
                  text: '← Favourites',
                  backgroundColor: const Color(0xFFFEF7FF),
                  textColor: const Color(0xFF7C2D12),
                  onPressed: () => Navigator.pushNamed(context, '/favourites'),
                ),
                PixelButton(
                  text: 'Home',
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/',
                    (route) => false,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
