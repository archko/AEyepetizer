import 'package:aeyepetizer/entity/gank_bean.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GankGirlListImageItem extends StatelessWidget {
  GankGirlListImageItem({Key key, this.bean, this.onPressed}) : super(key: key);
  final GankBean bean;
  final VoidCallback onPressed;

  void detail(GankBean bean) {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      //margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
      child: Material(
        child: Ink(
          //INK可以实现装饰容器，实现矩形  设置背景色
          color: Colors.white,
          child: InkWell(
            onTap: () {},
            child: Container(
              child: Stack(
                children: [
                  RepaintBoundary(
                    child: Container(
                      margin: const EdgeInsets.only(top: 1.0),
                      height: 480,
                      width: double.maxFinite,
                      child: CachedNetworkImage(
                        fit: BoxFit.fitWidth,
                        imageUrl: bean.images[0],
                        placeholder: (context, url) => Container(
                          alignment: Alignment.center,
                          color: Color(0x1f000000),
                          padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                          /*child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            backgroundColor: Colors.deepPurple[600],
                          ),*/
                        ),
                        errorWidget: (
                          BuildContext context,
                          String url,
                          dynamic error,
                        ) =>
                            Container(
                          alignment: Alignment.center,
                          color: Color(0x1f000000),
                          padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 480,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Divider(height: 24),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 16, right: 16),
                              child: Text('${bean.author}',
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.blue)),
                            ),
                            Text('${bean.title}',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white)),
                          ],
                        ),
                        Divider(height: 4),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 16, right: 16),
                            child: Text(
                              "${bean.desc}",
                              style: TextStyle(
                                  fontSize: 16.0, color: Color(0xffffffff)),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
