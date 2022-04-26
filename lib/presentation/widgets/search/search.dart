import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waultar/configs/globals/category_enums.dart';
import 'package:waultar/core/abstracts/abstract_services/i_search_service.dart';
import 'package:waultar/core/models/ui_model.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/data/repositories/profile_repo.dart';
import 'package:waultar/domain/services/search_service.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_widget.dart';
import 'package:waultar/presentation/widgets/general/profile_selector.dart';
import 'package:waultar/startup.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late ThemeProvider themeProvider;
  final _controller = TextEditingController();
  final _textSearchService = locator.get<ISearchService>(instanceName: 'searchService');
  final _scrollController = ScrollController();

  var _chosenCategories = <CategoryEnum, bool>{};
  var _contents = <UIModel>[];

  var profiles = locator.get<ProfileRepository>(instanceName: 'profileRepo').getAll().toList();
  late ProfileDocument currentProfile;

  var _offset = 0;
  final _limit = 20;

  _getSelectedProfiles() {
    return currentProfile.id == 0
      ? profiles.map((e) => e.id).toList()
      : [currentProfile.id];
  }

  _serach(bool isAppend) {
    setState(() {
      var categories =
          _chosenCategories.entries.where((element) => element.value).map((e) => e.key).toList();
      isAppend
          ? _contents += _textSearchService.searchText(categories, _getSelectedProfiles(), _controller.text, _offset, _limit)
          : _contents = _textSearchService.searchText(categories, _getSelectedProfiles(), _controller.text, _offset, _limit);
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
    currentProfile = profiles.first;
    if (profiles.length > 1) {
      profiles.add(ProfileDocument(name: "All"));
    }
    
    
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
              activeColor: themeProvider.themeMode().themeColor,
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

  Widget _topBar() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   "Search",
        //   style: themeProvider.themeData().textTheme.headline3,
        // ),
        // SizedBox(width: 20),
        // Expanded(child: Container()),
        Expanded(child: _searchbar())
      ],
    );
  }

  _changeSelectedProfile(ProfileDocument profile) {
    currentProfile = profile;
  }

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Search",
              style: themeProvider.themeData().textTheme.headline3,
            ),
            const SizedBox(width: 20),
            profileSelector(profiles, currentProfile, _changeSelectedProfile),
          ],
        ),
        SizedBox(height: 20),
        _topBar(),
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

  Widget _searchbar() {
    return Container(
      height: 40,
      child: TextFormField(
          style: TextStyle(fontSize: 12),
          cursorWidth: 1,
          keyboardType: TextInputType.number,
          controller: _controller,
          onChanged: (change) {
            setState(() {
              _loadNewData();
            });
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: (const Color(0xFF272837)),
            hintText: "search ...",
            hintStyle: TextStyle(letterSpacing: 0.3),
          )),
    );
  }
}
