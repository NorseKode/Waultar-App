import 'package:flutter/material.dart';

class InfiniteScroll extends StatefulWidget {
  final int step;
  final List<dynamic> Function(int offset, int limit) paginationFunction;
  final Widget Function(List elements, int index) builderWidgetGenerator;

  const InfiniteScroll({
    required this.step,
    required this.paginationFunction,
    required this.builderWidgetGenerator,
    Key? key,
  }) : super(key: key);

  @override
  State<InfiniteScroll> createState() => _InfiniteScrollState();
}

class _InfiniteScrollState extends State<InfiniteScroll> {
  final _scrollController = ScrollController();
  final _limit = 0;
  var _offset = 0;
  var _elements = [];

  @override
  void initState() {
    super.initState();
    _offset = widget.step;
    _scrollController.addListener(_onScrollEnd);
    _elements = widget.paginationFunction(_offset, _limit);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_onScrollEnd);
  }

  _onScrollEnd() {
    if (_scrollController.position.maxScrollExtent == _scrollController.position.pixels) {
      _offset += _limit;

      setState(() {
        _elements += widget.paginationFunction(_offset, _limit);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _elements.length,
        itemBuilder: (_, index) => widget.builderWidgetGenerator(_elements, index),
      ),
    );
  }
}
