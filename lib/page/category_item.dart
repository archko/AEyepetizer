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
      margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image(
                  image: CachedNetworkImageProvider('${bean.bgPicture}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.only(left: 10.0),
              height: 150.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('${bean.name}',
                      style: TextStyle(fontSize: 20.0, color: Colors.blue)),
                  Text('${bean.name}'),
                  Text('${bean.description}'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
