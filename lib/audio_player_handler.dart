import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/foundation.dart';

class MyAudioHandler extends BaseAudioHandler with SeekHandler {
  final _player = AudioPlayer();

  MyAudioHandler() {
    // Configuration d’un flux audio simple
    _init();
  }

  Future<void> _init() async {
    // URL de démo ou stream radio
    await _player.setAudioSource(AudioSource.uri(
      Uri.parse("https://groupemedia.info/uploads/audio/presentation1.mp3"),
    ));

    // Metadonnées simulées
    final mediaItem = MediaItem(
      id: "https://groupemedia.info/uploads/audio/presentation1.mp3",
      album: "ALRC Radio",
      title: "Présentation de la Radio",
      artUri: Uri.parse("https://groupemedia.info/uploads/images/logo_radio.png"),
    );

    mediaItemSubject.add(mediaItem); // ✅ Corrigé : assure-toi de l’avoir défini

    playbackState.add(
      const PlaybackState(
        controls: [
          MediaControl.play,
          MediaControl.pause,
          MediaControl.stop,
        ],
        androidCompactActionIndices: [0, 1],
        playing: false,
        processingState: AudioProcessingState.ready,
      ),
    );

    _player.playbackEventStream.listen((event) {
      playbackState.add(playbackState.value.copyWith(
        playing: _player.playing,
        updatePosition: _player.position,
        processingState: {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[_player.processingState]!,
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
