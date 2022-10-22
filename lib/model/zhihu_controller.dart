import 'package:aeyepetizer/entity/zhihu.dart';
import 'package:aeyepetizer/entity/zhihu_bean.dart';
import 'package:aeyepetizer/repository/zhihu_repo.dart';
import 'package:get/get.dart';

class ZhihuController extends GetxController {
  var zhihuBean;

  ZhihuController();

  int getCount() {
    return (null == zhihuBean || null == zhihuBean.recent)
        ? 0
        : zhihuBean.recent!.length;
  }

  List<Zhihu>? getRecents() {
    return zhihuBean.recent;
  }

  Future refreshList() async {
    ZhihuBean? zhihu = await ZhihuRepo.singleton.loadZhihuRecents();
    zhihuBean = zhihu;
    update();
  }
}
