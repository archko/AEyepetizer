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

  /// 知乎api
  static const zhihuHot = "https://news-at.zhihu.com/api/4/news/hot";

  /// 网易新闻,https://3g.163.com/touch/reconstruct/article/list/BA8EE5GMwangning/2-10.html,2-10是起始为2,一页10条
  static const neteaseNewsBaseUrl =
      "https://3g.163.com/touch/reconstruct/article/list/";

  /// 新闻：
  static const key_news = "BBM54PGAwangning";

  /// 娱乐：
  static const key_entertainment = "BA10TA81wangning";

  /// 体育：
  static const key_sports = "BA8E6OEOwangning";

  /// 财经：
  static const key_finance = "BA8EE5GMwangning";

  /// 军事：
  static const key_military = "BAI67OGGwangning";

  /// 科技：
  static const key_tech = "BA8D4A3Rwangning";

  /// 手机：
  static const key_phone = "BAI6I0O5wangning";

  /// 数码：
  static const key_figure = "BAI6JOD9wangning";

  /// 时尚：
  static const key_fashion = "BA8F6ICNwangning";

  /// 游戏：
  static const key_game = "BAI6RHDKwangning";

  /// 教育：
  static const key_edu = "BA8FF5PRwangning";

  /// 健康：
  static const key_health = "BDC4QSV3wangning";

  /// 旅游：
  static const key_journey = "BEO4GINLwangning";
}
