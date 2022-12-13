import 'package:build_todo/configs/theme.dart';
import 'package:build_todo/views/to_do_detail_view.dart';
import 'package:build_todo/views/to_do_list_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'configs/conts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().whenComplete(() {
    debugPrint(Const.Msg_Firebase_Initialize_Success);
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Const.Label_To_Do_App,
      debugShowCheckedModeBanner: false, // Remove the debug banner.
      theme: THEME_DATA,
      home: const ToDoListPage(title: Const.Label_To_Do_List),
    );
  }
}
