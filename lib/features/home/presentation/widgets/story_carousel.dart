import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hotelino/core/utils/networkUrl.dart';

class StoryCarousel extends StatefulWidget {
  final List<String> images;
  final List<String> title;
  const StoryCarousel({super.key, required this.images, required this.title});

  @override
  State<StoryCarousel> createState() => _StoryCarouselState();
}

class _StoryCarouselState extends State<StoryCarousel> {
  int _courrentIndex = 0;
  late Timer _timer;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  void _autoSlider() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        if (_courrentIndex < widget.images.length - 1) {
          _courrentIndex++;
        } else {
          _courrentIndex = 0;
        }
        _carouselController.animateToPage(_courrentIndex);
      });
    });
  }

  /*   void _nextImage() {
    setState(() {
      if (_courrentIndex < widget.images.length - 1) {
        _courrentIndex++;
      } else {
        _courrentIndex = 0;
      }
      _carouselController.animateToPage(_courrentIndex);
    });
  }

  void _prevImage() {
    setState(() {
      if (_courrentIndex > 0) {
        _courrentIndex--;
      } else {
        _courrentIndex = widget.images.length - 1;
      }
      _carouselController.animateToPage(_courrentIndex);
    });
  } */

  @override
  void initState() {
    super.initState();
    _autoSlider();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.all(8),
      child: Stack(
        children: [
          CarouselSlider(
            carouselController: _carouselController,
            options: CarouselOptions(
              height: 250,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              autoPlay: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _courrentIndex = index;
                });
              },
            ),
            items: widget.images.map((imageUrl) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(netwrkUrl(imageUrl), fit: BoxFit.cover),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.75),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          Positioned(
            top: 10,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: List.generate(widget.images.length, (index) {
                  return Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      height: 4,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      child: Container(
                        height: 4,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          color: _courrentIndex >= index
                              ? Colors.white.withValues(alpha: 0.75)
                              : Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Text(
              widget.title[_courrentIndex],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
