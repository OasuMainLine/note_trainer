import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter/services.dart' show rootBundle;
enum Sounds {
  CORRECT, INCORRECT
}

extension SoundsExtension on Sounds {
  String get asset {
    switch(this) {
      case Sounds.CORRECT:
        return "assets/audio/correct.wav";
      case Sounds.INCORRECT:
        return "";
    }
  }
}
class AudioEffectsPlayer {
  final _player = FlutterSoundPlayer();


  Future<void> play(Sounds sound) async {
    if(!_player.isOpen())  {
      await _player.openPlayer();
    }

    var source = await rootBundle.load(sound.asset);
    var buffer = source.buffer.asUint8List();
    await _player.startPlayer(fromDataBuffer: buffer, codec: Codec.pcm16WAV);
  }

  stop(){
      if(!_player.isStopped) {
          _player.stopPlayer();
      }
  }

  dispose() {
    stop();
    _player.closePlayer();
  }
}
