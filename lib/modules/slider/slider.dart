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
  List<String> sliderList = [];
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isHoveringLeft = false;
  bool _isHoveringRight = false;

  slider() async {
    final sliderData = await Api().getSlider();
    final List<dynamic> jsonData = json.decode(sliderData);
    for (final item in jsonData) {
      print(item);
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

  void _nextPage() {
    if (_currentPage < sliderList.length - 1) {
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

  Widget _buildArrowButton({
    required bool isHovering,
    required VoidCallback onTap,
    required bool isLeft,
  }) {
    return MouseRegion(
      onEnter: (_) => setState(() {
        if (isLeft) _isHoveringLeft = true;
        else _isHoveringRight = true;
      }),
      onExit: (_) => setState(() {
        if (isLeft) _isHoveringLeft = false;
        else _isHoveringRight = false;
      }),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: isHovering
                  ? [Colors.blue.shade600, Colors.blueAccent.shade200]
                  : [Colors.black.withOpacity(0.4), Colors.black.withOpacity(0.2)],
            ),
            boxShadow: [
              if (isHovering)
                BoxShadow(
                  color: Colors.blue.withOpacity(0.5),
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
            ],
          ),
          padding: const EdgeInsets.all(12),
          child: Icon(
            isLeft ? Icons.arrow_back_ios_new : Icons.arrow_forward_ios,
            color: Colors.white,
            size: 28,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (sliderList.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    final double height =
        MediaQuery.of(context).size.width < 1280 ? 500 : 600;

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
                fit: BoxFit.fill,
              );
            },
          ),
          Positioned(
            left: 16,
            child: _buildArrowButton(
              isHovering: _isHoveringLeft,
              onTap: _previousPage,
              isLeft: true,
            ),
          ),
          Positioned(
            right: 16,
            child: _buildArrowButton(
              isHovering: _isHoveringRight,
              onTap: _nextPage,
              isLeft: false,
            ),
          ),
        ],
      ),
    );
  }
}
