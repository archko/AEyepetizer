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
      margin: const EdgeInsets.all(4.0),
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
            height: 160,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('${bean.data.title}',
                    style: TextStyle(fontSize: 20.0, color: Colors.blue)),
                Expanded(
                  child: Text('${bean.data.description}',
                      style: TextStyle(fontSize: 14.0, color: Colors.cyanAccent)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
