import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';
import 'music_service.dart';

// Global playlists data with your custom songs
final Map<String, List<Map<String, String>>> globalPlaylists = {
  'Femanine': [
    {'title': 'Yad – Vannah Rainelle', 'url': ''},
    {'title': 'One of the Girls – The Weeknd', 'url': ''},
    {'title': 'Good for You – Selena Gomez', 'url': ''},
    {'title': 'Under the Influence – Chris Brown', 'url': ''},
    {'title': 'Renegade – Aryan Shah', 'url': ''},
    {'title': 'Family Affair – Mary J. Blige', 'url': ''},
    {'title': 'I Just Wanna Love Ya (feat. Cleo Kelley) – Sugar Blizz', 'url': ''},
    {'title': 'Another Life – Mimmi Bangoura', 'url': ''},
    {'title': 'What\'s My Name – Rihanna', 'url': ''},
    {'title': 'Older – Isabel LaRosa', 'url': ''},
    {'title': 'Collide – Justine Skye', 'url': ''},
    {'title': '7 Rings – Ariana Grande', 'url': ''},
    {'title': 'Gimme More – Britney Spears', 'url': ''},
    {'title': 'Step On Up – Ariana Grande', 'url': ''},
    {'title': 'Doin\' Time – Lana Del Rey', 'url': ''},
    {'title': 'Woman – Doja Cat', 'url': ''},
    {'title': 'Mantra – Jennie', 'url': ''},
    {'title': 'No – Meghan Trainor', 'url': ''},
    {'title': 'Ride or Die, Pt. 2 – Sevdaliza & Vanillia Antillano', 'url': ''},
    {'title': 'Rockstar – Lisa', 'url': ''},
    {'title': 'Diva – Beyoncé', 'url': ''},
    {'title': 'Jump – BLACKPINK', 'url': ''},
    {'title': 'Kill This Love – BLACKPINK', 'url': ''},
    {'title': 'Like Jennie – Jennie', 'url': ''},
    {'title': 'Gabriela – Katseye', 'url': ''},
    {'title': 'Bloodline – Ariana Grande', 'url': ''},
    {'title': 'Side to side – Ariana Grande & Nicki Minaj', 'url': ''},
  ],
  'K-pop': [
    {'title': 'Apt – Rosé', 'url': ''},
    {'title': 'Antifragile – LE SSERAFIM', 'url': ''},
    {'title': 'Shut Down – BLACKPINK', 'url': ''},
    {'title': 'Zoom – Jessi', 'url': ''},
    {'title': 'Boombayah – BLACKPINK', 'url': ''},
    {'title': 'What Is Love? – TWICE', 'url': ''},
    {'title': 'Money – Lisa', 'url': ''},
    {'title': 'Ddu-Du Ddu-Du – BLACKPINK', 'url': ''},
    {'title': 'Loser = Lover – TXT (Tomorrow X Together)', 'url': ''},
    {'title': 'As If It\'s Your Last – BLACKPINK', 'url': ''},
    {'title': 'Hype Boy – NewJeans', 'url': ''},
    {'title': 'Psycho – Red Velvet', 'url': ''},
    {'title': 'Whistle – BLACKPINK', 'url': ''},
    {'title': 'Playing With Fire – BLACKPINK', 'url': ''},
    {'title': 'Kiss and Make Up – Dua Lipa & BLACKPINK', 'url': ''},
    {'title': 'OMG – NewJeans', 'url': ''},
    {'title': 'Queencard – (G)I-DLE', 'url': ''},
    {'title': 'BIBI Vengeance – BIBI', 'url': ''},
    {'title': 'New Woman – Lisa & Rosalía', 'url': ''},
    {'title': 'Typa Girl – BLACKPINK', 'url': ''},
    {'title': 'Pretty Savage – BLACKPINK', 'url': ''},
    {'title': 'Ditto – NewJeans', 'url': ''},
    {'title': 'I AM – IVE', 'url': ''},
    {'title': 'Tomboy – (G)I-DLE', 'url': ''},
    {'title': 'After LIKE – IVE', 'url': ''},
  ],
  'Sad': [
    {'title': 'Line Without a Hook – Ricky Montgomery', 'url': ''},
    {'title': 'No One Noticed – (indie artist)', 'url': ''},
    {'title': 'Jhol – Maanu', 'url': ''},
    {'title': 'Afsos – Anuv Jain', 'url': ''},
    {'title': 'Paro – Aaditya Rikhari', 'url': ''},
    {'title': 'Jo Tum Mere Ho – Anuv Jain', 'url': ''},
    {'title': 'Summertime Sadness – Lana Del Rey', 'url': ''},
    {'title': 'Dandelions – Ruth B.', 'url': ''},
    {'title': 'Night Changes – One Direction', 'url': ''},
    {'title': 'Runaway – Aurora', 'url': ''},
    {'title': 'Without Me – Halsey', 'url': ''},
    {'title': 'Older – Sasha Alex Sloan', 'url': ''},
    {'title': 'Little Do You Know – Alex & Sierra', 'url': ''},
    {'title': 'Heartbreak Anniversary – Giveon', 'url': ''},
    {'title': 'Rewrite the Stars – Anne-Marie & James Arthur', 'url': ''},
    {'title': 'I Hate U, I Love U – gnash feat. Olivia O\'Brien', 'url': ''},
    {'title': 'Ocean Eyes – Billie Eilish', 'url': ''},
    {'title': 'You Broke Me First – Tate McRae', 'url': ''},
    {'title': 'Lose You to Love Me – Selena Gomez', 'url': ''},
    {'title': 'Treat You Better – Shawn Mendes', 'url': ''},
    {'title': 'A Thousand Years – Christina Perri', 'url': ''},
    {'title': 'Daylight – David Kushner', 'url': ''},
    {'title': 'Ranjha – Sachet–Parampara & Jasleen Royal', 'url': ''},
    {'title': 'Na Ja Tu – Dhvani Bhanushali', 'url': ''},
    {'title': 'Husn – Anuv Jain', 'url': ''},
  ],
  'Fresh Vibes': [
    {'title': 'That\'s So True – Gracie Abrams', 'url': ''},
    {'title': 'Dream – Lisa', 'url': ''},
    {'title': 'Never Be the Same – Camila Cabello', 'url': ''},
    {'title': 'Daylight – Taylor Swift', 'url': ''},
    {'title': 'Who Says – Selena Gomez & The Scene', 'url': ''},
    {'title': 'Pretty Girl – Maggie Lindemann', 'url': ''},
    {'title': 'Pretty\'s on the Inside – Chloe Adams', 'url': ''},
    {'title': 'Labour – Paris Paloma', 'url': ''},
    {'title': 'Blank Space – Taylor Swift', 'url': ''},
    {'title': 'Like My Father – Jax', 'url': ''},
    {'title': 'Lover – Taylor Swift', 'url': ''},
    {'title': 'Maria – Hwasa', 'url': ''},
    {'title': 'Love You Like a Love Song – Selena Gomez & The Scene', 'url': ''},
    {'title': 'Black Magic – Little Mix', 'url': ''},
    {'title': 'What Makes You Beautiful – One Direction', 'url': ''},
    {'title': 'Cardigan – Taylor Swift', 'url': ''},
    {'title': 'Blue – Yung Kai', 'url': ''},
    {'title': 'Finding Her – Tanishkaa Bahi', 'url': ''},
    {'title': 'Golden Hour – JVKE', 'url': ''},
    {'title': 'Scars to Your Beautiful – Alessia Cara', 'url': ''},
    {'title': 'Obsessed – Mariah Carey', 'url': ''},
    {'title': 'Long Way to Go – Cassie', 'url': ''},
    {'title': 'I Am the Best – 2NE1', 'url': ''},
    {'title': '10 Minutes – Lee Hyori', 'url': ''},
    {'title': 'Some – BOL4 (Bolbbalgan4)', 'url': ''},
  ],
  'Custom Playlist': [
    // Empty for now - user can add songs later
  ],
};

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

// Enhanced Song Row Widget with Audio Preview
class EnhancedSongRow extends StatefulWidget {
  final String title;
  final String url;
  final bool isSelected;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  const EnhancedSongRow({
    super.key,
    required this.title,
    required this.url,
    required this.isSelected,
    required this.isFavorite,
    required this.onTap,
    required this.onFavoriteToggle,
  });

  @override
  State<EnhancedSongRow> createState() => _EnhancedSongRowState();
}

class _EnhancedSongRowState extends State<EnhancedSongRow> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (mounted) {
        setState(() {
          _isPlaying = state == PlayerState.playing;
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _togglePlayPause() async {
    try {
      if (_isPlaying) {
        await _audioPlayer.pause();
      } else {
        setState(() {
          _isLoading = true;
        });
        
        // Use MusicService to get real audio URL
        final audioUrl = await MusicService.getSongAudioUrl(widget.title);
        
        if (audioUrl != null) {
          print('Playing real audio URL: $audioUrl');
          await _audioPlayer.play(UrlSource(audioUrl));
        } else {
          // Fallback to demo URL if API fails
          print('API failed, using fallback URL: ${widget.url}');
          await _audioPlayer.play(UrlSource(widget.url));
          
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Using demo audio - API unavailable',
                  style: GoogleFonts.pressStart2p(fontSize: 8),
                ),
                backgroundColor: const Color(0xFFFF9800),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isPlaying = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error playing audio: ${e.toString()}',
              style: GoogleFonts.pressStart2p(fontSize: 8),
            ),
            backgroundColor: const Color(0xFF831843),
          ),
        );
      }
    }
  }

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
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 12),
            // Play/Pause button
            GestureDetector(
              onTap: _togglePlayPause,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: _isPlaying 
                      ? const Color(0xFF10B981).withOpacity(0.1)
                      : const Color(0xFF6B46C1).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(
                    color: _isPlaying 
                        ? const Color(0xFF10B981)
                        : const Color(0xFF6B46C1),
                    width: 2,
                  ),
                ),
                child: _isLoading
                    ? SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            const Color(0xFF6B46C1),
                          ),
                        ),
                      )
                    : Icon(
                        _isPlaying ? Icons.pause : Icons.play_arrow,
                        size: 18,
                        color: _isPlaying 
                            ? const Color(0xFF10B981)
                            : const Color(0xFF6B46C1),
                      ),
              ),
            ),
            const SizedBox(width: 8),
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
  final favoritesManager = FavoritesManager();

  @override
  Widget build(BuildContext context) {
    final String? playlistName = ModalRoute.of(context)?.settings.arguments as String?;
    
    // Get songs from global playlists data
    List<Map<String, String>> songMaps = [];
    
    if (playlistName != null && globalPlaylists.containsKey(playlistName)) {
      songMaps = globalPlaylists[playlistName]!;
    } else if (playlistName == null) {
      // If no specific playlist, show a general mix from all playlists
      final allSongs = <Map<String, String>>[];
      globalPlaylists.values.forEach((playlist) {
        allSongs.addAll(playlist.take(5));
      });
      songMaps = allSongs.take(25).toList();
    }

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
                          '${songMaps.length} songs',
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
                      itemCount: songMaps.length,
                      itemBuilder: (context, index) {
                        final song = songMaps[index];
                        return EnhancedSongRow(
                          title: song['title']!,
                          url: song['url']!,
                          isSelected: selectedSongIndex == index,
                          isFavorite: favoritesManager.isFavorite(song['title']!),
                          onTap: () {
                            setState(() {
                              selectedSongIndex = selectedSongIndex == index ? null : index;
                            });
                          },
                          onFavoriteToggle: () {
                            setState(() {
                              if (favoritesManager.isFavorite(song['title']!)) {
                                favoritesManager.removeFavorite(song['title']!);
                              } else {
                                favoritesManager.addFavorite(song['title']!, song);
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
                        final selectedSong = songMaps[selectedSongIndex!];
                        Navigator.pushNamed(
                          context, 
                          '/player',
                          arguments: selectedSong,
                        );
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

// Enhanced Favorites Manager
class FavoritesManager {
  static final FavoritesManager _instance = FavoritesManager._internal();
  factory FavoritesManager() => _instance;
  FavoritesManager._internal();

  final Set<String> _favoriteSongTitles = {};
  final Map<String, Map<String, String>> _favoriteSongData = {};

  void addFavorite(String songTitle, [Map<String, String>? songData]) {
    _favoriteSongTitles.add(songTitle);
    if (songData != null) {
      _favoriteSongData[songTitle] = songData;
    } else {
      // Find the song data from global playlists
      for (final playlist in globalPlaylists.values) {
        for (final song in playlist) {
          if (song['title'] == songTitle) {
            _favoriteSongData[songTitle] = song;
            break;
          }
        }
      }
    }
  }

  void removeFavorite(String songTitle) {
    _favoriteSongTitles.remove(songTitle);
    _favoriteSongData.remove(songTitle);
  }

  bool isFavorite(String songTitle) {
    return _favoriteSongTitles.contains(songTitle);
  }

  List<String> get favoriteSongs => _favoriteSongTitles.toList();
  
  List<Map<String, String>> get favoriteSongData => 
      _favoriteSongTitles.map((title) => 
          _favoriteSongData[title] ?? {'title': title, 'url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3'}
      ).toList();
  
  Map<String, String>? getSongData(String title) {
    return _favoriteSongData[title];
  }
}

// Pixel Night Sky Background with Hearts
class PixelNightSkyBackground extends StatelessWidget {
  final Widget child;

  const PixelNightSkyBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1E1B4B), // Dark purple
            Color(0xFF3730A3), // Medium purple
            Color(0xFF6366F1), // Light purple
          ],
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              // Twinkling stars
              ...List.generate(20, (index) {
                return Positioned(
                  left: (index * 73.5) % constraints.maxWidth,
                  top: (index * 89.7) % constraints.maxHeight,
                  child: PixelStar(
                    size: 4.0 + (index % 3) * 2,
                    color: Colors.white.withOpacity(0.8 - (index % 4) * 0.15),
                  ),
                );
              }),
              // Floating hearts
              ...List.generate(10, (index) {
                return Positioned(
                  left: (index * 97.3) % constraints.maxWidth,
                  top: (index * 127.7) % constraints.maxHeight,
                  child: FloatingHeart(
                    size: 16.0 + (index % 2) * 8,
                    opacity: 0.4 + (index % 3) * 0.1,
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

// Floating Heart Widget
class FloatingHeart extends StatelessWidget {
  final double size;
  final double opacity;

  const FloatingHeart({super.key, required this.size, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.favorite,
      size: size,
      color: const Color(0xFFFDF2F8).withOpacity(opacity),
    );
  }
}

// Favorite Song Row Widget (simpler than SongRow)
class FavoriteSongRow extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const FavoriteSongRow({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected 
              ? const Color(0xFFFDF2F8).withOpacity(0.9)
              : Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: isSelected 
                ? const Color(0xFF831843)
                : const Color(0xFFFDF2F8),
            width: isSelected ? 3 : 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected 
                  ? const Color(0xFF831843).withOpacity(0.3)
                  : const Color(0xFFFDF2F8).withOpacity(0.2),
              offset: const Offset(2, 2),
              blurRadius: isSelected ? 4 : 2,
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
                color: const Color(0xFF831843).withOpacity(0.1),
                borderRadius: BorderRadius.circular(2),
                border: Border.all(
                  color: const Color(0xFF831843),
                  width: 1,
                ),
              ),
              child: const Icon(
                Icons.music_note,
                size: 16,
                color: Color(0xFF831843),
              ),
            ),
            const SizedBox(width: 12),
            // Song title
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.pressStart2p(
                  fontSize: 10,
                  color: const Color(0xFF374151),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Heart icon (always filled for favorites)
            Icon(
              Icons.favorite,
              size: 20,
              color: const Color(0xFF831843),
            ),
          ],
        ),
      ),
    );
  }
}

// Favourites Screen
class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  int? selectedSongIndex;
  final favoritesManager = FavoritesManager();

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> favoriteSongs = favoritesManager.favoriteSongData;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      extendBodyBehindAppBar: true,
      body: PixelNightSkyBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Header
                PixelContainer(
                  backgroundColor: Colors.white.withOpacity(0.9),
                  borderColor: const Color(0xFF831843),
                  child: Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        size: 24,
                        color: const Color(0xFF831843),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your Favorite Songs',
                              style: GoogleFonts.pressStart2p(
                                fontSize: 12,
                                color: const Color(0xFF831843),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${favoriteSongs.length} songs',
                              style: GoogleFonts.pressStart2p(
                                fontSize: 8,
                                color: const Color(0xFF374151),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                
                // Favorites list or empty state
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: const Color(0xFF831843),
                        width: 2,
                      ),
                    ),
                    child: favoriteSongs.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.favorite_border,
                                  size: 48,
                                  color: const Color(0xFF831843).withOpacity(0.5),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No favorite songs yet\n\nGo to Songs and tap the\nheart button to add favorites!',
                                  style: GoogleFonts.pressStart2p(
                                    fontSize: 10,
                                    color: const Color(0xFF831843).withOpacity(0.7),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: favoriteSongs.length,
                            itemBuilder: (context, index) {
                              final song = favoriteSongs[index];
                              return FavoriteSongRow(
                                title: song['title'] ?? 'Unknown Song',
                                isSelected: selectedSongIndex == index,
                                onTap: () {
                                  setState(() {
                                    selectedSongIndex = selectedSongIndex == index ? null : index;
                                  });
                                },
                              );
                            },
                          ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Play Music button
                BigActionButton(
                  text: 'Play Music',
                  enabled: selectedSongIndex != null && favoriteSongs.isNotEmpty,
                  backgroundColor: const Color(0xFFFDF2F8),
                  textColor: const Color(0xFF831843),
                  borderColor: const Color(0xFF831843),
                  onPressed: (selectedSongIndex != null && favoriteSongs.isNotEmpty) ? () {
                    Navigator.pushNamed(
                      context, 
                      '/player',
                      arguments: favoriteSongs[selectedSongIndex!],
                    );
                  } : null,
                ),
                
                const SizedBox(height: 16),
                
                // Navigation buttons
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
        ),
      ),
    );
  }
}

// Pixel Cassette Background with Animation
class PixelCassetteBackground extends StatefulWidget {
  final Widget child;

  const PixelCassetteBackground({super.key, required this.child});

  @override
  State<PixelCassetteBackground> createState() => _PixelCassetteBackgroundState();
}

class _PixelCassetteBackgroundState extends State<PixelCassetteBackground>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _floatingController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
    
    _floatingController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _floatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFDF2F8), // Light pink
            Color(0xFFE8D5FF), // Lavender
            Color(0xFFF0F9FF), // Light blue
          ],
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              // Floating cassette tapes
              ...List.generate(6, (index) {
                return AnimatedBuilder(
                  animation: _floatingController,
                  builder: (context, child) {
                    return Positioned(
                      left: (index * 127.5) % constraints.maxWidth,
                      top: (index * 89.7 + _floatingController.value * 20) % constraints.maxHeight,
                      child: Opacity(
                        opacity: 0.1 + (index % 3) * 0.05,
                        child: PixelCassette(
                          size: 40.0 + (index % 2) * 20,
                        ),
                      ),
                    );
                  },
                );
              }),
              // Rotating musical notes
              ...List.generate(8, (index) {
                return AnimatedBuilder(
                  animation: _rotationController,
                  builder: (context, child) {
                    return Positioned(
                      left: (index * 73.5) % constraints.maxWidth,
                      top: (index * 91.7) % constraints.maxHeight,
                      child: Transform.rotate(
                        angle: _rotationController.value * 2 * 3.14159,
                        child: PixelStar(
                          size: 8.0,
                          color: const Color(0xFF6B46C1).withOpacity(0.3),
                        ),
                      ),
                    );
                  },
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

// Pixel Cassette Widget
class PixelCassette extends StatelessWidget {
  final double size;

  const PixelCassette({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size * 0.6,
      decoration: BoxDecoration(
        color: const Color(0xFF374151).withOpacity(0.7),
        borderRadius: BorderRadius.circular(2),
        border: Border.all(
          color: const Color(0xFF1F2937),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Left reel
          Container(
            width: size * 0.2,
            height: size * 0.2,
            decoration: BoxDecoration(
              color: const Color(0xFF1F2937),
              borderRadius: BorderRadius.circular(size * 0.1),
            ),
          ),
          // Right reel
          Container(
            width: size * 0.2,
            height: size * 0.2,
            decoration: BoxDecoration(
              color: const Color(0xFF1F2937),
              borderRadius: BorderRadius.circular(size * 0.1),
            ),
          ),
        ],
      ),
    );
  }
}

// Pixel Progress Bar
class PixelProgressBar extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final String currentTime;
  final String totalTime;

  const PixelProgressBar({
    super.key,
    required this.progress,
    required this.currentTime,
    required this.totalTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Progress bar
        Container(
          height: 20,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(2),
            border: Border.all(
              color: const Color(0xFF6B46C1),
              width: 2,
            ),
          ),
          child: Stack(
            children: [
              // Progress fill
              AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                width: double.infinity * progress,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF6B46C1).withOpacity(0.7),
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Time labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              currentTime,
              style: GoogleFonts.pressStart2p(
                fontSize: 8,
                color: const Color(0xFF374151),
              ),
            ),
            Text(
              totalTime,
              style: GoogleFonts.pressStart2p(
                fontSize: 8,
                color: const Color(0xFF374151),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Player Control Button
class PlayerControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;
  final Color? backgroundColor;
  final bool isActive;

  const PlayerControlButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color,
    this.backgroundColor,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: backgroundColor ?? 
              (isActive 
                  ? const Color(0xFF6B46C1).withOpacity(0.2)
                  : Colors.white.withOpacity(0.8)),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: color ?? const Color(0xFF6B46C1),
            width: isActive ? 3 : 2,
          ),
          boxShadow: [
            BoxShadow(
              color: (color ?? const Color(0xFF6B46C1)).withOpacity(0.3),
              offset: const Offset(2, 2),
              blurRadius: isActive ? 4 : 2,
            ),
          ],
        ),
        child: Icon(
          icon,
          size: 24,
          color: color ?? const Color(0xFF6B46C1),
        ),
      ),
    );
  }
}

// Player Screen
class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  bool _isLoading = false;
  bool _isRepeat = false;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;
  Map<String, String>? _currentSong;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    
    // Listen to player state changes
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (mounted) {
        setState(() {
          _isPlaying = state == PlayerState.playing;
          _isLoading = state == PlayerState.stopped && _isLoading;
        });
      }
    });

    // Listen to position changes
    _audioPlayer.onPositionChanged.listen((Duration position) {
      if (mounted) {
        setState(() {
          _currentPosition = position;
        });
      }
    });

    // Listen to duration changes
    _audioPlayer.onDurationChanged.listen((Duration duration) {
      if (mounted) {
        setState(() {
          _totalDuration = duration;
        });
      }
    });

    // Listen to completion
    _audioPlayer.onPlayerComplete.listen((event) {
      if (mounted) {
        if (_isRepeat) {
          _playCurrentSong();
        } else {
          setState(() {
            _isPlaying = false;
            _currentPosition = Duration.zero;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  Future<void> _playCurrentSong() async {
    if (_currentSong != null) {
      try {
        setState(() {
          _isLoading = true;
        });
        
        // Try to get real audio URL from API
        final songTitle = _currentSong!['title'] ?? 'Unknown Song';
        final audioUrl = await MusicService.getSongAudioUrl(songTitle);
        
        String urlToPlay;
        if (audioUrl != null) {
          print('Playing real audio URL for "$songTitle": $audioUrl');
          urlToPlay = audioUrl;
        } else {
          print('API failed for "$songTitle", using fallback URL: ${_currentSong!['url']!}');
          urlToPlay = _currentSong!['url']!;
          
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Using demo audio - API unavailable',
                  style: GoogleFonts.pressStart2p(fontSize: 8),
                ),
                backgroundColor: const Color(0xFFFF9800),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        }
        
        await _audioPlayer.play(UrlSource(urlToPlay));
        if (_isRepeat) {
          await _audioPlayer.setReleaseMode(ReleaseMode.loop);
        } else {
          await _audioPlayer.setReleaseMode(ReleaseMode.release);
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Error playing audio: ${e.toString()}',
                style: GoogleFonts.pressStart2p(fontSize: 8),
              ),
              backgroundColor: const Color(0xFF831843),
            ),
          );
        }
      }
    }
  }

  Future<void> _pauseAudio() async {
    await _audioPlayer.pause();
  }

  Future<void> _stopAudio() async {
    await _audioPlayer.stop();
    setState(() {
      _currentPosition = Duration.zero;
    });
  }

  void _toggleRepeat() {
    setState(() {
      _isRepeat = !_isRepeat;
    });
    
    // Update release mode if currently playing
    if (_isPlaying) {
      if (_isRepeat) {
        _audioPlayer.setReleaseMode(ReleaseMode.loop);
      } else {
        _audioPlayer.setReleaseMode(ReleaseMode.release);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get song data from navigation arguments
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments is Map<String, String> && _currentSong == null) {
      _currentSong = arguments;
    } else if (arguments is String && _currentSong == null) {
      // Handle string argument (from favorites)
      _currentSong = {'title': arguments, 'url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3'};
    }

    final songTitle = _currentSong?['title'] ?? 'No Song Selected';
    final progress = _totalDuration.inMilliseconds > 0 
        ? _currentPosition.inMilliseconds / _totalDuration.inMilliseconds 
        : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Player'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: PixelCassetteBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Song title display
                PixelContainer(
                  backgroundColor: Colors.white.withOpacity(0.9),
                  borderColor: const Color(0xFF6B46C1),
                  child: Column(
                    children: [
                      Icon(
                        Icons.album,
                        size: 48,
                        color: const Color(0xFF6B46C1),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Now Playing',
                        style: GoogleFonts.pressStart2p(
                          fontSize: 10,
                          color: const Color(0xFF374151),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        songTitle,
                        style: GoogleFonts.pressStart2p(
                          fontSize: 14,
                          color: const Color(0xFF6B46C1),
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Progress bar
                PixelContainer(
                  backgroundColor: Colors.white.withOpacity(0.8),
                  borderColor: const Color(0xFF6B46C1),
                  child: PixelProgressBar(
                    progress: progress.clamp(0.0, 1.0),
                    currentTime: _formatDuration(_currentPosition),
                    totalTime: _formatDuration(_totalDuration),
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Playback controls
                PixelContainer(
                  backgroundColor: Colors.white.withOpacity(0.8),
                  borderColor: const Color(0xFF6B46C1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Stop button
                      PlayerControlButton(
                        icon: Icons.stop,
                        onPressed: _stopAudio,
                        color: const Color(0xFF831843),
                      ),
                      // Play/Pause button
                      _isLoading
                          ? Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: const Color(0xFF6B46C1),
                                  width: 2,
                                ),
                              ),
                              child: const Center(
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Color(0xFF6B46C1),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : PlayerControlButton(
                              icon: _isPlaying ? Icons.pause : Icons.play_arrow,
                              onPressed: _isPlaying ? _pauseAudio : _playCurrentSong,
                              backgroundColor: const Color(0xFF10B981).withOpacity(0.1),
                              color: const Color(0xFF10B981),
                              isActive: _isPlaying,
                            ),
                      // Repeat button
                      PlayerControlButton(
                        icon: Icons.repeat,
                        onPressed: _toggleRepeat,
                        color: _isRepeat ? const Color(0xFFEAB308) : const Color(0xFF6B46C1),
                        isActive: _isRepeat,
                      ),
                    ],
                  ),
                ),
                
                const Spacer(),
                
                // Navigation buttons
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
        ),
      ),
    );
  }
}
