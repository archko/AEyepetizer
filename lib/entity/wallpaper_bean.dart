import 'package:aeyepetizer/entity/wallpaper.dart';

class WallpaperBean {
  WallpaperBean({
    this.errno,
    this.total,
    this.errmsg,
    this.wallpapers,
  });

  WallpaperBean.fromJson(Map<String, dynamic> json) {
    errno = json['errno'];
    total = json['total'];
    errmsg = json['errmsg'];
    var results = json["data"];
    wallpapers = List.empty(growable: true);
    for (var item in results) {
      wallpapers!.add(Wallpaper.fromJson(item));
    }
  }

  String? errno;
  String? total;
  String? errmsg;
  List<Wallpaper>? wallpapers;

  @override
  String toString() {
    return 'WallpaperBean{errno: $errno, total: $total, errmsg: $errmsg, wallpapers: $wallpapers}';
  }
}