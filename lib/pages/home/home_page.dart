import 'dart:async';

import 'package:covid19_app/api/news_model.dart';
import 'package:covid19_app/api/news_view_model.dart';
import 'package:covid19_app/commom/commom.dart';
import 'package:covid19_app/commom/data/notice.dart';
import 'package:covid19_app/widget/card/news_card.dart';
import 'package:covid19_app/widget/view/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  bool isReq = false;

  List data = new List();

//  List entriesData = new List();
//
//  StatisticsModel statisticsModel = new StatisticsModel();

  @override
  void initState() {
    super.initState();
    Notice.addListener(NCOVActions.toTabBarIndex(), (index) {
      if (!listNoEmpty(data)) getData();
    });
    getData();
  }

  @override
  bool get wantKeepAlive => true;

  getData() {
    timeNewsViewModel.getTimeNews().then((v) {
      setState(() {
        data = v;
        isReq = true;
      });
    });
//    statisticsViewModel.getData().then((v) {
//      setState(() => statisticsModel = v);
//    });
//    entriesViewModel.getData().then((v) {
//      setState(() => entriesData = v);
//    });
  }

  Future<void> _refreshData() async {
    final Completer<Null> completer = new Completer<Null>();

    getData();

    new Future.delayed(new Duration(seconds: 2), () {
      completer.complete(null);
      _refreshController.refreshCompleted();
    });

    return completer.future;
  }

  Widget buildItem(item) {
    TimeNewsModel model = item;
    bool isNew = model.id == data[0].id;
    return new NewsCard(
      model,
      padding: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: isNew ? 10.0 : 10,
        bottom: model.id == data[data.length - 1].id ? 20.0 : 10,
      ),
      isNew: isNew,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new Scaffold(
      body: new SmartRefresher(
        controller: _refreshController,
        onRefresh: _refreshData,
        child: isReq
            ? listNoEmpty(data)
                ? new ListView.builder(
                    itemBuilder: (context, index) {
                      TimeNewsModel model = data[index];
                      bool isNew = model.id == data[0].id;
                      return new NewsCard(
                        model,
                        padding: EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                          top: isNew ? 10.0 : 10,
                          bottom:
                              model.id == data[data.length - 1].id ? 20.0 : 10,
                        ),
                        isNew: isNew,
                      );
                    },
                    itemCount: data.length,
                  )
                : new Center(
                    child: new Text(
                      '暂无数据',
                      style: Theme.of(context).textTheme.display1,
                    ),
                  )
            : new LoadingView(),
//        child: new ListView(
//          children: <Widget>[
//            new Space(),
//            new TitleView(
//              '全国统计',
//              subTitle: '${timeHandle(statisticsModel?.modifyTime ?? 0)}',
//            ),
//            new Statics(statisticsModel),
//            new Divider(),
//            new Space(height: mainSpace / 2),
//            new Visibility(
//              visible: strNoEmpty(statisticsModel?.imgUrl ?? ''),
//              child: new TitleView('疫情地图', subTitle: '数据来源：国家及各省市地区卫健委'),
//            ),
//            new Visibility(
//              visible: strNoEmpty(statisticsModel?.imgUrl ?? ''),
//              child: new Padding(
//                padding: EdgeInsets.only(top: 10.0),
//                child: new CachedNetworkImage(
//                    imageUrl: statisticsModel?.imgUrl ?? defImg),
//              ),
//            ),
//            new Visibility(
//              visible: strNoEmpty(statisticsModel?.dailyPic ?? ''),
//              child: new Padding(
//                padding: EdgeInsets.only(bottom: 10.0),
//                child: new CachedNetworkImage(
//                    imageUrl: statisticsModel?.dailyPic ?? defImg),
//              ),
//            ),
//            new Space(),
//            new TitleView('诊疗'),
//            new Container(
//              margin: EdgeInsets.symmetric(horizontal: 10.0),
//              child: new Wrap(
//                children: entriesData.map((item) {
//                  EntriesModel model = item;
//                  return Entries(model);
//                }).toList(),
//              ),
//            ),
//            new TitleView('最新消息', subTitle: '消息数量：${data.length}'),
//            listNoEmpty(data)
//                ? new Column(children: data.map(buildItem).toList())
//                : new Center(
//                    child: new Text(
//                      '暂无数据',
//                      style: Theme.of(context).textTheme.display1,
//                    ),
//                  )
//          ],
//        ),
      ),
    );
  }
}
