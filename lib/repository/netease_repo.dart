import 'dart:async';

import 'package:aeyepetizer/common/http/web_config.dart';
import 'package:aeyepetizer/entity/netease_news_bean.dart';
import 'package:flutter_base/http/http_client.dart';
import 'package:flutter_base/http/http_response.dart';
import 'package:flutter_base/log/logger.dart';
import 'package:flutter_base/utils/isolate_utils.dart';
import 'package:flutter_base/utils/json_utils.dart';

class NeteaseRepo {
  static final NeteaseRepo _instance = NeteaseRepo();

  static NeteaseRepo get singleton => _instance;

  static String getUrl(String key, int start, int pageSize) {
    return WebConfig.neteaseNewsBaseUrl + "$key/$start-$pageSize.html";
  }

  Future<NeteaseNewsBean?> loadNeteaseNews(String key, int page) async {
    NeteaseNewsBean? bean;
    try {
      Map<String, dynamic> args = Map();
      args['authority'] = '3g.163.com';
      args['cookie'] =
          "NTES_P_UTID=0rnqRXrGiB4dKFlZZYfIHNByWTzmM1wm|1666360446; NTES_SESS=7MLbWmJGt7yZ21fih1ndv7vihT0_4l5djUzcJAfNTUPjj4m28XohAq.GbD48Lk1Zs66KbxK3GJ6.ENi0wcTphqCI.2A1GAekObagBjqgJhzVgUI60DXnp0CUgGihUO0ONaCweyU9ai7RhDTQbQyAsQngUjm3GudgyG1KD_rf4q.a7OGsIaP7XmNpzLqBI2kCW5SFM7Q0RghZcPGyjrWv8ZLFN; NTES_PASSPORT=6zXn5W4Yhe8aC7axM.i5Iyz_28Kc0Au2x0nJapTYzqV7RYNr78A0QWxy62Y7Cvdk1F1cSVExaXjejD8uaYZ8BGs9sgQuJEsNBgMXxLwxzSqqr7z_tKtYOzmVNkMKHtM8t0H820byhKtvIQRSHRp92KvIL_jcHbn777nmj.mpzzFNdwXoHPZiHhr3xgQY5wtmB; S_INFO=1666360446|0|##|archko@sina.com; P_INFO=archko@sina.com|1666360446|1|ht|00&99|bej&1665798544&ht#bej&null#10#0#0|&0||archko@sina.com; _ntes_nuid=1e3571af01c4a104e2708f7c151573c6; _antanalysis_s_id=1666411622049; __bid_n=183fddf72edff57aef4207; FPTOKEN=30\$GDlDc12YQ2WtWLWnX6Si7u6UZggn41198Qf37hH8BRVRdZ7TWRLylY9dPwZ5bDDI/JbCi600SXo/6eUF7L0d6P1r4ptoIfenwQXrpTJF0FV4VA76PEZkR2Kzl5bXaSPN79UXtD+MLMJ7nx1Cnmzg+5C43Qt/5aZyhg9kJLzLkmeRS39ENSE4LqVehIYq4gbwoGAoW3se04+h5uqu3eADncsKUo39R7LKqZXwKWAN1CeaRxPcVAek9i6dg2v1QhHWzyK2q+dISeLB3FwqFw9JPCFKFIBIkvejFRNy+L4LVhWgILHAYW7jPqr6aA9R3NqYdP1oUi4+5xW4B7z8QwVHeumVvx2WK3ipRtpBMoV3IItCsZuA2S+Yni3hFt3sWkcB|Eawqfcx/vR9Bn40HYfOE9lj7/UirQfaGfgCSw2mr48Q=|10|a29b6897e6d3ded2995e87553e1b3b9e; mp_MA-94A1-BB29DC5DA865_hubble=%7B%22sessionReferrer%22%3A%20%22https%3A%2F%2Flove.163.com%2Ftrend%22%2C%22updatedTime%22%3A%201666413758844%2C%22sessionStartTime%22%3A%201666413753057%2C%22sendNumClass%22%3A%20%7B%22allNum%22%3A%208%2C%22errSendNum%22%3A%200%7D%2C%22deviceUdid%22%3A%20%22e474d777-e577-4124-bab7-69b84fd54384%22%2C%22persistedTime%22%3A%201666360440891%2C%22LASTEVENT%22%3A%20%7B%22eventId%22%3A%20%22view_recentguest%22%2C%22time%22%3A%201666413758845%7D%2C%22sessionUuid%22%3A%20%2203ed92dd-f11c-40c4-bbed-d7792fb0f702%22%2C%22user_id%22%3A%20%228812607470682408440%22%7D; Hm_lvt_b2d0b085a122275dd543c6d39d92bc62=1666414452; Hm_lvt_ee16af73ee73a16e2cf07eba7a4f152b=1666414453; Hm_lpvt_ee16af73ee73a16e2cf07eba7a4f152b=1666414453; Hm_lvt_e0fb65cc3271fe55b85453a3454b005d=1666414456; Hm_lpvt_e0fb65cc3271fe55b85453a3454b005d=1666414456; Hm_lpvt_b2d0b085a122275dd543c6d39d92bc62=1666414790;";

      var url = getUrl(key, page, 20);
      HttpResponse httpResponse =
          await HttpClient.instance.get(url, params: args);
      var data = httpResponse.data as String;
      String result =
          httpResponse.data?.replaceAll('artiList(', '').replaceAll(')', '');
      Logger.d("url:$url,data:$result");
      bean = await run<NeteaseNewsBean, String>(decodeNetnewsBean, result);
    } catch (e) {
      print(e);
    }
    return bean;
  }

  static NeteaseNewsBean decodeNetnewsBean(String result) {
    var results = JsonUtils.decodeAsMap(result);
    return NeteaseNewsBean.fromJson(results);
  }
}
