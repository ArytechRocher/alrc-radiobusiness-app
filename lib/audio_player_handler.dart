import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

Future<AudioHandler> initAudioService() async {
  return await AudioService.init(
    builder: () => RadioPlayerHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.alrc.radio',
      androidNotificationChannelName: 'ALRC Radio Playback',
      androidNotificationOngoing: true,
    ),
  );
}

class RadioPlayerHandler extends BaseAudioHandler {
  final _player = AudioPlayer();

  RadioPlayerHandler() {
    _init();
  }

  void _init() async {
    final mediaItem = MediaItem(
      id: 'https://groupemedia.info/uploads/audio/presentation1.mp3',
      title: 'Radio Business',
      album: 'ALRC',
      artUri: Uri.parse('https://groupemedia.info/uploads/images/logo_radio.png'),
    );

    mediaItem.add(mediaItem);
    playbackState.add(playbackState.value.copyWith(
      controls: [
        MediaControl.play,
        MediaControl.pause,
        MediaControl.stop,
      ],
      playing: false,
    ));

    await _player.setUrl(mediaItem.id);
    _player.playbackEventStream.listen((event) {
      final playing = _player.playing;
      playbackState.add(playbackState.value.copyWith(
        playing: playing,
        processingState: AudioProcessingState.ready,
      ));
    });
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> stop() => _player.stop();
}

