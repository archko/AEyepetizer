import 'package:aeyepetizer/common/bridge/url_channel.dart';
import 'package:aeyepetizer/common/http/http_client.dart';
import 'package:aeyepetizer/common/http/http_response.dart';
import 'package:aeyepetizer/entity/acategory.dart';
import 'package:aeyepetizer/entity/trending.dart';
import 'package:aeyepetizer/model/base_list_view_model.dart';
import 'package:aeyepetizer/model/category_detail_view_model.dart';
import 'package:aeyepetizer/utils/json_utils.dart';
import 'package:flutter/foundation.dart';

class VideoDetailViewModel extends BaseListViewModel {
  Future getUrl(ACategory category) async {
    Map args = Map();
    args["action"] = UrlChannel.URL_VIDEO_BY_ID;
    args['videoId'] = category.id;

    return await UrlChannel.get(args: args);
  }

  Future<Trending> loadData(int pn, [ACategory category]) async {
    return await getUrl(category).then((map) async {
      print("call:$map");
      Trending list;
      try {
        String url = map['url'];
        HttpResponse httpResponse = await HttpClient.instance.get(url);
        list = await compute(CategoryDetailViewModel.decodeListResult,
            httpResponse.data as String);
        print("result:${list}");
      } catch (e) {
        print(e);
        list = null;
      }
      return list;
    });
  }

  Future<Trending> loadMore(int pn) async {
    return loadData(pn);
  }
}
