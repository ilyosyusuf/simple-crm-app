import 'package:flutter/material.dart';
import 'package:hiveproject/providers/save_provider.dart';
import 'package:hiveproject/providers/theme_provider.dart';
import 'package:hiveproject/services/my_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _name1Controller = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  TextEditingController _aboutController = TextEditingController();
  Image? imagegallery;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("CRM"),
        actions: [
          Switch.adaptive(
            value: context.watch<ThemeProvider>().themeStatus,
            onChanged: (v){
              context.read<ThemeProvider>().changeTheme();
            }
            )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: MyService.myBox!.isNotEmpty
                ? ListView.builder(
                    itemBuilder: (ctx, i) {
                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) async {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "${MyService.myBox!.getAt(i)!['name']} ro'yxatdan o'chirildi "),
                            ),
                          );
                          MyService.deleteData(i);
                          context.read<SaveProvider>().set();
                        },
                        child: InkWell(
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(MyService.myBox!
                                    .getAt(i)!['name']
                                    .toString()),
                                subtitle: Text(MyService.myBox!
                                    .getAt(i)!['type']
                                    .toString()),
                              ),
                              SizedBox(
                                  width: double.infinity,
                                  child: Divider(
                                    thickness: 1,
                                  ))
                            ],
                          ),
                          onDoubleTap: (){
                            _showDialog(context, _buttonForChange(context, i));
                            context.read<SaveProvider>().set();
                          },
                        ),
                        background: Container(color: Colors.red),
                      );
                    },
                    itemCount: context.watch<SaveProvider>().uzunlik,
                  )
                : const Center(
                    child: Text("Hozircha ma'lumotlar yo'q"),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showDialog(context, _buttonForAdd(context));
        },
      ),
    );
  }

  Future<dynamic> _showDialog(BuildContext context, ElevatedButton button) {
    return showDialog(
          context: context,
          builder: (context) => SingleChildScrollView(
            child: AlertDialog(
              title: Text("Ma'lumotlar qo'shing"),
              content: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: "Biznes Nomi",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  TextFormField(
                    controller: _typeController,
                    decoration: InputDecoration(
                      hintText: "Biznes turi",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  TextFormField(
                    controller: _aboutController,
                    decoration: InputDecoration(
                      hintText: "Kompaniya haqida",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  child: Text("Back"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                button
              ],
            ),
          ),
        );
  }

  ElevatedButton _buttonForAdd(BuildContext context)  {
    return ElevatedButton(
                  child: Text("Tasdiqlash"),
                  onPressed: () async {
                    await MyService.putData({
                      "name": _nameController.text.toString(),
                      "type": _typeController.text.toString(),
                      "about": _aboutController.text.toString(),
                    });
                    _nameController.clear();
                    _typeController.clear();
                    _aboutController.clear();
                    context.read<SaveProvider>().set();
                    Navigator.pop(context);
                  },
                );
  }
    ElevatedButton _buttonForChange(BuildContext context, int index)  {
    return ElevatedButton(
                  child: Text("Tasdiqlash"),
                  onPressed: () {
                    MyService.changeData(
                              index,
                              {
                                "name": _nameController,
                                "type": _typeController,
                                "about": _aboutController,
                              }
                            );
                    _nameController.clear();
                    _typeController.clear();
                    _aboutController.clear();
                    context.read<SaveProvider>().set();
                    Navigator.pop(context);
                  },
                );
  }
}
