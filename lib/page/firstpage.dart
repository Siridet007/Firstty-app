import 'dart:convert';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:firstty_app/page/loginflippage.dart';
import 'package:firstty_app/page/tab/firsttab.dart';
import 'package:firstty_app/page/tab/thirdtab.dart';
import 'package:firstty_app/page/tab/secodetab.dart';
import 'package:flutter/material.dart';

import 'model/model.dart';

class FirstPage extends StatefulWidget {
  final String username;
  final String pass;
  final String id;
  const FirstPage(
      {super.key,
      required this.username,
      required this.pass,
      required this.id});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List<DropdownItem> items = [
    DropdownItem(imagePath: 'assets/image/button_lan/ENG.png', label: 'Item 1'),
    DropdownItem(imagePath: 'assets/image/button_lan/TH.png', label: 'Item 2'),
    DropdownItem(imagePath: 'assets/image/button_lan/JP.png', label: 'Item 3'),
  ];
  DropdownItem? selectedItem;
  TextEditingController oldPass = TextEditingController();
  TextEditingController newPass = TextEditingController();
  double? width;
  double? height;
  List userList = [];

  Future<void> checkPassword(String username, old, id, newP) async {
    final dio = Dio();
    final url = 'http://localhost:5000/find/$username';
    try {
      final response = await dio.get(url);
      if (response.data[0]['password'] != old) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.LEFTSLIDE,
          title: 'Error',
          desc: 'Your password not correct please try again',
          descTextStyle: const TextStyle(fontSize: 20),
          btnOkOnPress: () {},
          buttonsTextStyle: const TextStyle(fontSize: 20),
          btnOkText: 'OK',
          width: width! * .2,
        ).show();
      } else {
        final dio = Dio();
        final url = 'http://localhost:5000/update/password/$id';
        try {
          final response = await dio.put(
            url,
            data: {'password': '$newP'},
          );
          if (response.statusCode == 200) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.SUCCES,
              animType: AnimType.LEFTSLIDE,
              title: 'Success',
              desc: 'Register successfully',
              descTextStyle: const TextStyle(fontSize: 20),
              btnOkOnPress: () {
                Navigator.of(context).pop();
              },
              buttonsTextStyle: const TextStyle(fontSize: 20),
              btnOkText: 'OK',
              width: width! * .2,
            ).show();
          } else {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.ERROR,
              animType: AnimType.LEFTSLIDE,
              title: 'Error',
              desc: 'Have some problem please try again',
              descTextStyle: const TextStyle(fontSize: 20),
              btnOkOnPress: () {},
              buttonsTextStyle: const TextStyle(fontSize: 20),
              btnOkText: 'OK',
              width: width! * .2,
            ).show();
          }
        } catch (e) {
          print(e);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getUser() async{
    final dio = Dio();
    const url = 'http://localhost:5000/user';
    try{
      final response =  await dio.get(url);
      userList = response.data;
      print("llll ${userList}");
    }catch (e){
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('erere');
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Personal Information',
              style: TextStyle(fontSize: 30),
            ),
            automaticallyImplyLeading: false,
            centerTitle: true,
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.person),
                ),
                Tab(
                  icon: Icon(Icons.menu_book),
                ),
                Tab(
                  icon: Icon(Icons.work),
                ),
              ],
            ),
            actions: [
              /*DropdownButton<DropdownItem>(
                hint: const Text('Select an item'),
                value: selectedItem,
                dropdownColor: Colors.red.withOpacity(0),
                onChanged: (DropdownItem? newValue) {
                  setState(() {
                    selectedItem = newValue!;
                  });
                },
                items: items.map((DropdownItem item) {
                  return DropdownMenuItem<DropdownItem>(
                    value: item,
                    child: Row(
                      children: [
                        Image.asset(
                          item.imagePath!,fit: BoxFit.cover,
                        ),
                        //Text(item.label!),
                      ],
                    ),
                  );
                }).toList(),
              ),*/
              IconButton(onPressed: () {
                setState(() {
                  
                });
              }, icon: const Icon(Icons.list)),
              IconButton(
                onPressed: () {
                  setState(() {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title:
                            const Text('Do you want to change your password?'),
                        actions: [
                          Column(
                            children: [
                              Container(
                                width: width! * .2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.blue.withOpacity(0),
                                ),
                                child: TextField(
                                  controller: oldPass,
                                  style: const TextStyle(fontSize: 20),
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    labelText: 'Old Password',
                                    labelStyle: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(padding: EdgeInsets.only(top: 10)),
                              Container(
                                width: width! * .2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.blue.withOpacity(0),
                                ),
                                child: TextField(
                                  controller: newPass,
                                  style: const TextStyle(fontSize: 20),
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    labelText: 'New Password',
                                    labelStyle: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(padding: EdgeInsets.only(top: 10)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green,
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (oldPass.text == newPass.text) {
                                            AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.ERROR,
                                              animType: AnimType.LEFTSLIDE,
                                              title: 'Error',
                                              desc:
                                                  'The new password must not be the same as the old password.',
                                              descTextStyle:
                                                  const TextStyle(fontSize: 20),
                                              btnOkOnPress: () {},
                                              buttonsTextStyle:
                                                  const TextStyle(fontSize: 20),
                                              btnOkText: 'OK',
                                              width: width! * .2,
                                            ).show();
                                          } else {
                                            checkPassword(widget.username,
                                                oldPass.text, widget.id, newPass.text);
                                          }
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.save,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red,
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          oldPass.clear();
                                          newPass.clear();
                                          Navigator.of(context).pop();
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  });
                },
                icon: const Icon(Icons.password),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Do you want to exit?'),
                          actions: [
                            Column(
                              children: [
                                const SizedBox(
                                  width: 300,
                                  height: 300,
                                  child: Image(
                                    image: AssetImage('assets/image/exit.gif'),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red,
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginFlipPage(),
                                              ),
                                            );
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.exit_to_app,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    });
                  },
                  icon: const Icon(Icons.settings))
            ],
          ),
          body: TabBarView(
            children: [
              FirstTabPage(userList: userList),
              const SecondTabPage(),
              const ThirdTabPage(),
            ],
          ),
        ),
      ),
    );
  }
}
