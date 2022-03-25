import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class MyService{
  static Box<Map<dynamic, dynamic>>? myBox;

  static openBox()async{
    Directory appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);
    myBox = await Hive.openBox('crm');
  }
  static putData(Map<dynamic,dynamic> data) async {
    await myBox?.add(data);
  }

  static deleteData(int index) async {
    await myBox!.deleteAt(index);
  }

  static changeData(int index, Map<dynamic,dynamic> value) {
    myBox!.putAt(index, value);
    
  }
}