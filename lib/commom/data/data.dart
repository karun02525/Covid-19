import 'package:covid19_app/commom/data/store.dart';

class NCOVActions {
  static String msg() => 'msg';

  static String voiceImg() => 'voiceImg';

  static String toTabBarIndex() => 'toTabBarIndex';
}

class Data {
  static String msg() => Store(NCOVActions.msg()).value = '';

  static String voiceImg() => Store(NCOVActions.voiceImg()).value = '';
}
