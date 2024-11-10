import 'package:firstty_app/instagram/feedpage.dart';
import 'package:firstty_app/instagram/loginins2page.dart';
import 'package:flutter/material.dart';

class LoginInsPage extends StatefulWidget {
  const LoginInsPage({super.key});

  @override
  State<LoginInsPage> createState() => _LoginInsPageState();
}

class _LoginInsPageState extends State<LoginInsPage> {
  double? width;
  double? height;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Row(
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
                const Padding(padding: EdgeInsets.only(top: 50)),
                const CircleAvatar(
                  radius: 50,
                  foregroundImage: AssetImage('assets/image/F01192.jpg'),
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                const Text('Firstty', style: TextStyle(fontSize: 20)),
                const Padding(padding: EdgeInsets.only(top: 20)),
                SizedBox(
                  width: width! * .7,
                  height: 50,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.blue),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FeedPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Log in',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                TextButton(
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginIns2Page(),
                        ),
                      );
                    });
                  },
                  child: const Text(
                    'Switch accounts',
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
        persistentFooterButtons: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?'),
                TextButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: const Text(
                    'Sign up.',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
