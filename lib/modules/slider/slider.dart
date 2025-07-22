import 'package:flutter/material.dart';
import 'package:velocity_net/constants/api_constants.dart';
import 'package:velocity_net/service/api.dart';
import 'dart:convert';

class SliderComponent extends StatefulWidget {
  const SliderComponent({super.key});

  @override
  State<SliderComponent> createState() => _SliderComponentState();
}

class _SliderComponentState extends State<SliderComponent> {
  List<String> sliderDesktopList = [];
  List<String> sliderMobileList = [];

  final PageController _pageController = PageController();
  int _currentPage = 0;

  Future<void> loadSliders() async {
    final sliderData = await Api().getSlider();
    final List<dynamic> jsonData = json.decode(sliderData);

    sliderDesktopList.clear();
    sliderMobileList.clear();

    for (final item in jsonData) {
      if (item is Map<String, dynamic>) {
        final desktop = item['desktop'];
        final mobile = item['mobile'];

        if (desktop != null && desktop['name'] != null) {
          sliderDesktopList.add("${ApiConstants.baseUrlUploads}/${desktop['name']}");
        }

        if (mobile != null && mobile['name'] != null) {
          sliderMobileList.add("${ApiConstants.baseUrlUploads}/${mobile['name']}");
        }
      }
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadSliders();
  }

  void _nextPage() {
    if (_currentPage < _currentSliderList.length - 1) {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _currentPage--;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  List<String> get _currentSliderList {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth < 768 ? sliderMobileList : sliderDesktopList;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final sliderList = _currentSliderList;

        if (sliderList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final double height = constraints.maxWidth < 1500 ? 450 : 540;

        return SizedBox(
          height: height,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount: sliderList.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  return Image.network(
                    sliderList[index],
                    fit: BoxFit.cover,
                  );
                },
              ),
              Positioned(
                left: 16,
                child: IconButton(
                  onPressed: _previousPage,
                  icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                ),
              ),
              Positioned(
                right: 16,
                child: IconButton(
                  onPressed: _nextPage,
                  icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
