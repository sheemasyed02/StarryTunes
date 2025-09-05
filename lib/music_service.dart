class MusicService {
  // Cache to store audio URLs
  static final Map<String, String> _audioUrlCache = {};
  
  // For demo purposes, we'll use a mapping of popular songs to free audio samples
  // In a real app, this would be replaced with a proper music streaming API
  static const Map<String, String> _demoAudioUrls = {
    // Popular songs with free sample URLs
    'Love Story': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
    'Perfect': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
    'Blinding Lights': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
    'Shape of You': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3',
    'Someone Like You': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3',
    'Hello': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
    'Watermelon Sugar': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
    'Anti-Hero': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
    'As It Was': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3',
    'Bad Habit': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3',
    
    // Add more mappings as needed
    'DDU-DU DDU-DU': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
    'Kill This Love': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
    'How You Like That': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
    'Dynamite': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3',
    'Butter': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3',
    
    // Classical/Study music
    'Clair de Lune': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
    'River Flows in You': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
    'Nuvole Bianche': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
  };
  
  /// Alternative API attempt (when available)
  static Future<String?> _tryAlternativeAPI(String songName) async {
    try {
      // This is a placeholder for when you get access to a working music API
      // For example, Spotify Web API, Last.fm, or other music services
      
      // When you have a working API, add the http import back and uncomment:
      /*
      import 'dart:convert';
      import 'package:http/http.dart' as http;
      
      final searchUrl = Uri.parse('https://api.example.com/search?q=${Uri.encodeComponent(songName)}');
      final response = await http.get(searchUrl).timeout(Duration(seconds: 5));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Parse the response and extract audio URL
        return data['audio_url'];
      }
      */
      
      return null;
    } catch (e) {
      print('Alternative API error: $e');
      return null;
    }
  }
  
  /// Get audio URL for a song with smart fallback
  static Future<String?> getSongAudioUrl(String songName) async {
    try {
      print('Getting audio URL for: $songName');
      
      // Check cache first
      if (_audioUrlCache.containsKey(songName)) {
        print('Found cached audio URL for: $songName');
        return _audioUrlCache[songName];
      }
      
      // Step 1: Try alternative API (when available)
      final apiUrl = await _tryAlternativeAPI(songName);
      if (apiUrl != null) {
        print('Got API audio URL: $apiUrl');
        _audioUrlCache[songName] = apiUrl;
        return apiUrl;
      }
      
      // Step 2: Check demo mapping for exact matches
      if (_demoAudioUrls.containsKey(songName)) {
        final demoUrl = _demoAudioUrls[songName]!;
        print('Found demo audio URL for exact match "$songName": $demoUrl');
        _audioUrlCache[songName] = demoUrl;
        return demoUrl;
      }
      
      // Step 3: Try fuzzy matching for demo URLs
      final lowerSongName = songName.toLowerCase();
      for (final entry in _demoAudioUrls.entries) {
        if (entry.key.toLowerCase().contains(lowerSongName) || 
            lowerSongName.contains(entry.key.toLowerCase())) {
          final demoUrl = entry.value;
          print('Found demo audio URL for fuzzy match "$songName" -> "${entry.key}": $demoUrl');
          _audioUrlCache[songName] = demoUrl;
          return demoUrl;
        }
      }
      
      // Step 4: Return a default demo URL for any unmatched song
      final defaultUrl = 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-${(songName.hashCode % 16).abs() + 1}.mp3';
      print('Using default demo URL for "$songName": $defaultUrl');
      _audioUrlCache[songName] = defaultUrl;
      return defaultUrl;
      
    } catch (e) {
      print('Error in getSongAudioUrl: $e');
      
      // Fallback to a safe default
      final fallbackUrl = 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3';
      print('Using fallback URL: $fallbackUrl');
      return fallbackUrl;
    }
  }
  
  /// Add a custom mapping for testing
  static void addCustomMapping(String songName, String audioUrl) {
    _audioUrlCache[songName] = audioUrl;
  }
  
  /// Clear all caches
  static void clearCache() {
    _audioUrlCache.clear();
  }
  
  /// Get cached audio URLs (for debugging)
  static Map<String, String> getCachedAudioUrls() {
    return Map.from(_audioUrlCache);
  }
  
  /// Get available demo mappings
  static Map<String, String> getDemoMappings() {
    return Map.from(_demoAudioUrls);
  }
  
  /// Check if a song has a specific demo mapping
  static bool hasDemoMapping(String songName) {
    return _demoAudioUrls.containsKey(songName);
  }
}
