import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_trainer/UI/pages/Test.dart';
import 'package:note_trainer/UI/pages/home.dart';
import 'package:note_trainer/bindings/Home.bindings.dart';
import 'package:note_trainer/bindings/Test.bindings.dart';
import 'package:note_trainer/utils/translations.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: "/home",
    defaultTransition: Transition.fade, 
    getPages: [
          GetPage(name: "/home", page: () => Home(), 
          binding: HomeBindings()),
          GetPage(name: "/test", page: () =>  TestPage(),
          binding: TestBindings(),
          )
  ],
    locale: Locale("es", "419"),
    translations: Messages(),
  ));
}

