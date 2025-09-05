import 'package:flutter_test/flutter_test.dart';
import '../lib/music_service.dart';

void main() {
  group('MusicService Tests', () {
    test('should get audio URL for popular songs', () async {
      // Test with a song that has a demo mapping
      final audioUrl = await MusicService.getSongAudioUrl('Love Story');
      
      print('Test result - Audio URL for "Love Story": $audioUrl');
      
      // Should return a valid URL (either demo or real)
      expect(audioUrl, isNotNull);
      expect(audioUrl, startsWith('https://'));
    });

    test('should get audio URL for any song', () async {
      // Test the complete workflow with a popular song
      final audioUrl = await MusicService.getSongAudioUrl('Perfect');
      
      print('Test result - Audio URL for "Perfect": $audioUrl');
      
      // Should always return some URL (fallback system)
      expect(audioUrl, isNotNull);
      expect(audioUrl, startsWith('https://'));
    });

    test('should handle unknown songs with fallback', () async {
      final audioUrl = await MusicService.getSongAudioUrl('UnknownSong12345XYZ');
      
      print('Test result - Audio URL for unknown song: $audioUrl');
      
      // Should return a fallback URL for unknown songs
      expect(audioUrl, isNotNull);
      expect(audioUrl, startsWith('https://'));
    });

    test('should use cache for repeated requests', () async {
      // First request
      final audioUrl1 = await MusicService.getSongAudioUrl('Hello');
      print('First request - Audio URL for "Hello": $audioUrl1');
      
      // Second request (should use cache)
      final audioUrl2 = await MusicService.getSongAudioUrl('Hello');
      print('Second request - Audio URL for "Hello": $audioUrl2');
      
      // Should return the same URL from cache
      expect(audioUrl1, equals(audioUrl2));
    });

    test('should check demo mappings', () async {
      // Test if specific songs have demo mappings
      final hasMapping = MusicService.hasDemoMapping('DDU-DU DDU-DU');
      print('Has demo mapping for "DDU-DU DDU-DU": $hasMapping');
      
      expect(hasMapping, isTrue);
      
      // Test a song that shouldn't have a mapping
      final noMapping = MusicService.hasDemoMapping('NonExistentSong999');
      print('Has demo mapping for "NonExistentSong999": $noMapping');
      
      expect(noMapping, isFalse);
    });
  });
}
