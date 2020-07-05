import 'package:covid19_app/api/version_model.dart';
import 'package:covid19_app/http/view_model.dart';

VersionViewModel versionViewModel = new VersionViewModel();

class VersionViewModel extends ViewModel {
  /*
  * 版本更新
  * */
  Future<dynamic> getData() async {
    final Map data = await VersionReqModel().data();

    if (data != null && data.isNotEmpty) {
      return VersionModel.fromJson(data);
    }

    return Future.value(null);
  }
}
