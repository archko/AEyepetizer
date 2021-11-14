import 'package:aeyepetizer/entity/video_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/utils/string_utils.dart';

class VideoListItem extends StatelessWidget {
  VideoListItem({required this.bean, this.onPressed}) : super();
  final VideoItem bean;
  final VoidCallback? onPressed;

  void detail(String bean) {}

  @override
  Widget build(BuildContext context) {
    var titleContainer;
    if (bean.data!.dataType == "TextCard" ||
        bean.data!.cover == null ||
        StringUtils.isEmpty(bean.data!.cover!.feed)) {
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
                  '${StringUtils.isEmpty(bean.data!.text) ? bean.data!.description : bean.data!.text}',
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
            Text('${bean.data!.title}',
                style: TextStyle(fontSize: 20.0, color: Colors.blue)),
            Expanded(
              child: Text(
                  '${StringUtils.isEmpty(bean.data!.description) ? "" : bean.data!.description}',
                  style: TextStyle(fontSize: 14.0, color: Colors.cyanAccent)),
            ),
          ],
        ),
      );
    }
    if (bean.data!.dataType == "TextCard") {
      return Card(
        //color: Colors.black26,
        margin: const EdgeInsets.all(4.0),
        child: Material(
          child: Ink(
            //INK可以实现装饰容器，实现矩形  设置背景色
            color: Colors.black,
            child: InkWell(
              onTap: () {},
              child: Container(
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
    } else if (bean.data!.cover == null ||
        StringUtils.isEmpty(bean.data!.cover!.feed)) {
      return Card(
        margin: const EdgeInsets.all(4.0),
        child: Material(
          child: Ink(
            color: Colors.black,
            child: InkWell(
              onTap: () {},
              child: Container(
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
        child: Material(
          child: Ink(
            //INK可以实现装饰容器，实现矩形  设置背景色
            //color: Colors.black,
            child: InkWell(
              child: Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Image(
                          image: CachedNetworkImageProvider(
                              '${bean.data!.cover!.feed}'),
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
      //    child: Ink(
      //      color: Colors.black,
      //      child: InkWell(
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
      //      Center(
      //        child:Material(
      //          child: InkWell(
      //            onTap: (){
      //            },
      //            child: Container(//不要在这里设置背景色，for则会遮挡水波纹效果,如果设置的话尽量设置Material下面的color来实现背景色
      //              margin: EdgeInsets.all(0.0),
      //              width: 300.0,
      //              height: 100.0,
      //              child: RaisedButton(child: Text("111"),),
      //            ),
      //          ),
      //          color: Colors.yellow,
      //        ),
      //      ),
      //      Center(
      //        child: Material(
      //          child: Ink(//INK可以实现装饰容器，实现矩形  设置背景色
      //            color: Colors.black,
      //            child:InkWell(
      //              onTap: (){
      //                onPressed();
      //              },
      //              child: Container(
      //                width: 300.0,
      //                height: 100.0,
      //              ),
      //            ),
      //          ),
      //        ),
      //      ),
      //      Center(
      //        child: Material(
      //          child: Ink(//用ink圆角矩形
//    //            color: Colors.red,
      //            decoration: BoxDecoration(
      //              /**
      //               * assert(color == null || decoration == null,'Cannot provide both a color and
      //               * a decoration\n'The color argument is just a shorthand
      //               * for "decoration: BoxDecoration(color: color)".')
      //               * 在dart中使用assert 语句来中断正常的执行流程。
      //               * “不能同时”使用Ink的变量color属性以及decoration属性，“两个只能存在一个”。
      //               */
      //              color: Colors.purple,
      //              borderRadius:BorderRadius.all(Radius.circular(20.0)),
      //            ),
      //            child: InkWell(
      //              borderRadius:BorderRadius.circular(20.0),//给水波纹也设置同样的圆角
      //              onTap: (){
      //                onPressed();
      //              },
      //              child: Container(
      //                width: 300.0,
      //                height: 100.0,
      //              ),
      //            ),
      //          ),
      //        ),
      //      ),
      //      Center(
      //        child: Material(
      //          child:Ink(
      //            decoration: BoxDecoration(
      //              color: Colors.red,
      //              borderRadius: BorderRadius.all(Radius.circular(30.0)),
      //            ),
      //            child:InkResponse(
      //              borderRadius: BorderRadius.all(Radius.circular(30.0)),
//    //              highlightColor: Colors.yellowAccent,//点击或者toch控件高亮时显示的控件在控件上层,水波纹下层
      //              highlightShape: BoxShape.rectangle,//点击或者toch控件高亮的shape形状
      //              //.InkResponse内部的radius这个需要注意的是，我们需要半径大于控件的宽，如果radius过小，显示的水波纹就是一个很小的圆，
      //              radius: 300.0,//水波纹的半径
      //              splashColor: Colors.black,//水波纹的颜色
      //              containedInkWell: true,//true表示要剪裁水波纹响应的界面   false不剪裁  如果控件是圆角不剪裁的话水波纹是矩形
      //              onTap: (){
      //              },
      //              child: Container(//1.不能在InkResponse的child容器内部设置装饰器颜色，否则会遮盖住水波纹颜色的，containedInkWell设置为false就能看到是否是遮盖了。
      //                width: 300.0,
      //                height: 100.0,
      //              ),
      //            ),
      //          ),
      //        ),
      //      ),
      //      Center(
      //        child: Material(
      //          child:Ink(
      //            decoration: BoxDecoration(
      //              color: Colors.red,
      //              borderRadius: BorderRadius.all(Radius.circular(30.0)),
      //            ),
      //            child:InkResponse(
      //              borderRadius: BorderRadius.all(Radius.circular(30.0)),
      //              highlightColor: Colors.yellowAccent,//点击或者toch控件高亮时显示的控件在控件上层,水波纹下层
      //              highlightShape: BoxShape.rectangle,//点击或者toch控件高亮的shape形状
      //              //.InkResponse内部的radius这个需要注意的是，我们需要半径大于控件的宽，如果radius过小，显示的水波纹就是一个很小的圆，
      //              radius: 0.0,//水波纹的半径
//    //              splashColor: Colors.black,//水波纹的颜色
      //              containedInkWell: true,//true表示要剪裁水波纹响应的界面   false不剪裁  如果控件是圆角不剪裁的话水波纹是矩形
      //              onTap: (){
      //              },
      //              child: Container(//1.不能在InkResponse的child容器内部设置装饰器颜色，否则会遮盖住水波纹颜色的，containedInkWell设置为false就能看到是否是遮盖了。
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
