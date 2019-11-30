class WebConfig {
  var EYEPETIZER_BASE_URL = "https://baobab.kaiyanapp.com/api/";
  var CATEGORY_DETAIL_URL =
      "v4/categories/videoList?&id=%d&udid=d2807c895f0348a180148c9dfa6f2feeac0781b5&deviceModel=%s"; //首页banner
  var RELATED_VIDEO_URL =
      "v4/video/related?&id=%d&udid=d2807c895f0348a180148c9dfa6f2feeac0781b5&deviceModel=%s";
  var BANNER_URL = "v2/feed?num=1&udid=%s&deviceModel=%s"; //首页banner
  var DAILY_SELECTION_URL = "v4/tabs/selected"; //每日精选
  var FIND_FOLLOW_URL =
      "v4/tabs/follow?start=%d&num=%d&follow=false&startId=0&udid=d2807c895f0348a180148c9dfa6f2feeac0781b5&deviceModel=%s"; //发现-关注
  var FIND_CATEGORIES_URL = "v4/categories?udid=%s&deviceModel=%s"; //发现-分类
  var SEARCH_URL =
      "v1/search?&num=10&start=10&query=%s&udid=d2807c895f0348a180148c9dfa6f2feeac0781b5&deviceModel=%s"; //搜索
  var HOT_WEEKLY_URL =
      "v4/rankList/videos?strategy=weekly&udid=d2807c895f0348a180148c9dfa6f2feeac0781b5&deviceModel=%s"; //热门-周排行
  var HOT_MONTHLY_URL =
      "v4/rankList/videos?strategy=monthly&udid=d2807c895f0348a180148c9dfa6f2feeac0781b5&deviceModel=%s"; //热门-月排行
  var HOT_TOTAL_RANKING_URL =
      "v4/rankList/videos?strategy=historical&udid=d2807c895f0348a180148c9dfa6f2feeac0781b5&deviceModel=%s"; //热门-总排行

}
