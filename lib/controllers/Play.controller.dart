import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:note_trainer/controllers/Home.controller.dart';
import 'package:note_trainer/utils/consts.dart';
import 'package:note_trainer/utils/state.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum GameStateEnum {
  initialLoad,
  playing,
  summary,
  settings,
  resting
}
class PlayController extends GetxController {
  var turns = 10.obs;
  var rounds = 10.obs;
  var rests = 10.obs;

  final homeController = Get.find<HomeController>();

  final state = StateObject(GameStateEnum.settings);
  SharedPreferences? _prefs;

  @override
  void onInit() async {
    super.onInit();
    _prefs = await SharedPreferences.getInstance();

    var localTurns = _prefs!.getInt(TURNS_KEY);
    var localRounds = _prefs!.getInt(ROUNDS_KEY);
    var localRests = _prefs!.getInt(RESTS_KEY);

    if (localTurns != null) {
      turns.value = localTurns;
    }
    if (localRounds != null) {
      rounds.value = localRounds;
    }
    if (localRests != null) {
      rests.value = localRests;
    }
  }

  void onTurnsChange(int turns) {
    this.turns.value = turns;
    _prefs?.setInt(TURNS_KEY, turns);
  }

  void onRoundsChange(int rounds) {
    this.rounds.value = rounds;
    _prefs?.setInt(ROUNDS_KEY, rounds);
  }

  void onRestsChange(int rests) {
    this.rests.value = rests;
    _prefs?.setInt(RESTS_KEY, rests);
  }

  onPlay() async {
    var res = await Permission.microphone.status;
    if (res.isDenied) {
      print("denied");
      await Fluttertoast.showToast(
        msg: "permission.microphone.error".tr,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }
    state.to(GameStateEnum.initialLoad);
    homeController.hideBottom();
  }
}
