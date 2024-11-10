import 'dart:convert';
import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:firstty_app/page/firstpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginFlipPage extends StatefulWidget {
  const LoginFlipPage({super.key});

  @override
  State<LoginFlipPage> createState() => _LoginFlipPageState();
}

class _LoginFlipPageState extends State<LoginFlipPage>
    with SingleTickerProviderStateMixin {
  bool isFlipped = false;
  late AnimationController animationController;
  late Animation<double> animation;
  double? width;
  double? height;
  TextEditingController userName = TextEditingController();
  TextEditingController passWord = TextEditingController();
  TextEditingController userNameRegister = TextEditingController();
  TextEditingController passWordRegister = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController tel = TextEditingController();
  bool errUser = false;
  bool errPass = false;
  bool errUserRegis = false;
  bool errPassRegis = false;
  bool errfname = false;
  bool errlname = false;
  bool errtel = false;
  bool saveLoad = false;

  Future<void> saveData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getString('userName') == userNameRegister.text) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('This User Already Exist'),
          actions: [
            Column(
              children: [
                const SizedBox(
                  width: 300,
                  height: 300,
                  child: Image(
                    image: AssetImage('assets/image/no.gif'),
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
                        color: Colors.green,
                      ),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
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
    } else {
      await preferences.setString('userName', userNameRegister.text);
      await preferences.setString('passWord', passWordRegister.text);
      saveLoad = false;
      Future.delayed(
        const Duration(seconds: 2),
        () {
          setState(() {
            saveLoad = true;
          });
        },
      );
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: saveLoad ? const Text('Saving...') : const Text('Saved'),
          actions: [
            Column(
              children: [
                const SizedBox(
                  width: 300,
                  height: 300,
                  child: Image(
                    image: AssetImage('assets/image/correct.gif'),
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
                            userName.text = userNameRegister.text;
                            userNameRegister.clear();
                            passWordRegister.clear();
                            isFlipped = false;
                            animationController.reverse();
                            Navigator.of(context).pop();
                          });
                        },
                        icon: const Icon(
                          Icons.thumb_up,
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
    }
  }

  Future<void> login() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getString('userName') == null ||
        preferences.getString('userName')!.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Have No Data'),
          content: const Text('Please Register'),
          actions: [
            Column(
              children: [
                const SizedBox(
                  width: 300,
                  height: 300,
                  child: Image(
                    image: AssetImage('assets/image/nodata.gif'),
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
    } else {
      setState(() {
        String user = preferences.getString('userName') ?? '';
        String pass = preferences.getString('passWord') ?? '';
        if (userName.text == user && passWord.text == pass) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => FirstPage(id: '', pass: '', username: ''),
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Username or Password'),
              content: const Text('Not Correct'),
              actions: [
                Column(
                  children: [
                    const SizedBox(
                      width: 300,
                      height: 300,
                      child: Image(
                        image: AssetImage('assets/image/detect.gif'),
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
        }
      });
    }
  }

  void flip() {
    if (isFlipped) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
    setState(() {
      isFlipped = !isFlipped;
    });
  }

  Future<void> checkLogin(String username, String pass) async {
    final dio = Dio();
    final url = 'http://localhost:5000/find/$username';
    try {
      final response = await dio.get(url);
      if (response.data[0]['username'] == '') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.LEFTSLIDE,
          title: 'Error',
          desc: 'Have no this username in database',
          descTextStyle: const TextStyle(fontSize: 20),
          btnOkOnPress: () {},
          buttonsTextStyle: const TextStyle(fontSize: 20),
          btnOkText: 'OK',
          width: width! * .2,
        ).show();
      } else {
        if (response.data[0]['password'] != pass) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.LEFTSLIDE,
            title: 'Error',
            desc: 'Password not correct',
            descTextStyle: const TextStyle(fontSize: 20),
            btnOkOnPress: () {},
            buttonsTextStyle: const TextStyle(fontSize: 20),
            btnOkText: 'OK',
            width: width! * .2,
          ).show();
        } else {
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FirstPage(
                id: response.data[0]['id'].toString(),
                pass: response.data[0]['password'],
                username: response.data[0]['username'],
              ),
            ),
          );
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> insertUser(
    String username,
    String password,
    String firstname,
    String lastname,
    String tel,
  ) async {
    final dio = Dio();
    const url = 'http://localhost:5000/insert';

    try {
      final response = await dio.post(
        url,
        data: {
          'username': username,
          'password': password,
          'firstname': firstname,
          'lastname': lastname,
          'tel': tel,
        },
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
            userName.text = userNameRegister.text;
            userNameRegister.clear();
            passWordRegister.clear();
            isFlipped = false;
            animationController.reverse();
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
          desc: 'Can not Register',
          descTextStyle: const TextStyle(fontSize: 20),
          btnOkOnPress: () {},
          buttonsTextStyle: const TextStyle(fontSize: 20),
          btnOkText: 'OK',
          width: width! * .2,
        ).show();
      }
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.WARNING,
        animType: AnimType.LEFTSLIDE,
        title: 'Warning',
        desc: 'Database has problem',
        descTextStyle: const TextStyle(fontSize: 20),
        btnOkOnPress: () {},
        buttonsTextStyle: const TextStyle(fontSize: 20),
        btnOkText: 'OK',
        width: width! * .2,
      ).show();
    }
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    animation = Tween<double>(begin: 0, end: 1).animate(animationController);
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/BGPC1.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: width! * .9,
              height: height! * .95,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  AnimatedBuilder(
                    animation: animationController,
                    builder: (context, child) {
                      final angle = animationController.value * pi;
                      return Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(angle),
                        child: animationController.value <= 0.5
                            ? Container(
                                width: width! * .9,
                                height: height! * .95,
                                color: Colors.blue.withOpacity(0.5),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    AnimatedTextKit(
                                      repeatForever: true,
                                      animatedTexts: [
                                        WavyAnimatedText(
                                          'Login',
                                          textStyle: const TextStyle(
                                            fontSize: 50,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                          speed: const Duration(
                                            milliseconds: 500,
                                          ),
                                        ),
                                      ],
                                      isRepeatingAnimation: true,
                                    ),
                                    Container(
                                      width: width! * .3,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.blue.withOpacity(0),
                                      ),
                                      child: TextField(
                                        controller: userName,
                                        style: const TextStyle(fontSize: 20),
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          labelText: 'Username',
                                          labelStyle: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          errorText: !errUser
                                              ? null
                                              : "Cant't be empty",
                                          errorBorder: const OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                          errorStyle: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            color: Colors.red[900],
                                          ),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            if (userName.text.isEmpty) {
                                              errUser = true;
                                            } else {
                                              errUser = false;
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    Container(
                                      width: width! * .3,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.blue.withOpacity(0),
                                      ),
                                      child: TextField(
                                        controller: passWord,
                                        style: const TextStyle(fontSize: 20),
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          labelText: 'Password',
                                          labelStyle: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          errorText: !errPass
                                              ? null
                                              : "Cant't be empty",
                                          errorBorder: const OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                          errorStyle: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            color: Colors.red[900],
                                          ),
                                        ),
                                        obscureText: true,
                                        onSubmitted: (value) {
                                          setState(() {
                                            if (userName.text.isEmpty) {
                                              errUser = true;
                                            } else {
                                              errUser = false;
                                            }
                                            if (passWord.text.isEmpty) {
                                              errPass = true;
                                            } else {
                                              errPass = false;
                                            }
                                            if (userName.text.isNotEmpty &&
                                                passWord.text.isNotEmpty) {
                                              checkLogin(
                                                  userName.text, passWord.text);
                                            }
                                          });
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            if (passWord.text.isEmpty) {
                                              errPass = true;
                                            } else {
                                              errPass = false;
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    Container(
                                      width: 150,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          setState(() {
                                            if (userName.text.isEmpty) {
                                              errUser = true;
                                            } else {
                                              errUser = false;
                                            }
                                            if (passWord.text.isEmpty) {
                                              errPass = true;
                                            } else {
                                              errPass = false;
                                            }
                                            if (userName.text.isNotEmpty &&
                                                passWord.text.isNotEmpty) {
                                              checkLogin(
                                                  userName.text, passWord.text);
                                            }
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.deepPurple[300],
                                        ),
                                        icon: const Icon(Icons.save),
                                        label: const Text(
                                          'Save',
                                          style: TextStyle(fontSize: 25),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()..rotateY(pi),
                                child: Container(
                                  width: width! * .9,
                                  height: height! * .9,
                                  color: Colors.yellow.withOpacity(0.5),
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      AnimatedTextKit(
                                        repeatForever: true,
                                        animatedTexts: [
                                          TypewriterAnimatedText(
                                            'Register',
                                            textStyle: const TextStyle(
                                              fontSize: 50,
                                              color: Colors.white,
                                            ),
                                            speed: const Duration(
                                              milliseconds: 500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: width! * .3,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.purple.withOpacity(0),
                                        ),
                                        child: TextField(
                                          controller: userNameRegister,
                                          style: const TextStyle(fontSize: 20),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            labelText: 'Username',
                                            labelStyle: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            errorText: !errUserRegis
                                                ? null
                                                : "Cant't be empty",
                                            errorBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                            ),
                                            errorStyle: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              color: Colors.red[900],
                                            ),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              if (userNameRegister
                                                  .text.isEmpty) {
                                                errUserRegis = true;
                                              } else {
                                                errUserRegis = false;
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                      Container(
                                        width: width! * .3,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.purple.withOpacity(0),
                                        ),
                                        child: TextField(
                                          controller: passWordRegister,
                                          style: const TextStyle(fontSize: 20),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            labelText: 'Password',
                                            labelStyle: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            errorText: !errPassRegis
                                                ? null
                                                : "Cant't be empty",
                                            errorBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                            ),
                                            errorStyle: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              color: Colors.red[900],
                                            ),
                                          ),
                                          obscureText: true,
                                          onChanged: (value) {
                                            setState(() {
                                              if (passWordRegister
                                                  .text.isEmpty) {
                                                errPassRegis = true;
                                              } else {
                                                errPassRegis = false;
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                      Container(
                                        width: width! * .3,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.purple.withOpacity(0),
                                        ),
                                        child: TextField(
                                          controller: firstName,
                                          style: const TextStyle(fontSize: 20),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            labelText: 'Firstname',
                                            labelStyle: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            errorText: !errUserRegis
                                                ? null
                                                : "Cant't be empty",
                                            errorBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                            ),
                                            errorStyle: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              color: Colors.red[900],
                                            ),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              if (firstName.text.isEmpty) {
                                                errfname = true;
                                              } else {
                                                errfname = false;
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                      Container(
                                        width: width! * .3,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.purple.withOpacity(0),
                                        ),
                                        child: TextField(
                                          controller: lastName,
                                          style: const TextStyle(fontSize: 20),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            labelText: 'Lastname',
                                            labelStyle: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            errorText: !errUserRegis
                                                ? null
                                                : "Cant't be empty",
                                            errorBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                            ),
                                            errorStyle: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              color: Colors.red[900],
                                            ),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              if (lastName.text.isEmpty) {
                                                errlname = true;
                                              } else {
                                                errlname = false;
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                      Container(
                                        width: width! * .3,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.purple.withOpacity(0),
                                        ),
                                        child: TextField(
                                          controller: tel,
                                          style: const TextStyle(fontSize: 20),
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            labelText: 'Telephone',
                                            labelStyle: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            errorText: !errUserRegis
                                                ? null
                                                : "Cant't be empty",
                                            errorBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                            ),
                                            errorStyle: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              color: Colors.red[900],
                                            ),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              if (tel.text.isEmpty) {
                                                errtel = true;
                                              } else {
                                                errtel = false;
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                      Container(
                                        width: 160,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.purple[200]),
                                          onPressed: () {
                                            setState(() {
                                              if (userNameRegister
                                                  .text.isEmpty) {
                                                errUserRegis = true;
                                              } else {
                                                errUserRegis = false;
                                              }
                                              if (passWordRegister
                                                  .text.isEmpty) {
                                                errPassRegis = true;
                                              } else {
                                                errPassRegis = false;
                                              }
                                              if (firstName.text.isEmpty) {
                                                errfname = true;
                                              } else {
                                                errfname = false;
                                              }
                                              if (lastName.text.isEmpty) {
                                                errlname = true;
                                              } else {
                                                errlname = false;
                                              }
                                              if (tel.text.isEmpty) {
                                                errtel = true;
                                              } else {
                                                errtel = false;
                                              }
                                              if (userNameRegister.text.isNotEmpty &&
                                                  passWordRegister
                                                      .text.isNotEmpty &&
                                                  firstName.text.isNotEmpty &&
                                                  lastName.text.isNotEmpty &&
                                                  tel.text.isNotEmpty) {
                                                insertUser(
                                                    userNameRegister.text,
                                                    passWordRegister.text,
                                                    firstName.text,
                                                    lastName.text,
                                                    tel.text);
                                              }
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.app_registration,
                                          ),
                                          label: const Text(
                                            'Register',
                                            style: TextStyle(fontSize: 25),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      );
                    },
                  ),
                  Positioned(
                    left: width! / 2.25 - 25,
                    child: IconButton(
                      color: !isFlipped ? Colors.amber : Colors.black,
                      onPressed: flip,
                      icon: Icon(
                        !isFlipped
                            ? Icons.change_circle_outlined
                            : Icons.change_circle_outlined,
                        size: 50,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
