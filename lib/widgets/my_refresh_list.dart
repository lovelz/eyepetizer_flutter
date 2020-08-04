

import 'package:eyepetizer_flutter/res/gaps.dart';
import 'package:eyepetizer_flutter/widgets/state_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LzRefreshListView extends StatefulWidget {

  final RefreshCallback onRefresh;
  final LoadMoreCallback loadMore;
  final int itemCount;
  final bool hasMore;
  final IndexedWidgetBuilder itemBuilder;
  final StateType stateType;
  final int pageSize;
  final EdgeInsetsGeometry padding;
  final double itemExtent;

  const LzRefreshListView({
    Key key,
    @required this.itemCount,
    @required this.itemBuilder,
    @required this.onRefresh,
    this.loadMore,
    this.hasMore: false,
    this.stateType: StateType.empty,
    this.pageSize: 10,
    this.padding,
    this.itemExtent,
  }) : super(key: key);


  @override
  _RefreshListViewState createState() => _RefreshListViewState();

}

typedef RefreshCallback = Future<void> Function();
typedef LoadMoreCallback = Future<void> Function();

class _RefreshListViewState extends State<LzRefreshListView> {

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NotificationListener(
        onNotification: (ScrollNotification note) {
          if (note.metrics.pixels == note.metrics.maxScrollExtent && note.metrics.axis == Axis.vertical) {
            _loadMore();
          }
          return true;
        },
        child: RefreshIndicator(
          onRefresh: widget.onRefresh,
          child: widget.itemCount == 0 ? StateLayout(type: widget.stateType,) : ListView.builder(
            itemCount: widget.loadMore == null ? widget.itemCount : widget.itemCount + 1,
            padding: widget.padding,
            itemExtent: widget.itemExtent,
            itemBuilder: (BuildContext context, int index) {
              if (widget.loadMore == null) {
                return widget.itemBuilder(context, index);
              } else {
                return index < widget.itemCount ? widget.itemBuilder(context, index) :
                  MoreWidget(widget.itemCount, widget.hasMore, widget.pageSize);
              }
            },
          ),
        ),
      ),
    );
  }

  Future _loadMore() async {
    if (widget.loadMore == null) {
      return;
    }
    if (_isLoading) {
      return;
    }
    if (!widget.hasMore) {
      return;
    }
    _isLoading = true;
    await widget.loadMore();
    _isLoading = false;
  }

}

class MoreWidget extends StatelessWidget {

  final int itemCount;
  final bool hasMore;
  final int pageSize;

  const MoreWidget(this.itemCount, this.hasMore, this.pageSize);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          hasMore ? const CupertinoActivityIndicator() : Gaps.empty,
          hasMore ? Gaps.hGap4 : Gaps.empty,
          Text(
            hasMore ? '正在加载中...' : (itemCount < pageSize ? '' : '没有了哟~'),
            style: const TextStyle(color: Color(0x8A000000)),
          ),
        ],
      ),
    );
  }

}