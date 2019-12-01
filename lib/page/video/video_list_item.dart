import 'package:aeyepetizer/entity/video_item.dart';
import 'package:aeyepetizer/utils/string_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class VideoListItem extends StatelessWidget {
  VideoListItem({this.bean, this.onPressed}) : super();
  final VideoItem bean;
  final VoidCallback onPressed;

  void detail(String bean) {}

  @override
  Widget build(BuildContext context) {
    var titleContainer;
    if (bean.data.dataType == "TextCard") {
      titleContainer = Container(
        height: 45,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: Text(
                  '${StringUtils.isEmpty(bean.data.text) ? "" : bean.data.text}',
                  style: TextStyle(fontSize: 20.0, color: Colors.cyanAccent)),
            ),
          ],
        ),
      );
    } else {
      titleContainer = Container(
        height: 160,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text('${bean.data.title}',
                style: TextStyle(fontSize: 20.0, color: Colors.blue)),
            Expanded(
              child: Text(
                  '${StringUtils.isEmpty(bean.data.description) ? "" : bean.data.description}',
                  style: TextStyle(fontSize: 14.0, color: Colors.cyanAccent)),
            ),
          ],
        ),
      );
    }
    if (bean.data.dataType == "TextCard") {
      return Card(
        color: Colors.black26,
        margin: const EdgeInsets.all(4.0),
        child: Stack(
          children: <Widget>[
            titleContainer,
          ],
        ),
      );
    } else {
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
            titleContainer,
          ],
        ),
      );
    }
  }
}
