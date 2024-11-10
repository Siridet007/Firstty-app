import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:page_flip/page_flip.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  double? width;
  double? height;
  final slideController = CarouselController();
  final pageFlipController = GlobalKey<PageFlipWidgetState>();
  final PageController _pageController = PageController();
  bool likeTap = false;
  bool commentTap = false;
  bool shareTap = false;
  bool saveTap = false;
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.camera_alt_outlined,
              color: Colors.black,
              size: 35,
            ),
          ),
          centerTitle: true,
          title: SizedBox(
            width: width! * .3,
            child: Image.asset(
              'assets/image/Instagram_logo.png',
            ),
          ),
          actions: [
            Stack(
              children: [
                Container(
                  width: 50,
                ),
                Positioned(
                  top: 11,
                  left: 16,
                  child: InkWell(
                    onTap: () {},
                    child: SizedBox(
                      width: 30,
                      child: Image.asset(
                        'assets/image/tv.png',
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 14,
                  left: 35,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(left: 20)),
            InkWell(
              onTap: () {},
              child: SizedBox(
                width: width! * .05,
                child: Image.asset(
                  'assets/image/direct.png',
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(left: 20)),
          ],
        ),
        body: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 20)),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.orange,
                                    Colors.pink,
                                    Colors.purple
                                  ],
                                ),
                                shape: BoxShape.circle),
                            child: Padding(
                              padding: const EdgeInsets.all(3),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/image/F01192.jpg',
                                  fit: BoxFit.cover,
                                  width: 80,
                                  height: 80,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text('${index + 1}')
                      ],
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: height,
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            width: width,
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 25,
                                      foregroundImage:
                                          AssetImage('assets/image/F01192.jpg'),
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(left: 10)),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              'Firstty',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            SizedBox(
                                              width: width! * .04,
                                              child: Image.asset(
                                                'assets/image/check.png',
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Text(
                                          'Phuket_Thailand',
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.more_horiz),
                                ),
                              ],
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 10)),
                          SizedBox(
                            height: 400,
                            width: width,
                            child: PageView.builder(
                              controller: _pageController,
                              itemCount: imgList.length,
                              itemBuilder: (context, index) {
                                return Image.network(
                                  imgList[index],
                                  fit: BoxFit.cover,
                                );
                              },
                              onPageChanged: (index) {
                                // You can manage other things when the page changes, if needed
                              },
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 10)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: width! * .35,
                                child: Row(
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.only(left: 10)),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          likeTap = !likeTap;
                                        });
                                      },
                                      child: likeTap
                                          ? SizedBox(
                                              width: 30,
                                              child: Image.asset(
                                                'assets/image/liked.png',
                                                color: Colors.red,
                                              ),
                                            )
                                          : SizedBox(
                                              width: 30,
                                              child: Image.asset(
                                                'assets/image/like.png',
                                              ),
                                            ),
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(left: 10)),
                                    SizedBox(
                                      width: 25,
                                      child: Image.asset(
                                        'assets/image/comment.png',
                                      ),
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(left: 10)),
                                    SizedBox(
                                      width: 25,
                                      child: Image.asset(
                                        'assets/image/direct.png',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: width! * .3,
                                alignment: Alignment.center,
                                child: SmoothPageIndicator(
                                  controller: _pageController,
                                  count: imgList.length,
                                  effect: const ScrollingDotsEffect(
                                    dotHeight: 10,
                                    dotWidth: 10,
                                    activeDotColor: Colors.blue,
                                    dotColor: Colors.grey,
                                  ),
                                ),
                              ),
                              Container(
                                width: width! * .3,
                                padding: const EdgeInsets.only(right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          saveTap = !saveTap;
                                        });
                                      },
                                      child: saveTap
                                          ? SizedBox(
                                              width: 25,
                                              child: Image.asset(
                                                'assets/image/saved.png',
                                                color: Colors.yellow,
                                              ),
                                            )
                                          : SizedBox(
                                              width: 25,
                                              child: Image.asset(
                                                'assets/image/save.png',
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
