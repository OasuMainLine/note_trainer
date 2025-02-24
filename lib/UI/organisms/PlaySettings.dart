import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:note_trainer/UI/atoms/IntervalPicker.dart';
import 'package:note_trainer/UI/atoms/StyledText.dart';
import 'package:note_trainer/UI/molecules/ColumGap.dart';
import 'package:note_trainer/controllers/Home.controller.dart';
import 'package:note_trainer/controllers/Play.controller.dart';
import 'package:permission_handler/permission_handler.dart';

class PlaySettings extends GetView<PlayController> {
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                  color: Colors.indigoAccent,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    Icon(
                      Icons.music_note_rounded,
                      color: Colors.orangeAccent,
                      size: 38.0,
                    ),
                    StyledText(
                      text: "practice".tr,
                      variant: TextVariant.TITLE,
                      overrideStyle: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox.fromSize(size: Size.fromHeight(18.0)),
          Obx(
            () => Container(
              width: MediaQuery.of(context).size.width / 2,
              child: ColumnGap(
                gap: 24.0,
                children: [
                  IntervalPicker(
                    label: "turns".tr,
                    value: controller.turns.value,
                    onChange: controller.onTurnsChange,
                  ),
                  IntervalPicker(
                    label: "rounds".tr,
                    value: controller.rounds.value,
                    onChange: controller.onRoundsChange,
                  ),
                  IntervalPicker(
                    label: "rests".tr,
                    value: controller.rests.value,
                    specifier: "secs",
                    onChange: controller.onRestsChange,
                  ),
                ],
              ),
            ),
          ),
          SizedBox.fromSize(size: Size.fromHeight(48.0)),
          SizedBox(
            width: 248.0,
            child: ElevatedButton(
              onPressed: controller.onPlay,
              child: Text("play".tr),
            ),
          ),
        ],
      ),
    );
  }
}
