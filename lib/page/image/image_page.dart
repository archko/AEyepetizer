import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ImagePage extends StatelessWidget {
  ImagePage({Key? key, required this.imageUrl}) : super(key: key);
  final String imageUrl;
  final GlobalKey<ExtendedImageGestureState> gestureKey =
      GlobalKey<ExtendedImageGestureState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(imageUrl),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          //不加缩放时图片展示不全
          child: ExtendedImage.network(
            imageUrl,
            fit: BoxFit.contain,
            mode: ExtendedImageMode.gesture,
            extendedImageGestureKey: gestureKey,
            initGestureConfigHandler: (ExtendedImageState state) {
              return GestureConfig(
                minScale: 0.9,
                animationMinScale: 0.7,
                maxScale: 4.0,
                animationMaxScale: 4.5,
                speed: 1.0,
                inertialSpeed: 100.0,
                initialScale: 1.0,
                inPageView: false,
                initialAlignment: InitialAlignment.center,
                reverseMousePointerScrollDirection: true,
                gestureDetailsIsChanged: (GestureDetails? details) {
                  //print(details?.totalScale);
                },
              );
            },
          ),
        )
      ],
    );
  }
}
