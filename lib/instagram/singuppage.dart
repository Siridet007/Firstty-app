import 'package:firstty_app/instagram/loginins2page.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  double? width;
  double? height;
  TextEditingController email = TextEditingController();
  TextEditingController passWord = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController userName = TextEditingController();

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
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        Text(
                          'Sign up to see photos and videos',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          'from your friends.',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey[600],
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 30)),
                        ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.blue),
                            maximumSize: MaterialStatePropertyAll(
                              Size.fromWidth(310),
                            ),
                          ),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.facebook),
                              Padding(padding: EdgeInsets.only(left: 10)),
                              Text(
                                'Log in with Facebook',
                                style: TextStyle(fontSize: 25),
                              ),
                            ],
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        Row(
                          children: [
                            SizedBox(
                              width: width! * .25,
                              child: const Divider(),
                            ),
                            const Padding(padding: EdgeInsets.only(left: 10)),
                            const Text(
                              'OR',
                              style: TextStyle(fontSize: 25),
                            ),
                            const Padding(padding: EdgeInsets.only(left: 10)),
                            SizedBox(
                              width: width! * .25,
                              child: const Divider(),
                            ),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        Container(
                          width: width! * .6,
                          color: Colors.grey[200],
                          child: TextField(
                            controller: email,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Mobile Number or Email',
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        Container(
                          width: width! * .6,
                          color: Colors.grey[200],
                          child: TextField(
                            controller: passWord,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Password',
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        Container(
                          width: width! * .6,
                          color: Colors.grey[200],
                          child: TextField(
                            controller: name,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Full name',
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        Container(
                          width: width! * .6,
                          color: Colors.grey[200],
                          child: TextField(
                            controller: userName,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Username',
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        Stack(
                          children: [
                            Container(
                              width: 340,
                              alignment: Alignment.topCenter,
                              child: const Text(
                                'People who use our service may have uploaded',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  const Text(
                                    'your contact information to Instagram.',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Learn More',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.blue[800],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            SizedBox(
                              width: 320,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'By signing up, you agree to our',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Terms,',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.blue[800],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: SizedBox(
                                width: 320,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Privacy',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.blue[800],
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Policy,',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.blue[800],
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      'and',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Cookies Policy',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.blue[800],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: width! * .6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue),
                            onPressed: () {},
                            child: const Text(
                              'Sign up',
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Have an account?',
                  style: TextStyle(fontSize: 20),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginIns2Page(),
                      ),
                    );
                  },
                  child: const Text(
                    'Log in',
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
