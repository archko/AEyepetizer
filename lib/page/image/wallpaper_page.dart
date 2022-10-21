import 'package:aeyepetizer/entity/wallpaper.dart';
import 'package:aeyepetizer/model/wallpaper_controller.dart';
import 'package:aeyepetizer/page/image/image_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/utils/string_utils.dart';
import 'package:get/get.dart';

/// 视图层
class WallpaperPage extends StatelessWidget {
  WallpaperPage({Key? key}) : super(key: key) {
    Get.put(WallpaperController());
  }

  @override
  String toStringShort() {
    return "每日壁纸";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: const Text("每日壁纸"),
      ),*/
      body: GetBuilder<WallpaperController>(
        builder: (controller) {
          if (controller.isLoading == true) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: ListView.builder(
                itemCount: controller.wallpaperBean.length,
                itemBuilder: (_, index) {
                  Wallpaper wallpaper = controller.wallpaperBean[index];
                  String? picUrl = wallpaper.img_1600_900;
                  if (StringUtils.isEmpty(picUrl)) {
                    picUrl = wallpaper.img_1440_900;
                  }
                  if (StringUtils.isEmpty(picUrl)) {
                    picUrl = wallpaper.img_1366_768;
                  }
                  if (StringUtils.isEmpty(picUrl)) {
                    picUrl = wallpaper.img_1280_1024;
                  }
                  if (StringUtils.isEmpty(picUrl)) {
                    picUrl = wallpaper.img_1280_1024;
                  }
                  if (StringUtils.isEmpty(picUrl)) {
                    picUrl = wallpaper.img_1280_800;
                  }
                  if (StringUtils.isEmpty(picUrl)) {
                    picUrl = wallpaper.img_1024_768;
                  }
                  return _buildItem(context, wallpaper, picUrl!);
                },
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildItem(BuildContext context, Wallpaper wallpaper, String picUrl) {
    return GestureDetector(
      onTap: () {
        Get.to(ImagePage(imageUrl: picUrl));
      },
      child: _wallpaperItem(wallpaper, picUrl),
    );
  }

  Widget _wallpaperItem(Wallpaper wallpaper, String picUrl) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(10.0, 4.0, 10.0, 4.0),
            child: Divider(height: 1.0, color: Color(0x99000000)),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(10.0, 4.0, 10.0, 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StringUtils.isEmpty(wallpaper.resolution)
                      ? ""
                      : "分辨率:${wallpaper.resolution!}",
                  overflow: TextOverflow.clip,
                  style: const TextStyle(fontSize: 15),
                ),
                Text(
                  StringUtils.isEmpty(wallpaper.createTime)
                      ? ""
                      : "  ${wallpaper.createTime!}",
                  overflow: TextOverflow.clip,
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          Container(
            height: 200,
            margin: const EdgeInsets.all(10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image(
                image: CachedNetworkImageProvider('$picUrl'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
