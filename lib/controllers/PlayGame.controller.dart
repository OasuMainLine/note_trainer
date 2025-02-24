import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';
import 'package:music_notes/music_notes.dart';
import 'package:note_trainer/UI/pages/NoteList.dart';
import 'package:note_trainer/controllers/Home.controller.dart';
import 'package:note_trainer/controllers/Play.controller.dart';
import 'package:note_trainer/misc/note_picker/NotePicker.dart';
import 'package:note_trainer/utils/audio.dart';
import 'package:note_trainer/utils/state.dart';

const List<Note> notes = [
  Note.a,
  Note.b,
  Note.c,
  Note.d,
  Note.e,
  Note.f,
  Note.g,
];



class PlayGameController extends GetxController {
  Timer? noteTimer;
  final nextNote = Rxn<Note>();
  int? previousNote;
  NotePicker? notePicker;
  final _random = Random();
  final audioEffects = AudioEffectsPlayer();
  final correctNotes = 0.obs;
  final incorrectNotes = 0.obs;
  final totalTurns = 1.obs;
  final totalRounds = 0.obs;
  final isCorrectNote = false.obs;
  final settingsController = Get.find<PlayController>();


  StateObject<GameStateEnum> get state {
    return settingsController.state;
  }
  @override
  void onInit() {
    super.onInit();
    notePicker = NotePicker(noteCallback: _onNoteHeard);
  }

  @override
  void dispose() {
    super.dispose();
    print("Dispose");
  }

  @override
  void onClose() {
    super.onClose();
    notePicker?.stopListening();
  }

  _restartTimer() {
      if(noteTimer != null){
        noteTimer!.cancel();
      }
      noteTimer = Timer(Duration(seconds: 6), onNoteTimerFinished);
  }

  Note _getRandomNote() {
    int notePosition = _random.nextInt(notes.length);
    while(notePosition == previousNote) {
      notePosition = _random.nextInt(notes.length);
    }
    previousNote = notePosition;
    return notes[notePosition];
  }
  onInitialCountdownFinished() {
    nextNote.value = _getRandomNote();
    settingsController.state.to(GameStateEnum.playing);
    _restartTimer();
    if(notePicker != null) {
      notePicker!.startListening();
    }
  }

  onNoteTimerFinished() {
    if(settingsController.turns.value == totalTurns.value) {
      totalRounds.value += 1;
      if(totalRounds.value == settingsController.rounds.value) {
          settingsController.state.to(GameStateEnum.summary);

      } else {
        settingsController.state.to(GameStateEnum.resting);
      }
      return;
    }
    _restartTimer();

    nextNote.value = _getRandomNote();
    if(!isCorrectNote.value) {
      incorrectNotes.value += 1;
    }
    isCorrectNote.value = false;
    totalTurns.value += 1;
  }

  restart() {
    correctNotes.value = 0;
    incorrectNotes.value = 0;
    totalTurns.value = 1;
    isCorrectNote.value = false;
    settingsController.state.to(GameStateEnum.initialLoad);
  }

  onStopGame() {
    settingsController.state.to(GameStateEnum.settings);
    Get.find<HomeController>().showBottom();
    notePicker?.stopListening();
    noteTimer?.cancel();
  }
  _onNoteHeard(Note notePicked) {
      if(settingsController.state.equals(GameStateEnum.playing)
          && nextNote.value != null
          && notePicked == nextNote.value
          && !isCorrectNote.value) {
        correctNotes.value += 1;
        isCorrectNote.value = true;
        audioEffects.play(Sounds.CORRECT);
      }
  }

  onRestFinished() {
      totalTurns.value = 1;
      settingsController.state.to(GameStateEnum.playing);
      _restartTimer();
  }
}
