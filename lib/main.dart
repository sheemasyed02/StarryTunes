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
                  child: Icon(
                    Icons.headset,
                    size: 120,
                    color: const Color(0xFF6B46C1),
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

// Pixel Music Background with Floating Notes
class PixelMusicBackground extends StatelessWidget {
  final Widget child;

  const PixelMusicBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFF0F9FF), // Light blue
            Color(0xFFE8D5FF), // Lavender
            Color(0xFFFDF2F8), // Pink
          ],
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              // Floating pixel music notes
              ...List.generate(12, (index) {
                return Positioned(
                  left: (index * 67.5) % constraints.maxWidth,
                  top: (index * 89.3) % constraints.maxHeight,
                  child: PixelMusicNote(
                    size: index % 3 == 0 ? 16.0 : 12.0,
                    rotation: (index * 30.0) % 360,
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

// Pixel Music Note Widget
class PixelMusicNote extends StatelessWidget {
  final double size;
  final double rotation;

  const PixelMusicNote({super.key, required this.size, required this.rotation});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation * 3.14159 / 180,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6B46C1).withOpacity(0.2),
              blurRadius: 2,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        child: Container(
          width: size * 0.6,
          height: size * 0.6,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(1),
          ),
        ),
      ),
    );
  }
}

// Playlist Card Widget
class PlaylistCard extends StatefulWidget {
  final String title;
  final String icon;
  final Color borderColor;
  final Color backgroundColor;
  final VoidCallback onTap;

  const PlaylistCard({
    super.key,
    required this.title,
    required this.icon,
    required this.borderColor,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  State<PlaylistCard> createState() => _PlaylistCardState();
}

class _PlaylistCardState extends State<PlaylistCard> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) => setState(() => isPressed = false),
      onTapCancel: () => setState(() => isPressed = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: widget.borderColor,
            width: isPressed ? 4 : 2,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.borderColor.withOpacity(0.3),
              offset: isPressed ? const Offset(2, 2) : const Offset(4, 4),
              blurRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            // Playlist icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: widget.borderColor,
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  widget.icon,
                  style: GoogleFonts.pressStart2p(
                    fontSize: 12,
                    color: widget.borderColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Playlist title
            Expanded(
              child: Text(
                widget.title,
                style: GoogleFonts.pressStart2p(
                  fontSize: 12,
                  color: const Color(0xFF374151),
                ),
              ),
            ),
            // Arrow indicator
            Icon(
              Icons.chevron_right,
              color: widget.borderColor,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}

// Playlists Screen
class PlaylistsScreen extends StatelessWidget {
  const PlaylistsScreen({super.key});

  // Playlist data with icons and colors
  final List<Map<String, dynamic>> playlists = const [
    {'title': 'Feminine', 'icon': '⟢', 'color': Color(0xFFFDF2F8), 'border': Color(0xFF831843)},
    {'title': 'Love', 'icon': '♡', 'color': Color(0xFFFDF2F8), 'border': Color(0xFF831843)},
    {'title': 'Pookie', 'icon': '𐙚', 'color': Color(0xFFE8D5FF), 'border': Color(0xFF6B46C1)},
    {'title': 'Kpop', 'icon': '˃̵ᴗ˂̵', 'color': Color(0xFFF0F9FF), 'border': Color(0xFF1E40AF)},
    {'title': 'BLACKPINK', 'icon': '❥', 'color': Color(0xFFFDF2F8), 'border': Color(0xFF831843)},
    {'title': 'Sad', 'icon': 'ꕀ', 'color': Color(0xFFE8D5FF), 'border': Color(0xFF6B46C1)},
    {'title': 'Mafia', 'icon': '⬙', 'color': Color(0xFFFEF7FF), 'border': Color(0xFF7C2D12)},
    {'title': 'Lana Del Rey', 'icon': '✿', 'color': Color(0xFFE8D5FF), 'border': Color(0xFF6B46C1)},
    {'title': 'Taylor Swift', 'icon': '⋆˚', 'color': Color(0xFFFDF2F8), 'border': Color(0xFF831843)},
    {'title': 'Okay Not To Be Okay', 'icon': '◐', 'color': Color(0xFFF0F9FF), 'border': Color(0xFF1E40AF)},
    {'title': 'Studious', 'icon': '﹢', 'color': Color(0xFFFEF7FF), 'border': Color(0xFF7C2D12)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Playlists'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: PixelMusicBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Header section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: PixelContainer(
                  backgroundColor: Colors.white.withOpacity(0.9),
                  borderColor: const Color(0xFF6B46C1),
                  child: Row(
                    children: [
                      Icon(
                        Icons.library_music,
                        size: 24,
                        color: const Color(0xFF6B46C1),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Your Music Collections',
                          style: GoogleFonts.pressStart2p(
                            fontSize: 12,
                            color: const Color(0xFF6B46C1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Scrollable playlist cards
              Expanded(
                child: ListView.builder(
                  itemCount: playlists.length,
                  itemBuilder: (context, index) {
                    final playlist = playlists[index];
                    return PlaylistCard(
                      title: playlist['title'],
                      icon: playlist['icon'],
                      backgroundColor: playlist['color'],
                      borderColor: playlist['border'],
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/songs',
                          arguments: playlist['title'],
                        );
                      },
                    );
                  },
                ),
              ),
              // Bottom navigation
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    PixelButton(
                      text: '← Home',
                      onPressed: () => Navigator.pop(context),
                    ),
                    PixelButton(
                      text: 'All Songs →',
                      backgroundColor: const Color(0xFFF0F9FF),
                      textColor: const Color(0xFF1E40AF),
                      onPressed: () => Navigator.pushNamed(context, '/songs'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Pixel Cloud Background with Stars
class PixelCloudBackground extends StatelessWidget {
  final Widget child;

  const PixelCloudBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF0F9FF), // Light blue
            Color(0xFFE8D5FF), // Lavender
            Color(0xFFFEF7FF), // Cream
          ],
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              // Pixel clouds
              ...List.generate(8, (index) {
                return Positioned(
                  left: (index * 89.5) % constraints.maxWidth,
                  top: (index * 123.7) % (constraints.maxHeight * 0.6),
                  child: PixelCloud(
                    size: 40.0 + (index % 3) * 20,
                    opacity: 0.3 + (index % 3) * 0.1,
                  ),
                );
              }),
              // Pixel stars
              ...List.generate(12, (index) {
                return Positioned(
                  left: (index * 67.3) % constraints.maxWidth,
                  top: (index * 91.7) % constraints.maxHeight,
                  child: PixelStar(
                    size: 6.0 + (index % 2) * 4,
                    color: Colors.white.withOpacity(0.6),
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

// Pixel Cloud Widget
class PixelCloud extends StatelessWidget {
  final double size;
  final double opacity;

  const PixelCloud({super.key, required this.size, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size * 0.6,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(opacity),
        borderRadius: BorderRadius.circular(size * 0.3),
      ),
    );
  }
}

// Song Row Widget
class SongRow extends StatefulWidget {
  final String title;
  final bool isSelected;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  const SongRow({
    super.key,
    required this.title,
    required this.isSelected,
    required this.isFavorite,
    required this.onTap,
    required this.onFavoriteToggle,
  });

  @override
  State<SongRow> createState() => _SongRowState();
}

class _SongRowState extends State<SongRow> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: widget.isSelected 
              ? const Color(0xFFE8D5FF).withOpacity(0.8)
              : Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: widget.isSelected 
                ? const Color(0xFF6B46C1)
                : const Color(0xFF93C5FD),
            width: widget.isSelected ? 3 : 2,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.isSelected 
                  ? const Color(0xFF6B46C1).withOpacity(0.3)
                  : const Color(0xFF93C5FD).withOpacity(0.2),
              offset: const Offset(2, 2),
              blurRadius: widget.isSelected ? 4 : 2,
            ),
          ],
        ),
        child: Row(
          children: [
            // Music note icon
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFF1E40AF).withOpacity(0.1),
                borderRadius: BorderRadius.circular(2),
                border: Border.all(
                  color: const Color(0xFF1E40AF),
                  width: 1,
                ),
              ),
              child: const Icon(
                Icons.music_note,
                size: 16,
                color: Color(0xFF1E40AF),
              ),
            ),
            const SizedBox(width: 12),
            // Song title
            Expanded(
              child: Text(
                widget.title,
                style: GoogleFonts.pressStart2p(
                  fontSize: 10,
                  color: const Color(0xFF374151),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Heart favorite button
            GestureDetector(
              onTap: widget.onFavoriteToggle,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: widget.isFavorite 
                      ? const Color(0xFF831843).withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(
                    color: const Color(0xFF831843),
                    width: 2,
                  ),
                ),
                child: Icon(
                  widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                  size: 16,
                  color: const Color(0xFF831843),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Big Action Button Widget
class BigActionButton extends StatelessWidget {
  final String text;
  final bool enabled;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;

  const BigActionButton({
    super.key,
    required this.text,
    required this.enabled,
    required this.onPressed,
    required this.backgroundColor,
    required this.textColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          boxShadow: enabled ? [
            BoxShadow(
              color: borderColor.withOpacity(0.4),
              offset: const Offset(4, 4),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ] : [],
        ),
        child: ElevatedButton(
          onPressed: enabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: enabled 
                ? backgroundColor 
                : backgroundColor.withOpacity(0.5),
            foregroundColor: enabled 
                ? textColor 
                : textColor.withOpacity(0.5),
            padding: const EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
              side: BorderSide(
                color: enabled 
                    ? borderColor 
                    : borderColor.withOpacity(0.5),
                width: 3,
              ),
            ),
            elevation: 0,
            disabledBackgroundColor: backgroundColor.withOpacity(0.3),
            disabledForegroundColor: textColor.withOpacity(0.3),
          ),
          child: Text(
            text,
            style: GoogleFonts.pressStart2p(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

// Songs Screen
class SongsScreen extends StatefulWidget {
  const SongsScreen({super.key});

  @override
  State<SongsScreen> createState() => _SongsScreenState();
}

class _SongsScreenState extends State<SongsScreen> {
  int? selectedSongIndex;
  Set<int> favoriteSongs = {};

  // Sample songs data based on playlist
  Map<String, List<String>> playlistSongs = {
    'Feminine': ['Girl Power', 'Strong Woman', 'Confidence', 'Independent', 'Fierce'],
    'Love': ['Heart Beats', 'Sweet Dreams', 'Forever Yours', 'True Love', 'Romantic Night'],
    'Pookie': ['Cute Vibes', 'Adorable You', 'Sweet Moments', 'Lovely Day', 'Cozy Time'],
    'Kpop': ['Dynamic Beat', 'Seoul Nights', 'K-Star', 'Harmony Wave', 'Pop Revolution'],
    'BLACKPINK': ['Pink Venom', 'How You Like That', 'Kill This Love', 'DDU-DU DDU-DU', 'Shut Down'],
    'Sad': ['Lonely Heart', 'Tears Fall', 'Blue Mood', 'Empty Room', 'Rainy Days'],
    'Mafia': ['Dark Streets', 'Underground', 'Silent Night', 'Power Play', 'Shadow Game'],
    'Lana Del Rey': ['Video Games', 'Born to Die', 'Summertime Sadness', 'Young and Beautiful', 'West Coast'],
    'Taylor Swift': ['Shake It Off', 'Love Story', 'Anti-Hero', 'Blank Space', 'You Belong With Me'],
    'Okay Not To Be Okay': ['Mental Health', 'Self Care', 'Its Okay', 'Healing Time', 'Better Days'],
    'Studious': ['Focus Mode', 'Study Beats', 'Concentration', 'Library Vibes', 'Brain Power'],
  };

  @override
  Widget build(BuildContext context) {
    final String? playlistName = ModalRoute.of(context)?.settings.arguments as String?;
    final List<String> songs = playlistName != null 
        ? (playlistSongs[playlistName] ?? ['Sample Song 1', 'Sample Song 2', 'Sample Song 3'])
        : ['All Songs', 'Mixed Playlist', 'Random Tracks', 'Featured Songs', 'Popular Hits'];

    return Scaffold(
      appBar: AppBar(
        title: Text(playlistName ?? 'All Songs'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: PixelCloudBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Header with playlist info
                if (playlistName != null) ...[
                  PixelContainer(
                    backgroundColor: Colors.white.withOpacity(0.9),
                    borderColor: const Color(0xFF1E40AF),
                    child: Row(
                      children: [
                        Icon(
                          Icons.music_note,
                          size: 24,
                          color: const Color(0xFF1E40AF),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Now Playing From:',
                                style: GoogleFonts.pressStart2p(
                                  fontSize: 8,
                                  color: const Color(0xFF374151),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                playlistName,
                                style: GoogleFonts.pressStart2p(
                                  fontSize: 12,
                                  color: const Color(0xFF1E40AF),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '${songs.length} songs',
                          style: GoogleFonts.pressStart2p(
                            fontSize: 8,
                            color: const Color(0xFF374151),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                
                // Songs list
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: const Color(0xFF93C5FD),
                        width: 2,
                      ),
                    ),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: songs.length,
                      itemBuilder: (context, index) {
                        return SongRow(
                          title: songs[index],
                          isSelected: selectedSongIndex == index,
                          isFavorite: favoriteSongs.contains(index),
                          onTap: () {
                            setState(() {
                              selectedSongIndex = selectedSongIndex == index ? null : index;
                            });
                          },
                          onFavoriteToggle: () {
                            setState(() {
                              if (favoriteSongs.contains(index)) {
                                favoriteSongs.remove(index);
                              } else {
                                favoriteSongs.add(index);
                              }
                            });
                          },
                        );
                      },
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Big action buttons
                Row(
                  children: [
                    BigActionButton(
                      text: 'Play Selected',
                      enabled: selectedSongIndex != null,
                      backgroundColor: const Color(0xFFE8D5FF),
                      textColor: const Color(0xFF6B46C1),
                      borderColor: const Color(0xFF6B46C1),
                      onPressed: selectedSongIndex != null ? () {
                        Navigator.pushNamed(context, '/player');
                      } : null,
                    ),
                    const SizedBox(width: 16),
                    BigActionButton(
                      text: 'Check Favourites',
                      enabled: true,
                      backgroundColor: const Color(0xFFFDF2F8),
                      textColor: const Color(0xFF831843),
                      borderColor: const Color(0xFF831843),
                      onPressed: () {
                        Navigator.pushNamed(context, '/favourites');
                      },
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Navigation buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    PixelButton(
                      text: '← Playlists',
                      backgroundColor: const Color(0xFFFDF2F8),
                      onPressed: () => Navigator.pushNamed(context, '/playlists'),
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
