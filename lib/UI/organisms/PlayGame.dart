import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_notes/music_notes.dart';
import 'package:note_trainer/UI/atoms/ButtonWrapper.dart';
import 'package:note_trainer/UI/atoms/Countdown.dart';
import 'package:note_trainer/UI/atoms/StyledText.dart';
import 'package:note_trainer/UI/molecules/CountdownWrapper.dart';
import 'package:note_trainer/controllers/Play.controller.dart';
import 'package:note_trainer/controllers/PlayGame.controller.dart';

class PlayGame extends StatelessWidget {
  PlayGameController? controller;

  Widget Summary() {
    return Column(
      mainAxisSize: MainAxisSize.min,

      children: [
        StyledText(
          text: "summary.correct".trParams({
            "total": controller!.totalTurns.value.toString(),
            "notes": controller!.correctNotes.value.toString(),
          }),
          variant: TextVariant.TITLE,
        ),
        StyledText(
          text: "summary.incorrect".trParams({
            "total": controller!.totalTurns.value.toString(),
            "notes": controller!.correctNotes.value.toString(),
          }),
          variant: TextVariant.TITLE,
        ),
        SizedBox(height: 48,),
        ButtonWrapper(
          child: ElevatedButton(
            onPressed: () {
              controller!.restart();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent.shade700,
                  
            ),
            child: Text("retry".tr, style: TextStyle(color: Colors.white),),
          ),
        ),
        SizedBox(height: 12,),
        ButtonWrapper(
          child: ElevatedButton(
            onPressed: () {
              controller!.onStopGame();
            },
            child: Text("return".tr),
          ),
        ),
      ],
    );
  }

  Widget GameView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(
          () => StyledText(
            text: controller!.nextNote.value.toString(),
            variant: TextVariant.EXTRALARGE,
            overrideStyle:
                controller!.isCorrectNote.value
                    ? TextStyle(color: Colors.green)
                    : null,
          ),
        ),
        StyledText(
          text: controller!.nextNote.value!.toString(
            system: NoteNotation.romance,
          ),
          variant: TextVariant.FADE,
        ),
        SizedBox(height: 24.0),
        ElevatedButton(
          onPressed: controller!.onStopGame,
          child: Text("cancel".tr),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.delete<PlayGameController>();
    controller = Get.put(PlayGameController());
    return Center(
      child: Obx(() {
        if (controller!.state.equals(GameStateEnum.summary)) {
          return Summary();
        }
        if (controller!.state.equals(GameStateEnum.playing)) {
          return GameView();
        }
        if(controller!.state.equals(GameStateEnum.resting)) {
          return Countdown(from: 10, onCountdownFinished: controller!.onRestFinished);
        }
        return Countdown(
          from: 3,
          countStyle: const TextStyle(fontSize: 48),
          onCountdownFinished: controller!.onInitialCountdownFinished,
        );
      }),
    );
  }
}
