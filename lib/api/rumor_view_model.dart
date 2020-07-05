import 'package:covid19_app/api/rumor_model.dart';
import 'package:covid19_app/http/view_model.dart';
import 'package:covid19_app/commom/commom.dart';

RumorListReqViewModel rumorListReqViewModel = new RumorListReqViewModel();

class RumorListReqViewModel extends ViewModel {
  /*
  * 最新辟谣
  * */
  Future<dynamic> getRumor() async {
    final data = await RumorListReqModel().data();

    List list = new List();

    if (listNoEmpty(data)){
      data.forEach((json) => list.add(RumorListModel.fromJson(json)));
    }

    return Future.value(list);
  }
}
