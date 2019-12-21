import 'package:flutter/material.dart';
import 'package:playandroid_flutter/config/status.dart';
import 'package:playandroid_flutter/util/hint_util.dart';

import 'empty_view.dart';
import 'error_view.dart';
import 'loading_view.dart';

class RefreshableList extends StatefulWidget {
  final List<dynamic> _requests; //请求列表
  final Function _buildItem; //传入匿名函数构建Item
  final Function divider; //传入匿名函数构建下划线
  final bool showFloating;
  final bool refreshable;
  _RefreshableListState _refreshableListState=_RefreshableListState();
  RefreshableList(this._requests, this._buildItem,
      {this.divider, this.showFloating = true,this.refreshable=false});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _refreshableListState;
  }
  void jumpTo(double value){
    _refreshableListState.jumpTo(value);
  }

}

class _RefreshableListState extends State<RefreshableList>
    with AutomaticKeepAliveClientMixin {

  Status _status = Status.Loading;
  ScrollController _scrollController = ScrollController();
  List<dynamic> _dataList = List(); //请求列表
  var pageNoUserIndex;
  int _pageNo = 0;
  bool isMoreEnabled = true; //是否可以上拉加载更多
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //分页接口的下标, 默认为 [_requests] 中最后一个接口
    pageNoUserIndex = widget._requests.length - 1;
    isMoreEnabled =
        widget._requests[pageNoUserIndex] is Function; //默认传递过来的_request列表都不是函数
    //网站导航页面传递过来的是List列表数据
    if (widget._requests.isNotEmpty && widget._requests[0] is List) {
      _dataList = widget._requests[0];
      _status=_dataList.length==0?Status.Empty:Status.Success;
    } else {
      getData();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        //当offstage为true，当前控件不会被绘制在屏幕上，不会响应点击事件，也不会占用空间；
        //当offstage为false，当前控件则跟平常用的控件一样渲染绘制
        //当Offstage不可见的时候，如果child有动画，应该手动停掉，Offstage并不会停掉动画
        Offstage(
          offstage: _status != Status.Loading,
          child: LoadingView()
        ),
        Offstage(
            offstage: _status != Status.Error,
            child: ErrorView(retry)
        ),
        Offstage(
            offstage: _status != Status.Empty,
            child: EmptyView()
        ),
        Offstage(
          offstage: _status != Status.Success,
          child: Scaffold(
              body: selectList(),
              floatingActionButton: (widget.showFloating
                  ? FloatingActionButton(
                      onPressed: null,
                      tooltip: "回到顶部",
                      child: Icon(Icons.arrow_upward),
                    )
                  : null)),
        )
      ],
    );
  }

  Widget selectList() {
    if(widget.refreshable){
      return RefreshIndicator(child: getList(), onRefresh: getData);

    }
    return getList();
  }

  void retry(){
    setState(() {
      _status=Status.Loading;
    });
    getData();
  }
  Widget getList() {
    return ListView.separated(
      //  physics: AlwaysScrollableScrollPhysics(),
      controller: _scrollController,
      itemCount: _dataList.isEmpty ? 100 : _dataList.length,
      itemBuilder: (BuildContext context, int index) {
        //构建每个布局的Item
        return widget._buildItem(_dataList.elementAt(index), index);
      },
      separatorBuilder: (BuildContext context, int index) {
        //构建中间的分割线
        if (widget.divider != null) {
          return widget.divider();
        }
        return Divider(
          height: 0,
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

  Future getData({bool isLoadingMore = false}) async {
    if (!isLoadingMore) {
      Future.wait(getAllFutures()).then((results) {
        //results是各种future返回的列表的集合
        setData(0, results[0], false); //results[0]取第一个Future接口返回的数据
      }).catchError((e) {
        HintUtil.toast(context, "catchError");
        setState(() {
          _status=Status.Error;
        });
      });
    } else {}
  }

  List<Future<dynamic>> getAllFutures() {
    var _futures = List<Future<dynamic>>();
    var request;
    for (int i = 0; i < widget._requests.length; i++) {
      if (pageNoUserIndex == i) {
        if (widget._requests[i] is Function) {
          request = widget._requests[i](_pageNo);
        } else {
          request = widget._requests[i];
        }
      } else {
        request = widget._requests[i];
      }
      _futures.add(request);
    }
    return _futures;
  }

  /**
   * 刷新数据
   */
  void setData(int pageCount, List<dynamic> result, bool isLoadMore) {
    setState(() {
      _dataList = result;
      if(_dataList.length==0){
        _status=Status.Empty;
      }else{
        _status=Status.Success;
      }
    });
  }
  void jumpTo(double value){
     _scrollController.jumpTo(value);
  }


}
