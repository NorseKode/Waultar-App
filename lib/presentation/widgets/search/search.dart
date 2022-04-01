import 'package:flutter/material.dart';
import 'package:waultar/configs/globals/category_enums.dart';
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
  // ignore: prefer_final_fields, prefer_for_elements_to_map_fromiterable
  var _chosenCategories = <CategoryEnum, bool>{};
  var _contents = <UIModel>[];
  // ignore: prefer_final_fields, unused_field
  var _offset = 0;
  // ignore: prefer_final_fields, unused_field
  var _limit = 20;
  // ignore: prefer_for_elements_to_map_fromiterable, prefer_final_fields

  _serach(bool isAppend) {
    setState(() {
      var categories = _chosenCategories.entries.where((element) => element.value).map((e) => e.key).toList();
      isAppend
          ? _contents +=
              _textSearchService.search(categories, _controller.text, _offset, _limit)
          : _contents =
              _textSearchService.search(categories, _controller.text, _offset, _limit);
    });
  }

  _loadNewData() {
    _offset = 0;
    _scrollController.position.moveTo(0);
    _serach(false);
  }

  _onScrollEnd() {
    if (_scrollController.position.maxScrollExtent ==
        _scrollController.position.pixels) {
      _offset += _limit;
      _serach(true);
    }
  }

  @override
  void initState() {
    _chosenCategories = {for (var item in CategoryEnum.values) item: true};
    super.initState();
    _scrollController.addListener(_onScrollEnd);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_onScrollEnd);
  }

  Widget _searchCategoriesCheckBoxes() {
    return Wrap(
      children: List.generate(
        CategoryEnum.values.length,
        (index) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: _chosenCategories[CategoryEnum.values[index]],
              onChanged: (changedTo) {
                if (changedTo != null) {
                  setState(() {
                    _chosenCategories[CategoryEnum.values[index]] =
                        !_chosenCategories[CategoryEnum.values[index]]!;
                    _loadNewData();
                  });
                }
              },
            ),
            Text(CategoryEnum.values[index].categoryName),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          onChanged: (change) {
            // call text search
            setState(() {
              _loadNewData();
            });
          },
        ),
        const SizedBox(
          height: 20.0,
        ),
        _searchCategoriesCheckBoxes(),
        const SizedBox(
          height: 20.0,
        ),
        Expanded(
          // flex: 20,
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
            itemCount: _contents.length,
            itemBuilder: (_, index) => Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
              child: DefaultWidget(
                edgeInsetsGeometry: const EdgeInsets.all(8.0),
                title: _contents[index].getMostInformativeField(),
                child: Text(
                  _contents[index].toString(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
