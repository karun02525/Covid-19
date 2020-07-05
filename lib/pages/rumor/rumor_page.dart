import 'dart:async';

import 'package:covid19_app/api/entries_model.dart';
import 'package:covid19_app/api/rumor_model.dart';
import 'package:covid19_app/api/statistics_model.dart';
import 'package:covid19_app/commom/data/notice.dart';
import 'package:covid19_app/config/const.dart';
import 'package:covid19_app/widget/view/loading_view.dart';
import 'package:covid19_app/widget/view/title_view.dart';
import 'package:flutter/material.dart';
import 'package:covid19_app/api/entries_view_model.dart';
import 'package:covid19_app/api/rumor_view_model.dart';
import 'package:covid19_app/api/statistics_view_model.dart';
import 'package:covid19_app/commom/commom.dart';
import 'package:covid19_app/widget/card/rumor_card.dart';
import 'package:covid19_app/widget/item/entries.dart';
import 'package:covid19_app/widget/item/statics.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RumorPage extends StatefulWidget {
  @override
  _RumorPageState createState() => _RumorPageState();
}

class _RumorPageState extends State<RumorPage>
    with AutomaticKeepAliveClientMixin {
  List<dynamic> data = new List();

  bool isReq = false;

  List entriesData = new List();

  StatisticsModel statisticsModel = new StatisticsModel();

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

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
    rumorListReqViewModel.getRumor().then((v) {
      setState(() {
        data = v;
        isReq = true;
      });
    });
    statisticsViewModel.getData().then((v) {
      setState(() => statisticsModel = v);
    });
    entriesViewModel.getData().then((v) {
      setState(() => entriesData = v);
    });
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
    RumorListModel model = item;
    return new RumorCard(
      model,
      margin: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: model.id == data[0].id ? 20.0 : 10,
        bottom: model.id == data[data.length - 1].id ? 20.0 : 10,
      ),
      onTap: () {
        setState(() => model.isOpen = !model.isOpen);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new Scaffold(
      body: new SmartRefresher(
        controller: _refreshController,
        onRefresh: _refreshData,
        child: new ListView(
          children: <Widget>[
            new Space(),
            new TitleView(
              '全国统计',
              subTitle: '${timeHandle(statisticsModel?.modifyTime ?? 0)}',
            ),
            new Statics(statisticsModel ?? null),
            new Divider(),
            new Space(height: mainSpace / 2),
            new Visibility(
              visible: strNoEmpty(statisticsModel?.imgUrl ?? ''),
              child: new TitleView('疫情地图', subTitle: '数据来源：国家及各省市地区卫健委'),
            ),
            new Visibility(
              visible: strNoEmpty(statisticsModel?.imgUrl ?? ''),
              child: new Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: new CachedNetworkImage(
                    imageUrl: statisticsModel?.imgUrl ?? defImg),
              ),
            ),
            new Visibility(
              visible: listNoEmpty(statisticsModel?.dailyPics),
              child: new Column(
                children: listNoEmpty(statisticsModel?.dailyPics)
                    ? statisticsModel.dailyPics.map((pics) {
                        return new CachedNetworkImage(imageUrl: pics);
                      }).toList()
                    : [],
              ),
            ),
            new Space(),
            new TitleView('诊疗'),
            new Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: new Wrap(
                children: entriesData.map((item) {
                  EntriesModel model = item;
                  return Entries(model);
                }).toList(),
              ),
            ),
            new TitleView('辟谣', subTitle: '消息数量：${data.length}'),
            isReq
                ? listNoEmpty(data)
                    ? new Column(
                        children: data.map(buildItem).toList(),
                      )
                    : new Center(
                        child: new Text(
                          '暂无数据',
                          style: Theme.of(context).textTheme.display1,
                        ),
                      )
                : new LoadingView(),
          ],
        ),
      ),
    );
  }
}
