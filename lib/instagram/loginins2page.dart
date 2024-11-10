import 'package:firstty_app/instagram/singuppage.dart';
import 'package:flutter/material.dart';

import 'feedpage.dart';

class LoginIns2Page extends StatefulWidget {
  const LoginIns2Page({super.key});

  @override
  State<LoginIns2Page> createState() => _LoginIns2PageState();
}

class _LoginIns2PageState extends State<LoginIns2Page> {
  double? width;
  double? height;
  TextEditingController userName = TextEditingController();
  TextEditingController passWord = TextEditingController();
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width! * .5,
                          child: Image.asset(
                            'assets/image/Instagram_logo.png',
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 40)),
                        Container(
                          width: width! * .9,
                          color: Colors.grey[200],
                          child: TextField(
                            controller: userName,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Phone number, username or email',
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        Container(
                          width: width! * .9,
                          color: Colors.grey[200],
                          child: TextField(
                            controller: passWord,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Password',
                            ),
                          ),
                        ),
                        Container(
                          width: width! * .9,
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot password?',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        SizedBox(
                          width: width! * .9,
                          height: 50,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                userName.text.isEmpty || passWord.text.isEmpty
                                    ? Colors.blue[100]
                                    : Colors.blue,
                              ),
                            ),
                            onPressed: userName.text.isEmpty ||
                                    passWord.text.isEmpty
                                ? null
                                : () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const FeedPage(),
                                      ),
                                    );
                                  },
                            child: const Text(
                              'Log in',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 30)),
                        Row(
                          children: [
                            Image.asset(
                              'assets/image/facebook.png',
                              scale: 50,
                            ),
                            const Padding(padding: EdgeInsets.only(left: 10)),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Log in with Facebook',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 30)),
                        Row(
                          children: [
                            SizedBox(
                              width: width! * .4,
                              child: const Divider(),
                            ),
                            const Padding(padding: EdgeInsets.only(left: 10)),
                            const Text('OR'),
                            const Padding(padding: EdgeInsets.only(left: 10)),
                            SizedBox(
                              width: width! * .4,
                              child: const Divider(),
                            ),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 30)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account?',
                              style: TextStyle(color: Colors.grey),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SignupPage(),
                                    ),
                                  );
                                });
                              },
                              child: const Text(
                                'Sign up.',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: const BottomAppBar(
          child: SizedBox(
            height: 50,
            child: Center(
              child: Text('Instagram or Facebook'),
            ),
          ),
        ),
      ),
    );
  }
}
