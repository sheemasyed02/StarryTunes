import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';

// Enhanced Music Player Service with actual audio playback
class MusicPlayerService {
  static final MusicPlayerService _instance = MusicPlayerService._internal();
  factory MusicPlayerService() => _instance;
  MusicPlayerService._internal() {
    _initializeAudioPlayer();
  }

  late AudioPlayer _audioPlayer;
  Map<String, String>? _currentSong;
  int _currentIndex = -1;
  bool _isPlaying = false;
  bool _isLoading = false;
  List<Map<String, String>> _currentPlaylist = [];
  
  // State change listeners
  final List<VoidCallback> _stateListeners = [];

  // Getters
  Map<String, String>? get currentSong => _currentSong;
  int get currentIndex => _currentIndex;
  bool get isPlaying => _isPlaying;
  bool get isLoading => _isLoading;
  List<Map<String, String>> get currentPlaylist => _currentPlaylist;

  // Add state listener
  void addStateListener(VoidCallback listener) {
    _stateListeners.add(listener);
  }

  // Remove state listener
  void removeStateListener(VoidCallback listener) {
    _stateListeners.remove(listener);
  }

  // Notify all listeners of state change
  void _notifyStateChange() {
    for (final listener in _stateListeners) {
      listener();
    }
  }

  void _initializeAudioPlayer() {
    _audioPlayer = AudioPlayer();
    
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      final wasPlaying = _isPlaying;
      _isPlaying = state == PlayerState.playing;
      _isLoading = state == PlayerState.paused && _isLoading; // Keep loading state until we know it's ready
      
      if (wasPlaying != _isPlaying) {
        _notifyStateChange();
      }
    });
  }

  // Set current song and start playing
  Future<void> setCurrentSong(Map<String, String> song, List<Map<String, String>> playlist, int index) async {
    _currentSong = song;
    _currentPlaylist = playlist;
    _currentIndex = index;
    _notifyStateChange();
    await _playSong();
  }

  // Play the current song
  Future<void> _playSong() async {
    if (_currentSong == null) return;
    
    try {
      _isLoading = true;
      _notifyStateChange();
      
      final assetUrl = _currentSong!['url'] ?? '';
      
      if (assetUrl.isNotEmpty) {
        if (assetUrl.startsWith('assets/')) {
          // Remove 'assets/' prefix for AssetSource
          final assetPath = assetUrl.substring(7);
          print('Playing asset: $assetPath');
          await _audioPlayer.play(AssetSource(assetPath));
        } else if (assetUrl.startsWith('http')) {
          print('Playing URL: $assetUrl');
          await _audioPlayer.play(UrlSource(assetUrl));
        } else {
          // Assume it's a direct asset path
          print('Playing direct asset: $assetUrl');
          await _audioPlayer.play(AssetSource(assetUrl));
        }
        _isPlaying = true;
      }
    } catch (e) {
      print('Error playing song: $e');
      _isPlaying = false;
    } finally {
      _isLoading = false;
      _notifyStateChange();
    }
  }

  // Toggle play/pause
  Future<void> togglePlayPause() async {
    if (_currentSong == null) return;
    
    try {
      if (_isPlaying) {
        await _audioPlayer.pause();
        _isPlaying = false;
      } else {
        await _audioPlayer.resume();
        _isPlaying = true;
      }
      _notifyStateChange();
    } catch (e) {
      print('Error toggling play/pause: $e');
    }
  }

  // Stop playback
  Future<void> stop() async {
    try {
      await _audioPlayer.stop();
      _isPlaying = false;
      _notifyStateChange();
    } catch (e) {
      print('Error stopping playback: $e');
    }
  }

  // Check if a specific song is currently playing
  bool isSongPlaying(Map<String, String> song, int index) {
    return _currentSong != null && 
           _currentSong!['title'] == song['title'] && 
           _currentIndex == index && 
           _isPlaying;
  }

  // Check if a song is the current song (playing or paused)
  bool isCurrentSong(Map<String, String> song, int index) {
    return _currentSong != null && 
           _currentSong!['title'] == song['title'] && 
           _currentIndex == index;
  }

  // Dispose audio player
  void dispose() {
    _audioPlayer.dispose();
  }
}

// Global playlists data with your custom songs
final Map<String, List<Map<String, String>>> globalPlaylists = {
  'Femanine': [
    {'title': 'Yad', 'url': 'assets/Femanine/Yad.mp3', 'artist': 'Vannah Rainelle'},
    {'title': 'One of the Girls', 'url': 'assets/Femanine/One of the girls.mp3', 'artist': 'The Weeknd'},
    {'title': 'Good for You', 'url': 'assets/Femanine/Good for you.mp3', 'artist': 'Selena Gomez'},
    {'title': 'Under the Influence', 'url': 'assets/Femanine/under the influence.mp3', 'artist': 'Chris Brown'},
    {'title': 'Renegade', 'url': 'assets/Femanine/Renegade.mp3', 'artist': 'Aryan Shah'},
    {'title': 'Family Affair', 'url': 'assets/Femanine/family affair.mp3', 'artist': 'Mary J. Blige'},
    {'title': 'I Just Wanna Love Ya (feat. Cleo Kelley)', 'url': 'assets/Femanine/i just wanna love.mp3', 'artist': 'Sugar Blizz'},
    {'title': 'Another Life', 'url': 'assets/Femanine/another life.mp3', 'artist': 'Mimmi Bangoura'},
    {'title': 'What\'s My Name', 'url': 'assets/Femanine/what my name.mp3', 'artist': 'Rihanna'},
    {'title': 'Older', 'url': 'assets/Femanine/older.mp3', 'artist': 'Isabel LaRosa'},
    {'title': 'Collide', 'url': 'assets/Femanine/collide.mp3', 'artist': 'Justine Skye'},
    {'title': '7 Rings', 'url': 'assets/Femanine/7 rings.mp3', 'artist': 'Ariana Grande'},
    {'title': 'Gimme More', 'url': 'assets/Femanine/gimme more.mp3', 'artist': 'Britney Spears'},
    {'title': 'Step On Up', 'url': 'assets/Femanine/step on up.mp3', 'artist': 'Ariana Grande'},
    {'title': 'Doin\' Time', 'url': 'assets/Femanine/doin time.mp3', 'artist': 'Lana Del Rey'},
    {'title': 'Woman', 'url': 'assets/Femanine/woman.mp3', 'artist': 'Doja Cat'},
    {'title': 'Mantra', 'url': 'assets/Femanine/mantra.mp3', 'artist': 'Jennie'},
    {'title': 'No', 'url': 'assets/Femanine/no.mp3', 'artist': 'Meghan Trainor'},
    {'title': 'Ride or Die, Pt. 2', 'url': 'assets/Femanine/ride or die.mp3', 'artist': 'Sevdaliza & Vanillia Antillano'},
    {'title': 'Rockstar', 'url': 'assets/Femanine/rockstar.mp3', 'artist': 'Lisa'},
    {'title': 'Diva', 'url': 'assets/Femanine/diva.mp3', 'artist': 'Beyoncé'},
    {'title': 'Jump', 'url': 'assets/Femanine/jump.mp3', 'artist': 'BLACKPINK'},
    {'title': 'Kill This Love', 'url': 'assets/Femanine/kill this love.mp3', 'artist': 'BLACKPINK'},
    {'title': 'Like Jennie', 'url': 'assets/Femanine/like jennie.mp3', 'artist': 'Jennie'},
    {'title': 'Gabriela', 'url': 'assets/Femanine/gabriela.mp3', 'artist': 'Katseye'},
    {'title': 'Bloodline', 'url': 'assets/Femanine/bloodline.mp3', 'artist': 'Ariana Grande'},
    {'title': 'Side to side', 'url': 'assets/Femanine/side to side.mp3', 'artist': 'Ariana Grande & Nicki Minaj'},
  ],
  'K-pop': [
    {'title': 'Apt', 'url': 'assets/Kpop/apt.mp3', 'artist': 'Rosé'},
    {'title': 'Antifragile', 'url': 'assets/Kpop/antifragile.mp3', 'artist': 'LE SSERAFIM'},
    {'title': 'Shut Down', 'url': 'assets/Kpop/shut down.mp3', 'artist': 'BLACKPINK'},
    {'title': 'Zoom', 'url': 'assets/Kpop/zoom.mp3', 'artist': 'Jessi'},
    {'title': 'Boombayah', 'url': 'assets/Kpop/boombayah.mp3', 'artist': 'BLACKPINK'},
    {'title': 'What Is Love?', 'url': 'assets/Kpop/what is love.mp3', 'artist': 'TWICE'},
    {'title': 'Money', 'url': 'assets/Kpop/money.mp3', 'artist': 'Lisa'},
    {'title': 'Ddu-Du Ddu-Du', 'url': 'assets/Kpop/ddu du ddu du.mp3', 'artist': 'BLACKPINK'},
    {'title': 'Loser = Lover', 'url': 'assets/Kpop/loser = lover.mp3', 'artist': 'TXT (Tomorrow X Together)'},
    {'title': 'As If It\'s Your Last', 'url': 'assets/Kpop/As if it\'s last.mp3', 'artist': 'BLACKPINK'},
    {'title': 'Hype Boy', 'url': 'assets/Kpop/Hype boy.mp3', 'artist': 'NewJeans'},
    {'title': 'Psycho', 'url': 'assets/Kpop/Psycho.mp3', 'artist': 'Red Velvet'},
    {'title': 'Whistle', 'url': 'assets/Kpop/Whistle.mp3', 'artist': 'BLACKPINK'},
    {'title': 'Playing With Fire', 'url': 'assets/Kpop/Playing with fire.mp3', 'artist': 'BLACKPINK'},
    {'title': 'Kiss and Make Up', 'url': 'assets/Kpop/Kiss and makeup.mp3', 'artist': 'Dua Lipa & BLACKPINK'},
    {'title': 'OMG', 'url': 'assets/Kpop/OMG.mp3', 'artist': 'NewJeans'},
    {'title': 'Queencard', 'url': 'assets/Kpop/QueenCard.mp3', 'artist': '(G)I-DLE'},
    {'title': 'BIBI Vengeance', 'url': 'assets/Kpop/Bibi Vegenance.mp3', 'artist': 'BIBI'},
    {'title': 'New Woman', 'url': 'assets/Kpop/New Women.mp3' , 'artist': 'Lisa & Rosalía'},
    {'title': 'Typa Girl', 'url': 'assets/Kpop/Typa girl.mp3', 'artist': 'BLACKPINK'},
    {'title': 'Pretty Savage', 'url': 'assets/Kpop/Pretty Savage.mp3', 'artist': 'BLACKPINK'},
    {'title': 'Ditto', 'url': 'assets/Kpop/Ditto.mp3', 'artist': 'NewJeans'},
    {'title': 'I AM', 'url': 'assets/Kpop/I am.mp3', 'artist': 'IVE'},
    {'title': 'Tomboy', 'url': 'assets/Kpop/Tomboy.mp3', 'artist': '(G)I-DLE'},
    {'title': 'After LIKE', 'url': 'assets/Kpop/After like.mp3', 'artist': 'IVE'},
  ],
  'Sad': [
    {'title': 'Line Without a Hook', 'url': 'assets/Sad/Line without a hook.mp3', 'artist': 'Ricky Montgomery'},
    {'title': 'No One Noticed', 'url': 'assets/Sad/No one noticed.mp3', 'artist': 'The Marias'},
    {'title': 'Jhol', 'url': 'assets/Sad/Jhol.mp3', 'artist': 'Maanu'},
    {'title': 'Afsos', 'url': 'assets/Sad/Afsos.mp3', 'artist': 'Anuv Jain'},
    {'title': 'Paaro', 'url': 'assets/Sad/Paaro.mp3', 'artist': 'Aaditya Rikhari'},
    {'title': 'Jo Tum Mere Ho', 'url': 'assets/Sad/jo tum mere ho.mp3', 'artist': 'Anuv Jain'},
    {'title': 'Summertime Sadness', 'url': 'assets/Sad/Summertime Sadness.mp3', 'artist': 'Lana Del Rey'},
    {'title': 'Dandelions', 'url': 'assets/Sad/Dandelions.mp3', 'artist': 'Ruth B.'},
    {'title': 'Night Changes', 'url': 'assets/Sad/Night changes.mp3', 'artist': 'One Direction'},
    {'title': 'Runaway', 'url': 'assets/Sad/Runaway.mp3', 'artist': 'Aurora'},
    {'title': 'Without Me', 'url': 'assets/Sad/Without me.mp3', 'artist': 'Halsey'},
    {'title': 'Older', 'url': 'assets/Sad/Older.mp3', 'artist': 'Sasha Alex Sloan'},
    {'title': 'Little Do You Know', 'url': 'assets/Sad/Little do you know.mp3', 'artist': 'Alex & Sierra'},
    {'title': 'Heartbreak Anniversary', 'url': 'assets/Sad/Heartbreak Anniversary.mp3', 'artist': 'Giveon'},
    {'title': 'Rewrite the Stars', 'url': 'assets/Sad/Rewrite the stars.mp3', 'artist': 'Anne-Marie & James Arthur'},
    {'title': 'I Hate U, I Love U', 'url': 'assets/Sad/I hate u i love you.mp3', 'artist': 'gnash feat. Olivia O\'Brien'},
    {'title': 'Ocean Eyes', 'url': 'assets/Sad/Ocean eyes.mp3', 'artist': 'Billie Eilish'},
    {'title': 'You Broke Me First', 'url': 'assets/Sad/you broke me first.mp3', 'artist': 'Tate McRae'},
    {'title': 'Lose You to Love Me', 'url': 'assets/Sad/lose you to love me.mp3', 'artist': 'Selena Gomez'},
    {'title': 'Treat You Better', 'url': 'assets/Sad/treat you better.mp3', 'artist': 'Shawn Mendes'},
    {'title': 'A Thousand Years', 'url': 'assets/Sad/A thousand years.mp3', 'artist': 'Christina Perri'},
    {'title': 'Daylight', 'url': 'assets/Sad/Daylight.mp3', 'artist': 'David Kushner'},
    {'title': 'Raanjhan', 'url': 'assets/Sad/Raanjhana.mp3', 'artist': 'Sachet – Parampara & Jasleen Royal'},
    {'title': 'Na Ja Tu', 'url': 'assets/Sad/Na ja tu.mp3', 'artist': 'Dhvani Bhanushali'},
    {'title': 'Husn', 'url': 'assets/Sad/Husn.mp3', 'artist': 'Anuv Jain'},
  ],
  'Fresh Vibes': [
    {'title': 'That\'s So True', 'url': 'assets/Fresh/That\'s so true.mp3', 'artist': 'Gracie Abrams'},
    {'title': 'Dream', 'url': 'assets/Fresh/Dream.mp3', 'artist': 'Lisa'},
    {'title': 'Never Be the Same', 'url': 'assets/Fresh/Never be the same.mp3', 'artist': 'Camila Cabello'},
    {'title': 'Daylight', 'url': 'assets/Fresh/Daylight.mp3', 'artist': 'Taylor Swift'},
    {'title': 'Who Says', 'url': 'assets/Fresh/Who says.mp3', 'artist': 'Selena Gomez & The Scene'},
    {'title': 'Pretty Girl', 'url': 'assets/Fresh/Pretty girl.mp3', 'artist': 'Maggie Lindemann'},
    {'title': 'Pretty\'s on the Inside', 'url': 'assets/Fresh/Pretty\'s on the inside.mp3', 'artist': 'Chloe Adams'},
    {'title': 'Labour', 'url': 'assets/Fresh/Labour.mp3', 'artist': 'Paris Paloma'},
    {'title': 'Blank Space', 'url': 'assets/Fresh/Blank Space.mp3', 'artist': 'Taylor Swift'},
    {'title': 'Like My Father', 'url': 'assets/Fresh/Like my father.mp3', 'artist': 'Jax'},
    {'title': 'Lover', 'url': 'assets/Fresh/Lover.mp3', 'artist': 'Taylor Swift'},
    {'title': 'Maria', 'url': 'assets/Fresh/Maria.mp3', 'artist': 'Hwasa'},
    {'title': 'Love You Like a Love Song', 'url': 'assets/Fresh/Love you like a love song.mp3', 'artist': 'Selena Gomez & The Scene'},
    {'title': 'Black Magic', 'url': 'assets/Fresh/Black magic.mp3', 'artist': 'Little Mix'},
    {'title': 'What Makes You Beautiful', 'url': 'assets/Fresh/What makes you beautiful.mp3', 'artist': 'One Direction'},
    {'title': 'Cardigan', 'url': 'assets/Fresh/Cardigan.mp3', 'artist': 'Taylor Swift'},
    {'title': 'Blue', 'url': 'assets/Fresh/Blue.mp3', 'artist': 'Yung Kai'},
    {'title': 'Finding Her', 'url': 'assets/Fresh/Finding her.mp3', 'artist': 'Tanishkaa Bahi'},
    {'title': 'Golden Hour', 'url': 'assets/Fresh/Golden hour.mp3', 'artist': 'JVKE'},
    {'title': 'Scars to Your Beautiful', 'url': 'assets/Fresh/Scars to your beautiful.mp3', 'artist': 'Alessia Cara'},
    {'title': 'Obsessed', 'url': 'assets/Fresh/Obsessed.mp3', 'artist': 'Mariah Carey'},
    {'title': 'Long Way to Go', 'url': 'assets/Fresh/Long way 2 go.mp3', 'artist': 'Cassie'},
    {'title': 'I Am the Best', 'url': 'assets/Fresh/I am the best.mp3', 'artist': '2NE1'},
    {'title': '10 Minutes', 'url': 'assets/Fresh/10 minutes.mp3', 'artist': 'Lee Hyori'},
    {'title': 'Some', 'url': 'assets/Fresh/some.mp3', 'artist': 'BOL4 (Bolbbalgan4)'},
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

// Reusable pixel-style container with responsive design
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final borderWidth = 3.0; // Fixed pixel-perfect border
    final defaultPadding = isSmallScreen ? 12.0 : 16.0;

    return Container(
      width: width,
      height: height,
      padding: padding ?? EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color(0xFFFEF7FF), // Light cream
        border: Border.all(
          color: borderColor ?? const Color(0xFF93C5FD), // Light blue
          width: borderWidth,
        ),
        borderRadius: BorderRadius.circular(0), // Sharp pixel corners
        boxShadow: [
          // Authentic pixel art shadow layers
          BoxShadow(
            color: (borderColor ?? const Color(0xFF93C5FD)).withOpacity(0.6),
            offset: const Offset(4, 4),
            blurRadius: 0, // No blur for pixel art
          ),
          BoxShadow(
            color: (borderColor ?? const Color(0xFF93C5FD)).withOpacity(0.3),
            offset: const Offset(2, 2),
            blurRadius: 0,
          ),
          BoxShadow(
            color: (borderColor ?? const Color(0xFF93C5FD)).withOpacity(0.1),
            offset: const Offset(1, 1),
            blurRadius: 0,
          ),
        ],
      ),
      child: child,
    );
  }
}

// Reusable pixel-style navigation button with responsive text
class PixelButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? fontSize;

  const PixelButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final isMediumScreen = screenWidth < 900;
    
    // Calculate responsive font size
    double responsiveFontSize = fontSize ?? (isSmallScreen ? 8 : isMediumScreen ? 10 : 12);
    
    return Container(
      width: width,
      height: height ?? (isSmallScreen ? 40 : 48),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0), // Sharp pixel corners
        boxShadow: [
          // Pixel art shadow layers
          BoxShadow(
            color: (textColor ?? const Color(0xFF831843)).withOpacity(0.8),
            offset: const Offset(3, 3),
            blurRadius: 0, // No blur for pixel art
            spreadRadius: 0,
          ),
          BoxShadow(
            color: (textColor ?? const Color(0xFF831843)).withOpacity(0.4),
            offset: const Offset(1, 1),
            blurRadius: 0,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? const Color(0xFFFDF2F8),
          foregroundColor: textColor ?? const Color(0xFF831843),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0), // Sharp pixel corners
            side: BorderSide(
              color: textColor ?? const Color(0xFF831843),
              width: 3, // Thicker pixel border
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 8 : 12,
            vertical: isSmallScreen ? 4 : 8,
          ),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            text,
            style: GoogleFonts.pressStart2p(
              fontSize: responsiveFontSize,
              color: textColor ?? const Color(0xFF831843),
              letterSpacing: 0.5, // Pixel art letter spacing
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final isMediumScreen = screenWidth < 900;
    
    // More compact width, taller height for pixel art aesthetic
    final buttonWidth = isSmallScreen ? 180.0 : isMediumScreen ? 200.0 : 220.0;
    final fontSize = isSmallScreen ? 8.0 : isMediumScreen ? 10.0 : 12.0;
    final horizontalPadding = isSmallScreen ? 16.0 : 20.0;
    final verticalPadding = isSmallScreen ? 20.0 : 24.0; // Increased height
    final borderWidth = 3.0; // Fixed pixel-perfect border
    
    return Center(
      child: Container(
        width: buttonWidth, // Fixed narrower width
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0), // Sharp pixel corners
          boxShadow: [
            // Pixel art shadow effect
            BoxShadow(
              color: const Color(0xFF4C1D95),
              offset: const Offset(4, 4),
              blurRadius: 0, // No blur for pixel art
              spreadRadius: 0,
            ),
            BoxShadow(
              color: const Color(0xFF6B46C1).withOpacity(0.3),
              offset: const Offset(2, 2),
              blurRadius: 0,
              spreadRadius: 0,
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE8D5FF), // Pixel lavender
            foregroundColor: const Color(0xFF6B46C1),
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding, 
              vertical: verticalPadding,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0), // Sharp pixel corners
              side: BorderSide(
                color: const Color(0xFF4C1D95), // Darker border for pixel effect
                width: borderWidth,
              ),
            ),
            elevation: 0,
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Start Listening ♪',
              style: GoogleFonts.pressStart2p(
                fontSize: fontSize,
                color: const Color(0xFF4C1D95), // Darker text for contrast
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0, // Pixel art spacing
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Home Screen
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final isMediumScreen = screenWidth < 900;
    final isTablet = screenWidth > 600 && screenWidth < 1200;
    
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'StarryTunes',
            style: GoogleFonts.pressStart2p(
              fontSize: isSmallScreen ? 14 : isMediumScreen ? 16 : 18,
              color: const Color(0xFF6B46C1),
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: PixelSkyBackground(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final availableHeight = constraints.maxHeight;
              final availableWidth = constraints.maxWidth;
              
              return SingleChildScrollView(
                padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: availableHeight - (isSmallScreen ? 24 : 32),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Responsive spacing
                      SizedBox(height: availableHeight * 0.02),
                      
                      // Large pixel-art headphone with responsive size
                      Container(
                        padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xFF6B46C1),
                            width: isSmallScreen ? 2 : 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF6B46C1).withOpacity(0.3),
                              offset: Offset(isSmallScreen ? 3 : 4, isSmallScreen ? 3 : 4),
                              blurRadius: 0,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.headset,
                          size: isSmallScreen ? 80 : isMediumScreen ? 100 : 120,
                          color: const Color(0xFF6B46C1),
                        ),
                      ),
                      
                      SizedBox(height: availableHeight * 0.05),
                      
                      // Welcome text with responsive sizing
                      PixelContainer(
                        backgroundColor: Colors.white.withOpacity(0.95),
                        borderColor: const Color(0xFF6B46C1),
                        child: Column(
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'Welcome to StarryTunes!',
                                style: GoogleFonts.pressStart2p(
                                  fontSize: isSmallScreen ? 12 : isMediumScreen ? 14 : 16,
                                  color: const Color(0xFF6B46C1),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: isSmallScreen ? 12 : 16),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'Your retro music experience',
                                style: GoogleFonts.pressStart2p(
                                  fontSize: isSmallScreen ? 8 : isMediumScreen ? 10 : 12,
                                  color: const Color(0xFF374151),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: availableHeight * 0.05),
                      
                      // Start Listening button with responsive sizing
                      Container(
                        width: isTablet ? availableWidth * 0.6 : null,
                        child: StartListeningButton(
                          onPressed: () => Navigator.pushNamed(context, '/playlists'),
                        ),
                      ),
                      
                      SizedBox(height: availableHeight * 0.04),
                      
                      // Navigation buttons with responsive grid
                      Container(
                        width: isTablet ? availableWidth * 0.8 : null,
                        child: _buildResponsiveNavigation(context, isSmallScreen, isMediumScreen, isTablet),
                      ),
                      
                      SizedBox(height: availableHeight * 0.02),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildResponsiveNavigation(BuildContext context, bool isSmallScreen, bool isMediumScreen, bool isTablet) {
    final buttonWidth = isSmallScreen ? 90.0 : isMediumScreen ? 110.0 : 130.0;
    final spacing = isSmallScreen ? 8.0 : 12.0;
    
    if (isTablet) {
      // For tablets, use a row layout
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          PixelButton(
            text: 'Songs',
            width: buttonWidth,
            backgroundColor: const Color(0xFFF0F9FF),
            textColor: const Color(0xFF1E40AF),
            onPressed: () => Navigator.pushNamed(context, '/songs'),
          ),
          PixelButton(
            text: 'Favs',
            width: buttonWidth,
            backgroundColor: const Color(0xFFFEF7FF),
            textColor: const Color(0xFF7C2D12),
            onPressed: () => Navigator.pushNamed(context, '/favourites'),
          ),
          PixelButton(
            text: 'Player',
            width: buttonWidth,
            backgroundColor: const Color(0xFFE8D5FF),
            textColor: const Color(0xFF6B46C1),
            onPressed: () => Navigator.pushNamed(context, '/player'),
          ),
        ],
      );
    } else {
      // For mobile, use wrap layout
      return Wrap(
        spacing: spacing,
        runSpacing: spacing,
        alignment: WrapAlignment.center,
        children: [
          PixelButton(
            text: 'Songs',
            width: buttonWidth,
            backgroundColor: const Color(0xFFF0F9FF),
            textColor: const Color(0xFF1E40AF),
            onPressed: () => Navigator.pushNamed(context, '/songs'),
          ),
          PixelButton(
            text: 'Favs',
            width: buttonWidth,
            backgroundColor: const Color(0xFFFEF7FF),
            textColor: const Color(0xFF7C2D12),
            onPressed: () => Navigator.pushNamed(context, '/favourites'),
          ),
          PixelButton(
            text: 'Player',
            width: buttonWidth,
            backgroundColor: const Color(0xFFE8D5FF),
            textColor: const Color(0xFF6B46C1),
            onPressed: () => Navigator.pushNamed(context, '/player'),
          ),
        ],
      );
    }
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final isMediumScreen = screenWidth < 900;
    
    return GestureDetector(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) => setState(() => isPressed = false),
      onTapCancel: () => setState(() => isPressed = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        margin: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 8 : 16, 
          vertical: isSmallScreen ? 4 : 8
        ),
        padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(0), // Sharp pixel corners
          border: Border.all(
            color: widget.borderColor,
            width: isPressed ? 4 : 3, // Thicker pixel borders
          ),
          boxShadow: [
            // Pixel art shadow layers
            BoxShadow(
              color: widget.borderColor.withOpacity(0.6),
              offset: isPressed ? 
                const Offset(2, 2) : 
                const Offset(4, 4),
              blurRadius: 0, // No blur for pixel art
            ),
            BoxShadow(
              color: widget.borderColor.withOpacity(0.3),
              offset: isPressed ? 
                const Offset(1, 1) : 
                const Offset(2, 2),
              blurRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            // Playlist icon with responsive sizing
            Container(
              width: isSmallScreen ? 32 : isMediumScreen ? 36 : 40,
              height: isSmallScreen ? 32 : isMediumScreen ? 36 : 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(0), // Sharp pixel corners
                border: Border.all(
                  color: widget.borderColor,
                  width: 3, // Thicker pixel border
                ),
                boxShadow: [
                  // Pixel art shadow layers
                  BoxShadow(
                    color: widget.borderColor.withOpacity(0.6),
                    offset: const Offset(3, 3),
                    blurRadius: 0, // No blur for pixel art
                  ),
                  BoxShadow(
                    color: widget.borderColor.withOpacity(0.3),
                    offset: const Offset(1, 1),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    widget.icon,
                    style: GoogleFonts.pressStart2p(
                      fontSize: isSmallScreen ? 8 : isMediumScreen ? 10 : 12,
                      color: widget.borderColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5, // Pixel art spacing
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: isSmallScreen ? 12 : 16),
            // Playlist title with responsive text
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.title,
                  style: GoogleFonts.pressStart2p(
                    fontSize: isSmallScreen ? 10 : isMediumScreen ? 12 : 14,
                    color: widget.borderColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5, // Pixel art spacing
                  ),
                ),
              ),
            ),
            // Arrow indicator with pixel styling
            Container(
              width: isSmallScreen ? 20 : 24,
              height: isSmallScreen ? 20 : 24,
              decoration: BoxDecoration(
                color: widget.borderColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(0), // Sharp corners
                border: Border.all(
                  color: widget.borderColor,
                  width: 2,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: isSmallScreen ? 10 : 12,
                  color: widget.borderColor,
                ),
              ),
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final isMediumScreen = screenWidth < 900;
    final isTablet = screenWidth > 600 && screenWidth < 1200;
    
    // Generate playlist display data from globalPlaylists
    final List<Map<String, dynamic>> playlists = [
      {'title': 'Femanine', 'icon': '⟢', 'color': const Color(0xFFFDF2F8), 'border': const Color(0xFF831843)},
      {'title': 'K-pop', 'icon': '˃̵ᴗ˂̵', 'color': const Color(0xFFF0F9FF), 'border': const Color(0xFF1E40AF)},
      {'title': 'Sad', 'icon': 'ꕀ', 'color': const Color(0xFFE8D5FF), 'border': const Color(0xFF6B46C1)},
      {'title': 'Fresh Vibes', 'icon': '✧', 'color': const Color(0xFFF0FDF4), 'border': const Color(0xFF059669)},
      {'title': 'Custom Playlist', 'icon': '♪', 'color': const Color(0xFFFEF7FF), 'border': const Color(0xFF7C2D12)},
    ];
    
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Playlists',
            style: GoogleFonts.pressStart2p(
              fontSize: isSmallScreen ? 14 : isMediumScreen ? 16 : 18,
              color: const Color(0xFF6B46C1),
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF6B46C1)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: PixelMusicBackground(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  // Header section with responsive padding
                  Padding(
                    padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
                    child: PixelContainer(
                      backgroundColor: Colors.white.withOpacity(0.95),
                      borderColor: const Color(0xFF6B46C1),
                      child: Row(
                        children: [
                          Icon(
                            Icons.library_music,
                            size: isSmallScreen ? 20 : 24,
                            color: const Color(0xFF6B46C1),
                          ),
                          SizedBox(width: isSmallScreen ? 8 : 12),
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Your Music Collections',
                                style: GoogleFonts.pressStart2p(
                                  fontSize: isSmallScreen ? 10 : isMediumScreen ? 12 : 14,
                                  color: const Color(0xFF6B46C1),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Scrollable playlist cards with responsive layout
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 8.0 : 16.0),
                      child: isTablet ? 
                        GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 1.5,
                          ),
                          itemCount: playlists.length,
                          itemBuilder: (context, index) {
                            final playlist = playlists[index];
                            return PlaylistCard(
                              title: playlist['title'],
                              icon: playlist['icon'],
                              backgroundColor: playlist['color'],
                              borderColor: playlist['border'],
                              onTap: () => Navigator.pushNamed(context, '/songs', arguments: playlist['title']),
                            );
                          },
                        ) :
                        ListView.builder(
                          itemCount: playlists.length,
                          itemBuilder: (context, index) {
                            final playlist = playlists[index];
                            return Padding(
                              padding: EdgeInsets.only(bottom: isSmallScreen ? 8.0 : 12.0),
                              child: PlaylistCard(
                                title: playlist['title'],
                                icon: playlist['icon'],
                                backgroundColor: playlist['color'],
                                borderColor: playlist['border'],
                                onTap: () => Navigator.pushNamed(context, '/songs', arguments: playlist['title']),
                              ),
                            );
                          },
                        ),
                    ),
                  ),
                  // Bottom navigation with responsive sizing
                  Padding(
                    padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: PixelButton(
                            text: '← Home',
                            backgroundColor: const Color(0xFFF0F9FF),
                            textColor: const Color(0xFF1E40AF),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        SizedBox(width: isSmallScreen ? 8 : 12),
                        Expanded(
                          child: PixelButton(
                            text: 'All Songs →',
                            backgroundColor: const Color(0xFFFDF2F8),
                            textColor: const Color(0xFF831843),
                            onPressed: () => Navigator.pushNamed(context, '/songs'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
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
        
        // Use the asset URL directly from the playlist data
        final assetUrl = widget.url;
        
        if (assetUrl.isNotEmpty && assetUrl.startsWith('assets/')) {
          print('Playing local asset: $assetUrl');
          await _audioPlayer.play(AssetSource(assetUrl.replaceFirst('assets/', '')));
        } else {
          print('No valid asset URL found, using fallback: $assetUrl');
          await _audioPlayer.play(UrlSource(assetUrl));
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
  late MusicPlayerService _musicService;

  @override
  void initState() {
    super.initState();
    _musicService = MusicPlayerService();
    _musicService.addStateListener(_onMusicStateChanged);
  }

  @override
  void dispose() {
    _musicService.removeStateListener(_onMusicStateChanged);
    super.dispose();
  }

  void _onMusicStateChanged() {
    if (mounted) {
      setState(() {
        // This will trigger a rebuild to update the UI with the new music state
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final String? playlistName = ModalRoute.of(context)?.settings.arguments as String?;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final isMediumScreen = screenWidth < 900;
    final isTablet = screenWidth > 600 && screenWidth < 1200;
    
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
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            playlistName ?? 'All Songs',
            style: GoogleFonts.pressStart2p(
              fontSize: isSmallScreen ? 14 : isMediumScreen ? 16 : 18,
              color: const Color(0xFF1E40AF),
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E40AF)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: PixelCloudBackground(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
                child: Column(
                  children: [
                    // Header with playlist info - responsive
                    if (playlistName != null) ...[
                      PixelContainer(
                        backgroundColor: Colors.white.withOpacity(0.95),
                        borderColor: const Color(0xFF1E40AF),
                        child: Row(
                          children: [
                            Icon(
                              Icons.music_note,
                              size: isSmallScreen ? 20 : 24,
                              color: const Color(0xFF1E40AF),
                            ),
                            SizedBox(width: isSmallScreen ? 8 : 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                    playlistName,
                                      style: GoogleFonts.pressStart2p(
                                        fontSize: isSmallScreen ? 10 : isMediumScreen ? 12 : 14,
                                        color: const Color(0xFF1E40AF),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: isSmallScreen ? 2 : 4),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '${songMaps.length} songs',
                                      style: GoogleFonts.pressStart2p(
                                        fontSize: isSmallScreen ? 6 : isMediumScreen ? 8 : 10,
                                        color: const Color(0xFF1E40AF).withOpacity(0.7),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: isSmallScreen ? 12 : 16),
                    ],
                    // Songs list with responsive layout
                    Expanded(
                      child: isTablet ?
                        GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 8,
                            childAspectRatio: 4.5,
                          ),
                          itemCount: songMaps.length,
                          itemBuilder: (context, index) => _buildSongCard(songMaps[index], index, isSmallScreen, isMediumScreen),
                        ) :
                        ListView.builder(
                          itemCount: songMaps.length,
                          itemBuilder: (context, index) => _buildSongCard(songMaps[index], index, isSmallScreen, isMediumScreen),
                        ),
                    ),
                    // Bottom controls with responsive sizing
                    SizedBox(height: isSmallScreen ? 12 : 16),
                    Row(
                      children: [
                        Expanded(
                          child: PixelButton(
                            text: '← Back',
                            backgroundColor: const Color(0xFFF0F9FF),
                            textColor: const Color(0xFF1E40AF),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        SizedBox(width: isSmallScreen ? 8 : 12),
                        Expanded(
                          child: PixelButton(
                            text: 'Favorites ♥',
                            backgroundColor: const Color(0xFFFDF2F8),
                            textColor: const Color(0xFF831843),
                            onPressed: () => Navigator.pushNamed(context, '/favourites'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSongCard(Map<String, String> song, int index, bool isSmallScreen, bool isMediumScreen) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSongIndex = selectedSongIndex == index ? null : index;
        });
      },
      onDoubleTap: () {
        Navigator.pushNamed(
          context,
          '/player',
          arguments: {
            'song': song,
            'playlist': globalPlaylists.values.first,
            'index': index,
          },
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: isSmallScreen ? 6 : 8),
        padding: EdgeInsets.all(isSmallScreen ? 10 : 12),
        decoration: BoxDecoration(
          color: selectedSongIndex == index 
              ? const Color(0xFF93C5FD).withOpacity(0.3)
              : Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(0), // Sharp pixel corners
          border: Border.all(
            color: selectedSongIndex == index 
                ? const Color(0xFF1E40AF)
                : const Color(0xFF93C5FD),
            width: selectedSongIndex == index ? 4 : 3, // Thicker pixel borders
          ),
          boxShadow: [
            // Pixel art shadow layers
            BoxShadow(
              color: (selectedSongIndex == index 
                  ? const Color(0xFF1E40AF)
                  : const Color(0xFF93C5FD)).withOpacity(0.4),
              offset: const Offset(3, 3),
              blurRadius: 0, // No blur for pixel art
            ),
            BoxShadow(
              color: (selectedSongIndex == index 
                  ? const Color(0xFF1E40AF)
                  : const Color(0xFF93C5FD)).withOpacity(0.2),
              offset: const Offset(1, 1),
              blurRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            // Song number with responsive sizing
            Container(
              width: isSmallScreen ? 24 : 28,
              height: isSmallScreen ? 24 : 28,
              decoration: BoxDecoration(
                color: const Color(0xFF1E40AF).withOpacity(0.1),
                borderRadius: BorderRadius.circular(0), // Pixel art sharp corners
                border: Border.all(
                  color: const Color(0xFF1E40AF),
                  width: 2, // Thicker pixel border
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1E40AF).withOpacity(0.3),
                    offset: const Offset(2, 2),
                    blurRadius: 0, // No blur for pixel art
                  ),
                ],
              ),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    '${index + 1}',
                    style: GoogleFonts.pressStart2p(
                      fontSize: isSmallScreen ? 6 : isMediumScreen ? 8 : 10,
                      color: const Color(0xFF1E40AF),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: isSmallScreen ? 10 : 12),
            // Song info with responsive text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      song['title'] ?? 'Unknown Title',
                      style: GoogleFonts.pressStart2p(
                        fontSize: isSmallScreen ? 8 : isMediumScreen ? 10 : 12,
                        color: const Color(0xFF1E40AF),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5, // Pixel art letter spacing
                      ),
                    ),
                  ),
                  SizedBox(height: 2),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      song['artist'] ?? 'Unknown Artist',
                      style: GoogleFonts.pressStart2p(
                        fontSize: isSmallScreen ? 6 : isMediumScreen ? 7 : 8,
                        color: const Color(0xFF6B7280),
                        letterSpacing: 0.3, // Pixel art letter spacing
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Play/Pause button with pixel styling (moved to right side)
            GestureDetector(
              onTap: () async {
                final musicService = MusicPlayerService();
                
                if (musicService.isCurrentSong(song, index)) {
                  // If this is the current song, toggle play/pause
                  await musicService.togglePlayPause();
                } else {
                  // Set this as the current song and start playing
                  final String? playlistName = ModalRoute.of(context)?.settings.arguments as String?;
                  List<Map<String, String>> playlist;
                  
                  if (playlistName != null && globalPlaylists.containsKey(playlistName)) {
                    playlist = globalPlaylists[playlistName]!;
                  } else {
                    // Get all songs from all playlists as fallback
                    playlist = [];
                    globalPlaylists.values.forEach((pl) => playlist.addAll(pl));
                  }
                  
                  await musicService.setCurrentSong(song, playlist, index);
                }
                
                setState(() {
                  // Update the selected song for UI
                  selectedSongIndex = musicService.isCurrentSong(song, index) && musicService.isPlaying ? index : null;
                });
                
                // Show playback status with option to go to player
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        Icon(
                          musicService.isPlaying ? Icons.play_arrow : Icons.pause, 
                          color: Colors.white, 
                          size: 16
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            musicService.isPlaying 
                                ? 'Playing: ${song['title']}' 
                                : 'Paused: ${song['title']}',
                            style: GoogleFonts.pressStart2p(fontSize: 8, color: Colors.white),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            Navigator.pushNamed(
                              context,
                              '/player',
                              arguments: {
                                'song': musicService.currentSong ?? song,
                                'playlist': musicService.currentPlaylist.isNotEmpty 
                                    ? musicService.currentPlaylist 
                                    : globalPlaylists.values.first.toList(),
                                'index': musicService.currentIndex >= 0 ? musicService.currentIndex : index,
                                'isPlaying': musicService.isPlaying,
                              },
                            );
                          },
                          child: Text(
                            'Player →',
                            style: GoogleFonts.pressStart2p(fontSize: 6, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    backgroundColor: const Color(0xFF6B46C1),
                    duration: const Duration(seconds: 3),
                  ),
                );
              },
              child: Container(
                width: isSmallScreen ? 32 : 36,
                height: isSmallScreen ? 32 : 36,
                decoration: BoxDecoration(
                  color: MusicPlayerService().isSongPlaying(song, index)
                      ? const Color(0xFF059669) // Green when playing
                      : MusicPlayerService().isCurrentSong(song, index)
                          ? const Color(0xFFF59E0B) // Orange when paused but current
                          : const Color(0xFF6B46C1), // Purple when not current
                  borderRadius: BorderRadius.circular(0), // Sharp pixel corners
                  border: Border.all(
                    color: MusicPlayerService().isSongPlaying(song, index)
                        ? const Color(0xFF065F46)
                        : MusicPlayerService().isCurrentSong(song, index)
                            ? const Color(0xFFD97706)
                            : const Color(0xFF4C1D95),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: (MusicPlayerService().isSongPlaying(song, index)
                          ? const Color(0xFF065F46)
                          : MusicPlayerService().isCurrentSong(song, index)
                              ? const Color(0xFFD97706)
                              : const Color(0xFF4C1D95)).withOpacity(0.4),
                      offset: const Offset(2, 2),
                      blurRadius: 0,
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    MusicPlayerService().isSongPlaying(song, index) 
                        ? Icons.pause 
                        : Icons.play_arrow,
                    color: Colors.white,
                    size: isSmallScreen ? 14 : 16,
                  ),
                ),
              ),
            ),
            SizedBox(width: isSmallScreen ? 8 : 10),
            // Favorite button with responsive sizing
            GestureDetector(
              onTap: () {
                setState(() {
                  if (favoritesManager.isFavorite(song['title'] ?? '')) {
                    favoritesManager.removeFavorite(song['title'] ?? '');
                  } else {
                    favoritesManager.addFavorite(song['title'] ?? '', song);
                  }
                });
              },
              child: Container(
                width: isSmallScreen ? 32 : 36,
                height: isSmallScreen ? 32 : 36,
                decoration: BoxDecoration(
                  color: favoritesManager.isFavorite(song['title'] ?? '') 
                      ? const Color(0xFFFDF2F8) 
                      : const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(0), // Sharp pixel corners
                  border: Border.all(
                    color: favoritesManager.isFavorite(song['title'] ?? '') 
                        ? const Color(0xFF831843) 
                        : const Color(0xFF6B7280),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: (favoritesManager.isFavorite(song['title'] ?? '') 
                          ? const Color(0xFF831843) 
                          : const Color(0xFF6B7280)).withOpacity(0.3),
                      offset: const Offset(2, 2),
                      blurRadius: 0, // No blur for pixel art
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    favoritesManager.isFavorite(song['title'] ?? '') ? Icons.favorite : Icons.favorite_border,
                    color: favoritesManager.isFavorite(song['title'] ?? '') ? const Color(0xFF831843) : const Color(0xFF6B7280),
                    size: isSmallScreen ? 14 : 16,
                  ),
                ),
              ),
            ),
          ],
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
        title: Text(
          'Favourites',
          style: GoogleFonts.pressStart2p(
            fontSize: 14,
            color: const Color(0xFF6B46C1),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF6B46C1)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: PixelCassetteBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                
                // Header with pixel design
                PixelContainer(
                  backgroundColor: const Color(0xFFE8D5FF).withOpacity(0.9),
                  borderColor: const Color(0xFF6B46C1),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFF6B46C1).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xFF6B46C1),
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.favorite,
                          size: 24,
                          color: Color(0xFF6B46C1),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your Favorites',
                              style: GoogleFonts.pressStart2p(
                                fontSize: 12,
                                color: const Color(0xFF6B46C1),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${favoriteSongs.length} saved songs',
                              style: GoogleFonts.pressStart2p(
                                fontSize: 8,
                                color: const Color(0xFF374151),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6B46C1).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: const Color(0xFF6B46C1),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          '♪',
                          style: GoogleFonts.pressStart2p(
                            fontSize: 12,
                            color: const Color(0xFF6B46C1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Favorites list or empty state with pixel design
                PixelContainer(
                  backgroundColor: Colors.white.withOpacity(0.9),
                  borderColor: const Color(0xFF6B46C1),
                  child: Container(
                    height: 400,
                    child: favoriteSongs.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF6B46C1).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: const Color(0xFF6B46C1),
                                      width: 2,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.favorite_border,
                                    size: 32,
                                    color: Color(0xFF6B46C1),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No favorites yet!',
                                  style: GoogleFonts.pressStart2p(
                                    fontSize: 12,
                                    color: const Color(0xFF6B46C1),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Go to playlists and tap ♡\nto add songs here',
                                  style: GoogleFonts.pressStart2p(
                                    fontSize: 8,
                                    color: const Color(0xFF374151),
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
                              return Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                decoration: BoxDecoration(
                                  color: selectedSongIndex == index 
                                      ? const Color(0xFF6B46C1).withOpacity(0.1)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: selectedSongIndex == index 
                                        ? const Color(0xFF6B46C1)
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                child: ListTile(
                                  leading: Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF6B46C1).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: const Color(0xFF6B46C1),
                                        width: 1,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.music_note,
                                      size: 16,
                                      color: Color(0xFF6B46C1),
                                    ),
                                  ),
                                  title: Text(
                                    song['title'] ?? 'Unknown Song',
                                    style: GoogleFonts.pressStart2p(
                                      fontSize: 8,
                                      color: const Color(0xFF374151),
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  trailing: Icon(
                                    Icons.favorite,
                                    color: const Color(0xFF831843),
                                    size: 16,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selectedSongIndex = selectedSongIndex == index ? null : index;
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Action buttons with pixel design
                if (favoriteSongs.isNotEmpty) ...[
                  PixelButton(
                    text: selectedSongIndex != null ? 'Play Selected ♪' : 'Select a Song First',
                    backgroundColor: selectedSongIndex != null 
                        ? const Color(0xFFE8D5FF)
                        : const Color(0xFFF3F4F6),
                    textColor: selectedSongIndex != null 
                        ? const Color(0xFF6B46C1)
                        : const Color(0xFF9CA3AF),
                    onPressed: selectedSongIndex != null ? () {
                      Navigator.pushNamed(
                        context, 
                        '/player',
                        arguments: favoriteSongs[selectedSongIndex!],
                      );
                    } : () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Please select a favorite song first',
                            style: GoogleFonts.pressStart2p(fontSize: 8),
                          ),
                          backgroundColor: const Color(0xFF831843),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                ],
                
                // Navigation buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: PixelButton(
                        text: '← Playlists',
                        backgroundColor: const Color(0xFFF0F9FF),
                        textColor: const Color(0xFF1E40AF),
                        onPressed: () => Navigator.pushReplacementNamed(context, '/playlists'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: PixelButton(
                        text: 'Home',
                        backgroundColor: const Color(0xFFE8D5FF),
                        textColor: const Color(0xFF6B46C1),
                        onPressed: () => Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/',
                          (route) => false,
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
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
  bool _isShuffle = false;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;
  Map<String, String>? _currentSong;
  List<Map<String, String>> _playlist = [];
  int _currentSongIndex = 0;
  String? _playlistName;
  bool _hasInitialized = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _setupAudioPlayer();
  }

  void _setupAudioPlayer() {
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (mounted) {
        setState(() {
          _isPlaying = state == PlayerState.playing;
          if (state == PlayerState.stopped || state == PlayerState.completed) {
            _isLoading = false;
          }
        });
        
        print('Player state changed to: $state');
        
        // Handle completion
        if (state == PlayerState.completed) {
          if (_isRepeat) {
            _playCurrentSong();
          } else {
            _playNextSong();
          }
        }
      }
    });

    _audioPlayer.onPositionChanged.listen((Duration position) {
      if (mounted) {
        setState(() {
          _currentPosition = position;
        });
      }
    });

    _audioPlayer.onDurationChanged.listen((Duration duration) {
      if (mounted) {
        setState(() {
          _totalDuration = duration;
          _isLoading = false;
        });
        print('Duration set: ${_formatDuration(duration)}');
      }
    });

    // Handle errors
    _audioPlayer.onPlayerComplete.listen((event) {
      print('Audio playback completed');
      // This is handled in onPlayerStateChanged now
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasInitialized) {
      _initializeFromArguments();
      _hasInitialized = true;
    }
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

  void _initializeFromArguments() {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    final musicService = MusicPlayerService();
    
    // First priority: Check if there's a current song from MusicPlayerService
    if (musicService.currentSong != null) {
      _currentSong = musicService.currentSong;
      _playlist = List<Map<String, String>>.from(musicService.currentPlaylist);
      _currentSongIndex = musicService.currentIndex;
      _isPlaying = musicService.isPlaying;
      print('Initialized from MusicPlayerService: ${_currentSong!['title']}');
      if (_isPlaying) {
        _playCurrentSong();
      }
      return;
    }
    
    // Second priority: Use arguments passed to the screen
    if (arguments is Map<String, dynamic>) {
      _playlistName = arguments['playlistName'] as String?;
      final songIndex = arguments['songIndex'] as int? ?? 0;
      final songData = arguments['song'] as Map<String, String>?;
      final isPlaying = arguments['isPlaying'] as bool? ?? false;
      
      if (songData != null) {
        _currentSong = songData;
        _currentSongIndex = arguments['index'] as int? ?? songIndex;
        _playlist = arguments['playlist'] as List<Map<String, String>>? ?? [songData];
        _isPlaying = isPlaying;
        print('Initialized with song data: ${_currentSong!['title']}, playing: $_isPlaying');
        
        // Update MusicPlayerService with this song
        musicService.setCurrentSong(_currentSong!, _playlist, _currentSongIndex);
        if (!_isPlaying) {
          musicService.stop();
        }
        
        if (_isPlaying) {
          _playCurrentSong();
        }
        return;
      }
      
      if (_playlistName != null && globalPlaylists.containsKey(_playlistName!)) {
        _playlist = List<Map<String, String>>.from(globalPlaylists[_playlistName!]!);
        _currentSongIndex = songIndex.clamp(0, _playlist.length - 1);
        _currentSong = _playlist[_currentSongIndex];
        print('Initialized with playlist: $_playlistName, song index: $_currentSongIndex');
        print('Current song: ${_currentSong!['title']}');
      }
    } else if (arguments is Map<String, String>) {
      _currentSong = arguments;
      _playlist = [arguments];
      _currentSongIndex = 0;
      print('Initialized with single song: ${_currentSong!['title']}');
    } else if (arguments is String) {
      _findSongInPlaylists(arguments);
      print('Initialized by searching for song: $arguments');
    } else {
      print('No valid arguments provided, using fallback');
    }
    
    // Fallback if nothing is set - use first song from first playlist
    if (_currentSong == null && globalPlaylists.isNotEmpty) {
      final firstPlaylist = globalPlaylists.entries.first;
      _playlistName = firstPlaylist.key;
      _playlist = List<Map<String, String>>.from(firstPlaylist.value);
      if (_playlist.isNotEmpty) {
        _currentSongIndex = 0;
        _currentSong = _playlist[_currentSongIndex];
        print('Fallback: Using first song from $_playlistName');
      }
    }
    
    // Ultimate fallback
    if (_currentSong == null) {
      _currentSong = {'title': 'No Music Available', 'url': ''};
      _playlist = [_currentSong!];
      _currentSongIndex = 0;
      print('Ultimate fallback: No music available');
    }
  }

  void _findSongInPlaylists(String songTitle) {
    for (final entry in globalPlaylists.entries) {
      final playlist = entry.value;
      for (int i = 0; i < playlist.length; i++) {
        if (playlist[i]['title'] == songTitle) {
          _playlistName = entry.key;
          _playlist = List<Map<String, String>>.from(playlist);
          _currentSongIndex = i;
          _currentSong = playlist[i];
          return;
        }
      }
    }
    
    _currentSong = {'title': songTitle, 'url': ''};
    _playlist = [_currentSong!];
    _currentSongIndex = 0;
  }

  Future<void> _playCurrentSong() async {
    if (_currentSong == null) return;
    
    try {
      setState(() {
        _isLoading = true;
      });
      
      // Always stop any currently playing audio first
      await _audioPlayer.stop();
      
      // Small delay to ensure the previous song is fully stopped
      await Future.delayed(const Duration(milliseconds: 100));
      
      final assetUrl = _currentSong!['url'] ?? '';
      
      if (assetUrl.isNotEmpty) {
        if (assetUrl.startsWith('assets/')) {
          // Remove 'assets/' prefix for AssetSource
          final assetPath = assetUrl.substring(7); // Remove 'assets/' (7 characters)
          print('Playing local asset: $assetPath (from $assetUrl)');
          await _audioPlayer.play(AssetSource(assetPath));
        } else if (assetUrl.startsWith('http')) {
          print('Playing URL: $assetUrl');
          await _audioPlayer.play(UrlSource(assetUrl));
        } else {
          // Assume it's a direct asset path
          print('Playing direct asset: $assetUrl');
          await _audioPlayer.play(AssetSource(assetUrl));
        }
        
        // Set release mode after successful play
        if (_isRepeat) {
          await _audioPlayer.setReleaseMode(ReleaseMode.loop);
        } else {
          await _audioPlayer.setReleaseMode(ReleaseMode.release);
        }
      } else {
        throw Exception('No valid audio source found - empty URL');
      }
      
    } catch (e) {
      print('Error playing audio: $e');
      print('Current song: ${_currentSong!['title']}');
      print('Asset URL: ${_currentSong!['url']}');
      
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isPlaying = false;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Cannot play: ${_currentSong!['title']}',
              style: GoogleFonts.pressStart2p(fontSize: 8),
            ),
            backgroundColor: const Color(0xFF831843),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Future<void> _pauseAudio() async {
    try {
      await _audioPlayer.pause();
      setState(() {
        _isPlaying = false;
      });
    } catch (e) {
      print('Error pausing audio: $e');
    }
  }

  Future<void> _resumeAudio() async {
    try {
      await _audioPlayer.resume();
      setState(() {
        _isPlaying = true;
      });
    } catch (e) {
      print('Error resuming audio: $e');
    }
  }

  Future<void> _stopAudio() async {
    try {
      await _audioPlayer.stop();
      setState(() {
        _currentPosition = Duration.zero;
        _isPlaying = false;
      });
    } catch (e) {
      print('Error stopping audio: $e');
    }
  }

  void _playNextSong() {
    if (_playlist.length <= 1) return;
    
    if (_isShuffle) {
      _currentSongIndex = DateTime.now().millisecondsSinceEpoch % _playlist.length;
    } else {
      _currentSongIndex = (_currentSongIndex + 1) % _playlist.length;
    }
    
    setState(() {
      _currentSong = _playlist[_currentSongIndex];
    });
    
    // Update MusicPlayerService
    final musicService = MusicPlayerService();
    if (_currentSong != null) {
      musicService.setCurrentSong(_currentSong!, _playlist, _currentSongIndex);
    }
    
    if (_isPlaying || _currentPosition != Duration.zero) {
      _playCurrentSong();
    }
  }

  void _playPreviousSong() {
    if (_playlist.length <= 1) return;
    
    if (_isShuffle) {
      _currentSongIndex = DateTime.now().millisecondsSinceEpoch % _playlist.length;
    } else {
      _currentSongIndex = (_currentSongIndex - 1 + _playlist.length) % _playlist.length;
    }
    
    setState(() {
      _currentSong = _playlist[_currentSongIndex];
    });
    
    // Update MusicPlayerService
    final musicService = MusicPlayerService();
    if (_currentSong != null) {
      musicService.setCurrentSong(_currentSong!, _playlist, _currentSongIndex);
    }
    
    if (_isPlaying || _currentPosition != Duration.zero) {
      _playCurrentSong();
    }
  }

  void _toggleRepeat() {
    setState(() {
      _isRepeat = !_isRepeat;
    });
    
    if (_isPlaying) {
      if (_isRepeat) {
        _audioPlayer.setReleaseMode(ReleaseMode.loop);
      } else {
        _audioPlayer.setReleaseMode(ReleaseMode.release);
      }
    }
  }

  void _toggleShuffle() {
    setState(() {
      _isShuffle = !_isShuffle;
    });
  }

  void _seekTo(double percentage) {
    if (_totalDuration.inMilliseconds > 0) {
      final position = Duration(milliseconds: (_totalDuration.inMilliseconds * percentage).round());
      _audioPlayer.seek(position);
    }
  }

  Widget _buildProgressBar() {
    final progress = _totalDuration.inMilliseconds > 0 
        ? _currentPosition.inMilliseconds / _totalDuration.inMilliseconds 
        : 0.0;

    return Column(
      children: [
        GestureDetector(
          onTapDown: (TapDownDetails details) {
            final RenderBox box = context.findRenderObject() as RenderBox;
            final Offset localOffset = box.globalToLocal(details.globalPosition);
            final double percentage = (localOffset.dx / box.size.width).clamp(0.0, 1.0);
            _seekTo(percentage);
          },
          child: Container(
            height: 20,
            width: double.infinity,
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
                FractionallySizedBox(
                  widthFactor: progress.clamp(0.0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF6B46C1),
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _formatDuration(_currentPosition),
              style: GoogleFonts.pressStart2p(
                fontSize: 8,
                color: const Color(0xFF374151),
              ),
            ),
            Text(
              _formatDuration(_totalDuration),
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

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback? onPressed,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: onPressed != null ? color.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: onPressed != null ? color : Colors.grey,
            width: 2,
          ),
        ),
        child: Icon(
          icon,
          size: 24,
          color: onPressed != null ? color : Colors.grey,
        ),
      ),
    );
  }

  Widget _buildToggleButton({
    required IconData icon,
    required bool isActive,
    required VoidCallback? onPressed,
    required Color activeColor,
    required Color inactiveColor,
  }) {
    final color = isActive ? activeColor : inactiveColor;
    
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: isActive ? color.withOpacity(0.2) : color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: color,
            width: isActive ? 3 : 2,
          ),
        ),
        child: Icon(
          icon,
          size: 24,
          color: color,
        ),
      ),
    );
  }

  Widget _buildMainPlayButton() {
    if (_isLoading) {
      return Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF10B981).withOpacity(0.1),
              const Color(0xFF6B46C1).withOpacity(0.1),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF10B981),
            width: 3,
          ),
        ),
        child: const Center(
          child: SizedBox(
            width: 28,
            height: 28,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF10B981)),
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        final musicService = MusicPlayerService();
        
        if (_isPlaying) {
          _pauseAudio();
          musicService.stop(); // Update service state
        } else {
          if (_currentPosition == Duration.zero) {
            _playCurrentSong();
            // Update MusicPlayerService with current song
            if (_currentSong != null) {
              musicService.setCurrentSong(_currentSong!, _playlist, _currentSongIndex);
            }
          } else {
            _resumeAudio();
            musicService.togglePlayPause(); // Resume in service
          }
        }
      },
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF10B981).withOpacity(0.2),
              const Color(0xFF6B46C1).withOpacity(0.2),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF10B981),
            width: 3,
          ),
          boxShadow: _isPlaying ? [
            BoxShadow(
              color: const Color(0xFF10B981).withOpacity(0.3),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ] : null,
        ),
        child: Icon(
          _isPlaying ? Icons.pause : Icons.play_arrow,
          size: 32,
          color: const Color(0xFF10B981),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final songTitle = _currentSong?['title'] ?? 'No Song Selected';
    final hasMultipleSongs = _playlist.length > 1;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Music Player',
          style: GoogleFonts.pressStart2p(
            fontSize: 14,
            color: const Color(0xFF6B46C1),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF6B46C1)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Color(0xFF831843)),
            onPressed: () {
              // Add to favorites functionality
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Added to favorites!',
                    style: GoogleFonts.pressStart2p(fontSize: 8),
                  ),
                  backgroundColor: const Color(0xFF6B46C1),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: PixelCassetteBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                
                // Main album art and song info
                PixelContainer(
                  backgroundColor: const Color(0xFFE8D5FF).withOpacity(0.95),
                  borderColor: const Color(0xFF6B46C1),
                  child: Column(
                    children: [
                      // Album art section
                      Container(
                        width: double.infinity,
                        height: 180,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xFF6B46C1).withOpacity(0.1),
                              const Color(0xFF831843).withOpacity(0.1),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xFF6B46C1),
                            width: 2,
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Cassette tape animation
                            AnimatedBuilder(
                              animation: _isPlaying 
                                  ? AlwaysStoppedAnimation(1.0)
                                  : AlwaysStoppedAnimation(0.0),
                              builder: (context, child) {
                                return Transform.rotate(
                                  angle: _isPlaying ? DateTime.now().millisecondsSinceEpoch * 0.01 : 0,
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF6B46C1).withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(40),
                                      border: Border.all(
                                        color: const Color(0xFF6B46C1),
                                        width: 3,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.album,
                                      size: 40,
                                      color: Color(0xFF6B46C1),
                                    ),
                                  ),
                                );
                              },
                            ),
                            // Equalizer bars when playing
                            if (_isPlaying) ...[
                              Positioned(
                                left: 30,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(5, (index) {
                                    return Container(
                                      width: 4,
                                      height: (index + 1) * 8.0,
                                      margin: const EdgeInsets.symmetric(vertical: 1),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF10B981).withOpacity(0.7),
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              Positioned(
                                right: 30,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(5, (index) {
                                    return Container(
                                      width: 4,
                                      height: (5 - index) * 8.0,
                                      margin: const EdgeInsets.symmetric(vertical: 1),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF10B981).withOpacity(0.7),
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Song info
                      Text(
                        'Now Playing',
                        style: GoogleFonts.pressStart2p(
                          fontSize: 8,
                          color: const Color(0xFF374151),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        songTitle,
                        style: GoogleFonts.pressStart2p(
                          fontSize: 12,
                          color: const Color(0xFF6B46C1),
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      
                      // Playlist info
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (hasMultipleSongs) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFF6B46C1).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: const Color(0xFF6B46C1),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                '${_currentSongIndex + 1} / ${_playlist.length}',
                                style: GoogleFonts.pressStart2p(
                                  fontSize: 6,
                                  color: const Color(0xFF374151),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],
                          if (_playlistName != null) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFF831843).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: const Color(0xFF831843),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                _playlistName!,
                                style: GoogleFonts.pressStart2p(
                                  fontSize: 6,
                                  color: const Color(0xFF831843),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Progress bar with enhanced design
                PixelContainer(
                  backgroundColor: Colors.white.withOpacity(0.9),
                  borderColor: const Color(0xFF6B46C1),
                  child: _buildProgressBar(),
                ),
                
                const SizedBox(height: 20),
                
                // Main playback controls with enhanced design
                PixelContainer(
                  backgroundColor: const Color(0xFFE8D5FF).withOpacity(0.9),
                  borderColor: const Color(0xFF6B46C1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Previous button
                      _buildControlButton(
                        icon: Icons.skip_previous,
                        onPressed: hasMultipleSongs ? _playPreviousSong : null,
                        color: hasMultipleSongs ? const Color(0xFF6B46C1) : Colors.grey,
                      ),
                      
                      // Play/Pause button (enhanced)
                      _buildMainPlayButton(),
                      
                      // Next button
                      _buildControlButton(
                        icon: Icons.skip_next,
                        onPressed: hasMultipleSongs ? _playNextSong : null,
                        color: hasMultipleSongs ? const Color(0xFF6B46C1) : Colors.grey,
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Secondary controls with pixel design
                PixelContainer(
                  backgroundColor: Colors.white.withOpacity(0.9),
                  borderColor: const Color(0xFF6B46C1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Shuffle button
                      _buildToggleButton(
                        icon: Icons.shuffle,
                        isActive: _isShuffle,
                        onPressed: hasMultipleSongs ? _toggleShuffle : null,
                        activeColor: const Color(0xFFEAB308),
                        inactiveColor: hasMultipleSongs ? const Color(0xFF6B46C1) : Colors.grey,
                      ),
                      
                      // Stop button
                      _buildControlButton(
                        icon: Icons.stop,
                        onPressed: _stopAudio,
                        color: const Color(0xFF831843),
                      ),
                      
                      // Repeat button
                      _buildToggleButton(
                        icon: Icons.repeat,
                        isActive: _isRepeat,
                        onPressed: _toggleRepeat,
                        activeColor: const Color(0xFFEAB308),
                        inactiveColor: const Color(0xFF6B46C1),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Navigation buttons with enhanced design
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: PixelButton(
                        text: '← Playlists',
                        backgroundColor: const Color(0xFFE8D5FF),
                        textColor: const Color(0xFF6B46C1),
                        onPressed: () => Navigator.pushReplacementNamed(context, '/playlists'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: PixelButton(
                        text: '♡ Favs',
                        backgroundColor: const Color(0xFFFDF2F8),
                        textColor: const Color(0xFF831843),
                        onPressed: () => Navigator.pushNamed(context, '/favourites'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: PixelButton(
                        text: 'Home',
                        backgroundColor: const Color(0xFFF0F9FF),
                        textColor: const Color(0xFF1E40AF),
                        onPressed: () => Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/',
                          (route) => false,
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
