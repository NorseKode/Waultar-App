import 'package:flutter/material.dart';
import 'package:waultar/configs/globals/search_categories_enum.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_post_repository.dart';
import 'package:waultar/core/models/content/post_model.dart';
import 'package:waultar/core/models/ui_model.dart';
import 'package:waultar/domain/services/text_search_service.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_widget.dart';
import 'package:waultar/startup.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _postRepo = locator.get<IPostRepository>(instanceName: 'postRepo');
  final _controller = TextEditingController();
  final _textSearchService = TextSearchService();
  var _contents = <UIModel>[];
  // ignore: prefer_for_elements_to_map_fromiterable, prefer_final_fields
  var _searchCategories = Map<SearchCategories, bool>.fromIterable(
    SearchCategories.values,
    key: (item) => item,
    value: (item) => true,
  );

  _serach() {
    _contents = _textSearchService.search(_searchCategories, _controller.text);
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
                    _serach();
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
            _serach();
          });
        },
      ),
      Expanded(
        flex: 20,
        child: ListView.builder(
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
