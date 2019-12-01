import 'package:aeyepetizer/entity/acategory.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  CategoryItem({this.bean, this.onPressed}) : super();
  final ACategory bean;
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
                image: CachedNetworkImageProvider('${bean.bgPicture}'),
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
                Text('${bean.name}',
                    style: TextStyle(fontSize: 20.0, color: Colors.blue)),
                Text('${bean.description}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
