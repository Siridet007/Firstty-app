import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double? width;
  double? height;
  bool isMoved = false;
  TextEditingController userName = TextEditingController();
  TextEditingController passWord = TextEditingController();
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
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    alignment:
                        isMoved ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      width: width! * .45,
                      height: height! * .9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: !isMoved
                            ? Colors.amber[100]!.withOpacity(0.5)
                            : Colors.grey[500]!.withOpacity(0.5),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          !isMoved
                              ? const Text(
                                  'Login',
                                  style: TextStyle(fontSize: 30,),
                                )
                              : const Text(
                                  'Register',
                                  style: TextStyle(fontSize: 30),
                                ),
                          Container(
                            width: width! * .3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                            ),
                            child: TextField(
                              controller: userName,
                              style: const TextStyle(fontSize: 25),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                labelText: 'Username',
                              ),
                            ),
                          ),
                          Container(
                            width: width! * .3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                            ),
                            child: TextField(
                              controller: passWord,
                              style: const TextStyle(fontSize: 25),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                labelText: 'Password',
                              ),
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
                                setState(() {});
                              },
                              icon: const Icon(Icons.save),
                              label: const Text(
                                'Save',
                                style: TextStyle(fontSize: 25),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: width! * .433,
                    child: IconButton(
                      color: !isMoved ? Colors.amber : Colors.black,
                      onPressed: () {
                        setState(() {
                          isMoved = !isMoved;
                        });
                      },
                      icon: Icon(
                        !isMoved ? Icons.sunny : Icons.nightlight,
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
}
