import 'package:aeyepetizer/entity/acategory.dart';
import 'package:aeyepetizer/entity/trending.dart';
import 'package:aeyepetizer/entity/video_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class VideoListItem extends StatelessWidget {
  VideoListItem({this.bean, this.onPressed}) : super();
  final VideoItem bean;
  final VoidCallback onPressed;

  void detail(String bean) {}

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: <Widget>[
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image(
                image: CachedNetworkImageProvider('${bean.data.cover.feed}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('${bean.data.title}',
                    style: TextStyle(fontSize: 20.0, color: Colors.blue)),
                Text('${bean.data.description}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
