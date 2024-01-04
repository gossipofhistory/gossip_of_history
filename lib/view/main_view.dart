import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gossip_of_history/widget/header_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainView extends StatefulWidget {
  MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CarouselController carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String title = "Gossip Of History";
    return Scaffold(
      backgroundColor: Colors.white,
      body: Title(
        color: Colors.black,
        title: title,
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/main_background.jpg"),
                  // opacity: 0.5,
                  fit: BoxFit.fill),
            ),
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Column(
                  children: [
                    HeaderWidget(),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: imageSlider(),
                    ),
                    // FirestoreTextWidget("view", "main", "text"),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  imageSlider() {
    return Column(
      children: [
        CarouselSlider(
          items: [
            Card(elevation: 16, child: Image.asset("assets/slider1.jpg"),color: Colors.transparent),
            Card(elevation: 16, child: Image.asset("assets/slider2.jpg"),color: Colors.transparent),
            Card(elevation: 16, child: Image.asset("assets/slider3.jpg"),color: Colors.transparent),
            Card(elevation: 16, child: Image.asset("assets/slider4.jpg"),color: Colors.transparent),
            Card(elevation: 16, child: Image.asset("assets/slider5.jpg"),color: Colors.transparent),
          ],
          options: CarouselOptions(
            height: 400,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 10),
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            scrollDirection: Axis.horizontal,
          ),
          carouselController: carouselController,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              iconSize: 100,
              color: Colors.black,
              onPressed: () => carouselController.previousPage(
                  duration: Duration(milliseconds: 500)),
              icon: Icon(Icons.chevron_left),
            ),
            IconButton(
              iconSize: 100,
              color: Colors.black,
              onPressed: () => carouselController.nextPage(
                  duration: Duration(milliseconds: 500)),
              icon: Icon(Icons.chevron_right),
            ),
          ],
        )
      ],
    );
  }
}
