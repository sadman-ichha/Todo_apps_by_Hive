// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _userInputController = TextEditingController();
  TextEditingController _updateController = TextEditingController();

  Box? todoBox;

  @override
  void initState() {
    todoBox = Hive.box("todo-list");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("To-Do App",
              style: TextStyle(
                fontSize: 21.0.sp,
              )),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            children: [
              Image.asset('assets/To_do_list.png'),
              TextField(
                controller: _userInputController,
                decoration: InputDecoration(hintText: "Write a new Todo"),
              ),
              SizedBox(height: 7.5.h),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    final _userInput = _userInputController.text;
                    print(_userInput);
                    await todoBox!.add(_userInput);
                    Fluttertoast.showToast(msg: "New ToDo Added");
                  },
                  child: Text("Added Todo"),
                ),
              ),
              SizedBox(height: 20.5.h),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: Hive.box('todo-list').listenable(),
                  builder: (_, box, widget) {
                    return ListView.builder(
                      itemCount: todoBox!.keys.toList().length,
                      itemBuilder: (_, index) {
                        return Card(
                          elevation: 4.0,
                          child: ListTile(
                            title: Text(todoBox!.getAt(index).toString()),
                            trailing: SizedBox(
                              width: 100.0.w,
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (_) {
                                            return AlertDialog(
                                              title: Text("Updated"),
                                              content: Column(
                                                children: [
                                                  TextField(
                                                    controller:
                                                        _updateController,
                                                    decoration: InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        hintText:
                                                            "Update Todo"),
                                                  ),
                                                  SizedBox(height: 10.0.h),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2,
                                                    child: ElevatedButton(
                                                      onPressed: () async {
                                                        final _userInput =
                                                            _updateController
                                                                .text;
                                                        print(_userInput);

                                                        await todoBox!.putAt(
                                                            index, _userInput);
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text("Update Now"),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    icon: Icon(
                                      Icons.edit_outlined,
                                      color: Color(0xFF262424),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      await todoBox!.deleteAt(index);
                                    },
                                    icon: Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
