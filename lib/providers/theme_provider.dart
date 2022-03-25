import 'package:flutter/cupertino.dart';

class ThemeProvider extends ChangeNotifier{
  var themeMode = Brightness.light;
  bool themeStatus = false;

  void changeTheme(){
    if(themeMode == Brightness.dark){
      themeMode = Brightness.light;
    }else{
      themeMode = Brightness.dark;
    }
    themeStatus = !themeStatus;
    notifyListeners();
  }
}