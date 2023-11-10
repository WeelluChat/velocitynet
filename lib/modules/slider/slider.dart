import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:velocity_net/constants/api_constants.dart';
import 'package:velocity_net/service/api.dart'; // Importe seu serviço de API aqui
import 'dart:convert';

class SliderComponent extends StatefulWidget {
  const SliderComponent({super.key});

  @override
  State<SliderComponent> createState() => _SliderComponentState();
}

class _SliderComponentState extends State<SliderComponent> {
  List<String> sliderList = [];

  slider() async {
    final sliderData = await Api().getSlider();
    final List<dynamic> jsonData = json.decode(sliderData);
    for (final item in jsonData) {
      if (item is Map<String, dynamic> && item.containsKey('name')) {
        sliderList.add("${ApiConstants.baseUrlUploads}/${item['name']}");
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    slider();
  }

  @override
  Widget build(BuildContext context) {
    if (sliderList.isNotEmpty) {
      return ImageSlideshow(
        width: double.infinity,
        height: MediaQuery.of(context).size.width < 1280 ? 500 : 600,
        initialPage: 0,
        indicatorColor: Colors.blue,
        indicatorBackgroundColor: Colors.grey,
        autoPlayInterval: 10000,
        isLoop: true,
        children: sliderList.map((url) {
          return Image.network(
            url,
            fit: BoxFit.fill,
          );
        }).toList(),
      );
    } else {
      return const CircularProgressIndicator();
    }
  }
}
