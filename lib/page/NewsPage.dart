import 'package:aeyepetizer/entity/NewsModel.dart';
import 'package:aeyepetizer/model/NewsController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 视图层
class NewsPage extends StatelessWidget {
  NewsPage({Key? key}) : super(key: key) {
    final counter = Get.put(NewsController());
  }

  @override
  String toStringShort() {
    return "新闻列表";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: const Text("新闻列表"),
      ),*/
      body: GetBuilder<NewsController>(
        builder: (counter) {
          if (counter.isLoading == true) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: ListView.builder(
                itemCount: counter.newsList.length,
                itemBuilder: (_, index) {
                  NewsModel newsModel = counter.newsList[index];
                  return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin:
                              const EdgeInsets.fromLTRB(10.0, 4.0, 10.0, 4.0),
                          child: Divider(height: 1.0, color: Color(0x99000000)),
                        ),
                        Container(
                          margin:
                              const EdgeInsets.fromLTRB(10.0, 4.0, 10.0, 4.0),
                          child: Text(
                            newsModel.title,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image(
                              image: CachedNetworkImageProvider(
                                  '${newsModel.itemCover}'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
