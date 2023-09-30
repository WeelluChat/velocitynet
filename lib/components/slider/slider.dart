import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class SliderComponent extends StatefulWidget {
  const SliderComponent({super.key});

  @override
  State<SliderComponent> createState() => _SliderComponentState();
}

class _SliderComponentState extends State<SliderComponent> {
  @override
  Widget build(BuildContext context) {
    return ImageSlideshow(
      width: double.infinity,
      height: 600,
      initialPage: 0,
      indicatorColor: Colors.blue,
      indicatorBackgroundColor: Colors.grey,
      autoPlayInterval: 5000,
      isLoop: true,
      children: [
        Image.asset(
          'slider/slider1.png',
          fit: BoxFit.cover,
        ),
        Image.asset(
          'slider/slider2.png',
          fit: BoxFit.cover,
        ),
        Image.asset(
          'slider/slider2.png',
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
