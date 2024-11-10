import 'package:flutter/material.dart';

class ResumePage extends StatefulWidget {
  const ResumePage({super.key});

  @override
  State<ResumePage> createState() => _ResumePageState();
}

class _ResumePageState extends State<ResumePage> with TickerProviderStateMixin {
  double? width;
  double? height;
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(border: Border.all()),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: ClipOval(
                    child: Image.network(
                      'http://172.2.200.15/fos3/personpic/F01192.jpg',
                      fit: BoxFit.contain,
                      width: 100,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    //decoration: BoxDecoration(border: Border.all()),
                    child: const Text(
                      'ศิริเดช วงษณรัตน์',
                      style: TextStyle(fontSize: 80),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.blue,
            child: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(
                    icon: Icon(
                  Icons.person,
                  size: 50,
                )),
                Tab(icon: Icon(Icons.menu_book)),
                Tab(icon: Icon(Icons.work)),
              ],
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              indicatorColor: Colors.white,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Info',
                              style: TextStyle(fontSize: 50),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            /*SizedBox(
                              width: width! * .35,
                            ),*/
                            SizedBox(
                              width: width! * .4,
                              child: const Text(
                                'Name',
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width! * .4,
                              child: const Text(
                                'Siridet Wongnarat',
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            /*SizedBox(
                              width: width! * .35,
                            ),*/
                            SizedBox(
                              width: width! * .4,
                              child: const Text(
                                'Nickname',
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width! * .4,
                              child: const Text(
                                'Firstty',
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            /*SizedBox(
                              width: width! * .35,
                            ),*/
                            SizedBox(
                              width: width! * .4,
                              child: const Text(
                                'Birthday',
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width! * .4,
                              child: const Text(
                                '14 July 1996',
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            /*SizedBox(
                              width: width! * .35,
                            ),*/
                            SizedBox(
                              width: width! * .4,
                              child: const Text(
                                'Age',
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width! * .4,
                              child: const Text(
                                '28',
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Language',
                              style: TextStyle(
                                fontSize: 50,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            /*SizedBox(
                              width: width! * .35,
                            ),*/
                            SizedBox(
                              width: width! * .4,
                              child: const Text(
                                'Thai',
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width! * .4,
                              child: const Text(
                                'Excellent',
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            /*SizedBox(
                              width: width! * .35,
                            ),*/
                            SizedBox(
                              width: width! * .4,
                              child: const Text(
                                'English',
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width! * .4,
                              child: const Text(
                                'Good',
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            /*SizedBox(
                              width: width! * .35,
                            ),*/
                            SizedBox(
                              width: width! * .4,
                              child: const Text(
                                'German',
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width! * .4,
                              child: const Text(
                                'Fair',
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Contact',
                              style: TextStyle(
                                fontSize: 50,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            /*SizedBox(
                              width: width! * .35,
                            ),*/
                            SizedBox(
                              width: width! * .4,
                              child: const Text(
                                'Email : ',
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width! * .4,
                              child: const Text(
                                'siridet.wo1996@gmail.com',
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            /*SizedBox(
                              width: width! * .35,
                            ),*/
                            SizedBox(
                              width: width! * .4,
                              child: const Text(
                                'Tel : ',
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width! * .4,
                              child: const Text(
                                '0934576814',
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            /*SizedBox(
                              width: width! * .35,
                            ),*/
                            SizedBox(
                              width: width! * .4,
                              child: const Text(
                                'Address : ',
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width! * .4,
                              child: const Text(
                                'Phuket Thailand',
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const Center(child: Text("Transit")),
                const Center(child: Text("Bike")),
              ],
            ),
          )
        ],
      ),
    );
  }
}
