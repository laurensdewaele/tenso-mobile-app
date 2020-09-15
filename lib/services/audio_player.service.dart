import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerService {
  AudioCache _audioCache;
  AudioPlayer _audioPlayer;

  AudioPlayerService._() {
    _audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
    _audioCache =
        AudioCache(prefix: 'assets/audio/', fixedPlayer: _audioPlayer);
  }
  static final AudioPlayerService _audioPlayerService = AudioPlayerService._();
  factory AudioPlayerService() => _audioPlayerService;

  void play(String filename) async {
    await _audioCache.play(filename);
  }

  void dispose() {}
}
