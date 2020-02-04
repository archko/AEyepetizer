import 'package:aeyepetizer/common/bridge/url_channel.dart';
import 'package:aeyepetizer/entity/trending.dart';
import 'package:aeyepetizer/entity/video_data.dart';
import 'package:aeyepetizer/model/video_by_category_view_model.dart';
import 'package:flutter_base/http/http_client.dart';
import 'package:flutter_base/http/http_response.dart';
import 'package:flutter_base/model/base_list_view_model.dart';
import 'package:flutter_base/utils/isolate_utils.dart';

class VideoDetailViewModel extends BaseListViewModel {
  Trending last;

  Future getUrl(VideoData videoData) async {
    Map args = Map();
    args["action"] = UrlChannel.URL_VIDEO_BY_ID;
    args['videoId'] = videoData.id;

    return await UrlChannel.get(args: args);
  }

  Future<Trending> loadData(int pn, [VideoData videoData]) async {
    return await getUrl(videoData).then((map) async {
      print("call:$map");
      Trending trending;
      try {
        String url = map['url'];
        HttpResponse httpResponse = await HttpClient.instance.get(url);
        //trending = await compute(VideoByCategoryViewModel.decodeListResult,
        //    httpResponse.data as String);
        final lb = await loadBalancer;
        trending = await lb.run<Trending, String>(
            VideoByCategoryViewModel.decodeListResult, httpResponse.data as String);
        last = trending;
      } catch (e) {
        print(e);
        trending = null;
      }
      return trending;
    });
  }

  Future<Trending> loadMore(int pn) async {
    return loadData(pn);
  }
}
