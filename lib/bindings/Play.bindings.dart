import 'package:get/get.dart';
import 'package:note_trainer/controllers/Play.controller.dart';
import 'package:note_trainer/controllers/PlayGame.controller.dart';

class PlayBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PlayController());
    Get.lazyPut(() => PlayGameController());
  }


}
