import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
class HomeBackground extends StatelessWidget {
  const HomeBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            left: -70,
            child: PhotoView(
              tightMode: true,
              customSize: Size(size.width * 2, size.width * 2),
              imageProvider: AssetImage("images/background.png"),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
