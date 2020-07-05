import 'package:covid19_app/api/lore_model.dart';
import 'package:covid19_app/commom/check.dart';
import 'package:covid19_app/http/view_model.dart';

LoreViewModel loreViewModel = new LoreViewModel();

class LoreViewModel extends ViewModel {
  /*
  * 最新知识百科
  * */
  Future<dynamic> getLore() async {
    Map map = await LoreReqModel().data();

    List data = map['result'];

    List list = new List();

    if (listNoEmpty(data)) {
      data.forEach((json) => list.add(LoreModel.fromJson(json)));
    }

    return Future.value(list);
  }
}
