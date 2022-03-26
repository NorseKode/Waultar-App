import 'package:flutter/material.dart';
import 'package:waultar/configs/globals/search_categories_enum.dart';
import 'package:waultar/core/models/ui_model.dart';
import 'package:waultar/domain/services/text_search_service.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_widget.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _controller = TextEditingController();
  final _textSearchService = TextSearchService();
  final _scrollController = ScrollController();
  var _contents = <UIModel>[];
  // ignore: prefer_final_fields, unused_field
  var _offset = 0;
  // ignore: prefer_final_fields, unused_field
  var _limit = 20;
  // ignore: prefer_for_elements_to_map_fromiterable, prefer_final_fields
  var _searchCategories = Map<SearchCategories, bool>.fromIterable(
    SearchCategories.values,
    key: (item) => item,
    value: (item) => true,
  );

  _serach(bool isAppend) {
    setState(() {
      isAppend
          ? _contents +=
              _textSearchService.searchAll(_controller.text, _offset, _limit)
          : _contents =
              _textSearchService.searchAll(_controller.text, _offset, _limit);
    });
  }

  _loadNewData() {
    _offset = 0;
    _scrollController.position.moveTo(0);
    _serach(false);
  }

  _onScrollEnd() {
    if (_scrollController.position.maxScrollExtent == _scrollController.position.pixels) {
      _offset += _limit;
      _serach(true);
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScrollEnd);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_onScrollEnd);
  }

  _searchCategoriesCheckBoxes() {
    return Expanded(
      flex: 1,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: SearchCategories.values.length,
        itemBuilder: (_, index) => Row(
          children: [
            Checkbox(
              value: _searchCategories[SearchCategories.values[index]],
              onChanged: (changedTo) {
                if (changedTo != null) {
                  setState(() {
                    _searchCategories[SearchCategories.values[index]] =
                        !_searchCategories[SearchCategories.values[index]]!;
                    _loadNewData();
                  });
                }
              },
            ),
            Text(SearchCategories.values[index].toString().split(".")[1]),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _searchCategoriesCheckBoxes(),
      TextField(
        controller: _controller,
        onChanged: (change) {
          // call text search
          setState(() {
            _loadNewData();
          });
        },
      ),
      Expanded(
        flex: 20,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: _contents.length,
          itemBuilder: (_, index) => DefaultWidget(
            title: "post",
            child: Text(
              _contents[index].toString(),
            ),
          ),
        ),
      ),
    ]);
  }
}
