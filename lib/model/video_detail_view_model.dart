import 'package:aeyepetizer/common/http/web_config.dart';
import 'package:aeyepetizer/entity/trending.dart';
import 'package:aeyepetizer/entity/video_data.dart';
import 'package:aeyepetizer/repository/video_repository.dart';
import 'package:flutter_base/http/http_client.dart';
import 'package:flutter_base/http/http_response.dart';
import 'package:flutter_base/model/base_list_view_model.dart';
import 'package:flutter_base/utils/isolate_utils.dart';

class VideoDetailViewModel extends BaseListViewModel {
  Trending last;

  Future<Trending> loadData(int pn, [VideoData videoData]) async {
    Trending trending;
    try {
      Map<String, dynamic> args = Map();
      args['udid'] = 'd2807c895f0348a180148c9dfa6f2feeac0781b5';
      args['deviceModel'] = 'vivo x21';
      args['id'] = videoData.id;
      HttpResponse httpResponse = await HttpClient.instance
          .get(WebConfig.relatedVideoUrl, params: args);

      final lb = await loadBalancer;
      trending = await lb.run<Trending, String>(
          VideoRepository.decodeTrendingResult, httpResponse.data as String);
      last = trending;
    } catch (e) {
      print(e);
      trending = null;
    }
    return trending;
  }

  Future<Trending> loadMore(int pn) async {
    return loadData(pn);
  }
}
