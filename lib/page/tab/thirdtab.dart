import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ThirdTabPage extends StatefulWidget {
  const ThirdTabPage({super.key});

  @override
  State<ThirdTabPage> createState() => _ThirdTabPageState();
}

class _ThirdTabPageState extends State<ThirdTabPage> {
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];
  int activeIndex = 0;
  final controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselSlider.builder(
              itemCount: imgList.length,
              carouselController: controller,
              options: CarouselOptions(
                height: 400,
                initialPage: 0,
                //viewportFraction: 1,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                onPageChanged: (index, reason) => setState(
                  () => activeIndex = index,
                ),
              ),
              itemBuilder: (context, index, realIndex) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  color: Colors.grey,
                  child: Image.network(
                    imgList[index],
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 30,
            ),
            AnimatedSmoothIndicator(
              activeIndex: activeIndex,
              count: imgList.length,
              onDotClicked: (index) {
                setState(() {
                  controller.animateToPage(index);
                });
              },
              effect: const WormEffect(type: WormType.thinUnderground),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      controller.previousPage(duration: Duration(milliseconds: 500));
                    });
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: 25,
                  ),
                ),
                SizedBox(
                  width: 32,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      controller.nextPage(duration: Duration(milliseconds: 500));
                    });
                  },
                  child: Icon(
                    Icons.arrow_forward,
                    size: 25,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
