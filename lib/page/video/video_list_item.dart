import 'package:aeyepetizer/entity/video_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/utils/string_utils.dart';

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
        //color: Colors.black26,
        margin: const EdgeInsets.all(4.0),
        child: new Material(
          child: new Ink(
            //INK可以实现装饰容器，实现矩形  设置背景色
            color: Colors.black,
            child: new InkWell(
              onTap: () {},
              child: new Container(
                child: Stack(
                  children: <Widget>[
                    titleContainer,
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return Card(
        //color: Colors.black26,
        margin: const EdgeInsets.all(4.0),
        child: new Material(
          child: new Ink(
            //INK可以实现装饰容器，实现矩形  设置背景色
            //color: Colors.black,
            child: new InkWell(
              child: new Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Image(
                          image: CachedNetworkImageProvider(
                              '${bean.data.cover.feed}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: titleContainer,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
      //return Card(
      //  margin: const EdgeInsets.all(4.0),
      //  child: Material(
      //    child: new Ink(
      //      color: Colors.black,
      //      child: new InkWell(
      //        child: Stack(
      //          children: <Widget>[
      //            Container(
      //              child: ClipRRect(
      //                borderRadius: BorderRadius.circular(5.0),
      //                child: Image(
      //                  image: CachedNetworkImageProvider(
      //                      '${bean.data.cover.feed}'),
      //                  fit: BoxFit.cover,
      //                ),
      //              ),
      //            ),
      //            Align(
      //              alignment: Alignment.bottomLeft,
      //              child: titleContainer,
      //            )
      //          ],
      //        ),
      //      ),
      //    ),
      //  ),
      //);
      //return Column(
      //    children: <Widget>[
      //      new Center(
      //        child:new Material(
      //          child: new InkWell(
      //            onTap: (){
      //            },
      //            child: new Container(//不要在这里设置背景色，for则会遮挡水波纹效果,如果设置的话尽量设置Material下面的color来实现背景色
      //              margin: EdgeInsets.all(0.0),
      //              width: 300.0,
      //              height: 100.0,
      //              child: RaisedButton(child: Text("111"),),
      //            ),
      //          ),
      //          color: Colors.yellow,
      //        ),
      //      ),
      //      new Center(
      //        child: new Material(
      //          child: new Ink(//INK可以实现装饰容器，实现矩形  设置背景色
      //            color: Colors.black,
      //            child:new InkWell(
      //              onTap: (){
      //                onPressed();
      //              },
      //              child: new Container(
      //                width: 300.0,
      //                height: 100.0,
      //              ),
      //            ),
      //          ),
      //        ),
      //      ),
      //      new Center(
      //        child: new Material(
      //          child: new Ink(//用ink圆角矩形
//    //            color: Colors.red,
      //            decoration: new BoxDecoration(
      //              /**
      //               * assert(color == null || decoration == null,'Cannot provide both a color and
      //               * a decoration\n'The color argument is just a shorthand
      //               * for "decoration: new BoxDecoration(color: color)".')
      //               * 在dart中使用assert 语句来中断正常的执行流程。
      //               * “不能同时”使用Ink的变量color属性以及decoration属性，“两个只能存在一个”。
      //               */
      //              color: Colors.purple,
      //              borderRadius:new BorderRadius.all(new Radius.circular(20.0)),
      //            ),
      //            child: new InkWell(
      //              borderRadius:new BorderRadius.circular(20.0),//给水波纹也设置同样的圆角
      //              onTap: (){
      //                onPressed();
      //              },
      //              child: new Container(
      //                width: 300.0,
      //                height: 100.0,
      //              ),
      //            ),
      //          ),
      //        ),
      //      ),
      //      new Center(
      //        child: new Material(
      //          child:new Ink(
      //            decoration: new BoxDecoration(
      //              color: Colors.red,
      //              borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
      //            ),
      //            child:new InkResponse(
      //              borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
//    //              highlightColor: Colors.yellowAccent,//点击或者toch控件高亮时显示的控件在控件上层,水波纹下层
      //              highlightShape: BoxShape.rectangle,//点击或者toch控件高亮的shape形状
      //              //.InkResponse内部的radius这个需要注意的是，我们需要半径大于控件的宽，如果radius过小，显示的水波纹就是一个很小的圆，
      //              radius: 300.0,//水波纹的半径
      //              splashColor: Colors.black,//水波纹的颜色
      //              containedInkWell: true,//true表示要剪裁水波纹响应的界面   false不剪裁  如果控件是圆角不剪裁的话水波纹是矩形
      //              onTap: (){
      //              },
      //              child: new Container(//1.不能在InkResponse的child容器内部设置装饰器颜色，否则会遮盖住水波纹颜色的，containedInkWell设置为false就能看到是否是遮盖了。
      //                width: 300.0,
      //                height: 100.0,
      //              ),
      //            ),
      //          ),
      //        ),
      //      ),
      //      new Center(
      //        child: new Material(
      //          child:new Ink(
      //            decoration: new BoxDecoration(
      //              color: Colors.red,
      //              borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
      //            ),
      //            child:new InkResponse(
      //              borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
      //              highlightColor: Colors.yellowAccent,//点击或者toch控件高亮时显示的控件在控件上层,水波纹下层
      //              highlightShape: BoxShape.rectangle,//点击或者toch控件高亮的shape形状
      //              //.InkResponse内部的radius这个需要注意的是，我们需要半径大于控件的宽，如果radius过小，显示的水波纹就是一个很小的圆，
      //              radius: 0.0,//水波纹的半径
//    //              splashColor: Colors.black,//水波纹的颜色
      //              containedInkWell: true,//true表示要剪裁水波纹响应的界面   false不剪裁  如果控件是圆角不剪裁的话水波纹是矩形
      //              onTap: (){
      //              },
      //              child: new Container(//1.不能在InkResponse的child容器内部设置装饰器颜色，否则会遮盖住水波纹颜色的，containedInkWell设置为false就能看到是否是遮盖了。
      //                width: 300.0,
      //                height: 100.0,
      //              ),
      //            ),
      //          ),
      //        ),
      //      ),
      //    ],
      //  );
    }
  }
}
