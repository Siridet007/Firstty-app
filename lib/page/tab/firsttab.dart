import 'dart:math';

import 'package:card_slider/card_slider.dart';
import 'package:flutter/material.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

class FirstTabPage extends StatefulWidget {
  List? userList;
  FirstTabPage({super.key,this.userList});

  @override
  State<FirstTabPage> createState() => _FirstTabPageState();
}

class _FirstTabPageState extends State<FirstTabPage> {
  final List<String> images = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];
  final pageController = PageController(
    viewportFraction: 0.3,
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              /*child: PageView.builder(
                controller: pageController,
                itemCount: 5,
                scrollDirection: Axis.vertical,
                onPageChanged: (value) {},
                itemBuilder: (context, index) {
                  double value = 1.0;
                  if (pageController.position.haveDimensions) {
                    value = pageController.page! - index;
                    if (value >= 0) {
                      double lower = 0;
                      double upper = pi / 2;
                      value = (upper - (value.abs() * (upper - lower)))
                          .clamp(lower, upper);
                      value = upper - value;
                      value *= -1;
                    }
                  } else {
                    if (index == 0) {
                      value = 0;
                    } else if (index == 1) {
                      value = -1;
                    }
                  }
                  return AnimatedBuilder(
                    animation: pageController,
                    builder: (context, child) {
                      return Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateX(value),
                        alignment: Alignment.center,
                        child: Card(
                          child: Image.network(images[index]),
                        ),
                      );
                    },
                    child: Card(),
                  );
                },
              ),*/
              child: VerticalCardPager(
                initialPage: 0,
                titles: [
                  for (int i = 0; i < images.length; i++) 'Page ${i + 1}',
                ],
                images: [
                  for (int i = 0; i < images.length; i++)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        images[i],
                        fit: BoxFit.cover,
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
