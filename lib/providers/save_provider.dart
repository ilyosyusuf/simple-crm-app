import 'package:flutter/cupertino.dart';
import 'package:hiveproject/services/my_service.dart';

class SaveProvider extends ChangeNotifier {
  int? uzunlik = MyService.myBox!.length;
   
 void set(){
   uzunlik = MyService.myBox!.length;
   notifyListeners();
 }
}