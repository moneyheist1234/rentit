import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final List<String> imgList = [
    'assets/images/carousel/c_1.jpg',
    'assets/images/carousel/c_2.jpg',
    'assets/images/carousel/c_3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: CarouselSlider(
        items: imgList.map((path) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              path,
              fit: BoxFit.cover, // Ensure the image covers the entire area
              width: MediaQuery.of(context).size.width, // Occupy full width
            ),
          );
        }).toList(),
        options: CarouselOptions(
          initialPage: 0,
          height: 200.0,
          autoPlay: false,
          autoPlayInterval: const Duration(seconds: 3),
          enlargeCenterPage: true,
          enlargeFactor: 0.2,
          aspectRatio: 16 / 9,
          viewportFraction: 0.9, // Occupy entire width
        ),
      ),
    );
  }
}
