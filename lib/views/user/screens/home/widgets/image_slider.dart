// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({
    Key? key,
    required this.imageCoverList,
  }) : super(key: key);

  final List<String> imageCoverList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      width: MediaQuery.of(context).size.width,
      child: CarouselSlider.builder(
        options: CarouselOptions(
          //height: 400,
          aspectRatio: 1,
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          onPageChanged: (index, reason) {
            // setState(() {
            //   _indexImage = index;
            // });
          },

          scrollDirection: Axis.horizontal,
          disableCenter: true,
        ),
        itemBuilder: (context, index, realIndex) => ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: FancyShimmerImage(
            imageUrl: imageCoverList[index],
          ),
        ),
        itemCount: imageCoverList.length,
      ),
    );
  }
}
