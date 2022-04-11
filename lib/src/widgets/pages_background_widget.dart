import 'package:flutter/material.dart';

class PagesBackground extends StatelessWidget {

  final Widget child;
  final double height;

  const PagesBackground({
    Key? key, 
    required this.child, 
    required this.height
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            child: Container(
              width: double.infinity,
              height: height / 2,
              child: Image(
                image: AssetImage('assets/homewallpaper.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          CustomScrollView(
            physics: ClampingScrollPhysics(), 
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: child,
              )
            ],
          )
        ],
      ),
    );
  }
}