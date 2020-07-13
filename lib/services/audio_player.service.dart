import 'package:audioplayers/audio_cache.dart';

class AudioPlayerService {
  AudioCache _audioCache;

  AudioPlayerService._() {
    _audioCache = AudioCache(prefix: 'audio/');
  }
  static final AudioPlayerService _audioPlayerService = AudioPlayerService._();
  factory AudioPlayerService() => _audioPlayerService;

  void play(String filename) async {
    await _audioCache.play(filename);
  }

  void dispose() {}
}
