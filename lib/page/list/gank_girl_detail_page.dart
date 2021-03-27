import 'package:aeyepetizer/entity/gank_bean.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GankGirlDetailPage extends StatefulWidget {
  GankGirlDetailPage({Key key, this.bean}) : super(key: key);

  final GankBean bean;

  @override
  _GankGirlDetailPageState createState() => _GankGirlDetailPageState();
}

class _GankGirlDetailPageState extends State<GankGirlDetailPage> {
  Widget detail(GankBean gankBean) {
    if (gankBean.images != null && gankBean.images.length > 0) {
      return Stack(
        children: <Widget>[
          Scaffold(
            body: ListView(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      width: double.maxFinite,
                      child: CachedNetworkImage(
                        imageUrl: gankBean.images[0],
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 24, right: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Divider(height: 16, color: Colors.transparent),
                          Text('${widget.bean.author}',
                              style: TextStyle(
                                  fontSize: 24.0,
                                  color: Color(0x99000000),
                                  fontWeight: FontWeight.bold)),
                          Divider(height: 8, color: Colors.transparent),
                          Text("${widget.bean.title}",
                              style: TextStyle(
                                  fontSize: 16.0, color: Color(0x99000000))),
                          Divider(height: 8, color: Colors.transparent),
                          Text("${widget.bean.createdAt}",
                              style: TextStyle(
                                  fontSize: 13.0, color: Color(0x99000000))),
                          Divider(height: 8, color: Colors.transparent),
                          Text("${widget.bean.desc}",
                              style: TextStyle(
                                  fontSize: 16.0, color: Color(0x99000000))),
                          Divider(height: 16, color: Colors.transparent),
                          Divider(
                            thickness: 1,
                            color: Colors.black12,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
          ),
        ],
      );
    } else {
      return Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${widget.bean.author}',
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.blue)),
                        Text("  ${widget.bean.type}",
                            style: TextStyle(fontSize: 13.0)),
                        Text("  ${widget.bean.publishedAt}",
                            style: TextStyle(fontSize: 13.0)),
                      ],
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
                      child: Text("${widget.bean.desc}"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return detail(widget.bean);
  }
}
