import 'package:covid19_app/api/news_model.dart';
import 'package:covid19_app/commom/check.dart';
import 'package:covid19_app/http/view_model.dart';

TimeNewsViewModel timeNewsViewModel = new TimeNewsViewModel();

class TimeNewsViewModel extends ViewModel {
  /*
  * 按时间线获取事件
  * */
  Future<dynamic> getTimeNews() async {
    final data = await TimeNewsReqModel().data();

    List list = new List();

    if (listNoEmpty(data)) {
      data.forEach((json) => list.add(TimeNewsModel.fromJson(json)));
    }

    return Future.value(list);
  }
}
