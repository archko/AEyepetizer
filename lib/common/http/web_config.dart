class WebConfig {
  //&udid=d2807c895f0348a180148c9dfa6f2feeac0781b5&deviceModel=%s
  static const baseUrl = "https://baobab.kaiyanapp.com/api";

  static const bannerUrl = "${baseUrl}/v2/feed?"; //首页banner,num=1
  static const dailySelectionUrl = "${baseUrl}/v4/tabs/selected"; //每日精选
  //发现-关注 ?&num=10&start=10&query=%s
  static const findFollowUrl = "${baseUrl}/v4/tabs/follow?";

  static final keywordUrl = '${baseUrl}/v3/queries/hot';

  //搜索?&num=10&start=10&query=%s
  static const searchUrl = "${baseUrl}/v1/search";

  static final authorUrl = '${baseUrl}/v4/pgcs/detail/tab';

  static const categoriesUrl = "${baseUrl}/v4/categories?"; //发现-分类
  ////?&id=%d
  static const categoryDetailUrl = "${baseUrl}/v4/categories/videoList";

  //&id=
  static const relatedVideoUrl = "${baseUrl}/v4/video/related";

  //热门-周/月/总排行strategy=weekly,monthly,historical
  static const hotUrl = "${baseUrl}/v4/rankList/videos";
}
