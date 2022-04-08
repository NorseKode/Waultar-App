import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:waultar/configs/globals/category_enums.dart';
import 'package:waultar/core/models/ui_model.dart';
import 'package:waultar/domain/services/text_search_service.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_widget.dart';

class SearchBarButton extends StatefulWidget {
  const SearchBarButton({Key? key}) : super(key: key);

  @override
  State<SearchBarButton> createState() => _SearchBarButtonState();
}

class _SearchBarButtonState extends State<SearchBarButton> {
  late ThemeProvider themeProvider;
  var serachController = TextEditingController();
  late Map<CategoryEnum, bool> chosenCategories;
  late StateSetter _setState;

  final _textSearchService = TextSearchService();
  final _scrollController = ScrollController();
  var _contents = <UIModel>[];

  var _offset = 0;
  final _limit = 20;

  _serach(bool isAppend) {
    _setState(() {
      if (serachController.text.isEmpty) {
        _contents = [];
        return;
      }

      var categories = chosenCategories.entries
          .where((element) => element.value)
          .map((e) => e.key)
          .toList();
      isAppend
          ? _contents += _textSearchService.search(
              categories, serachController.text, _offset, _limit)
          : _contents = _textSearchService.search(
              categories, serachController.text, _offset, _limit);
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
    chosenCategories = {
      CategoryEnum.posts: true,
      CategoryEnum.comments: false,
      CategoryEnum.files: false
    };
    super.initState();
    _scrollController.addListener(_onScrollEnd);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_onScrollEnd);
  }

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);

    return Expanded(
      flex: 4,
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: themeProvider.themeData().primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: TextField(
          controller: serachController,
          readOnly: true,
          onTap: () {
            _showserachDialog();
          },
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 15),
              border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              fillColor: themeProvider.themeData().primaryColor,
              filled: true,
              hintText: "serach ..."),
          style: TextStyle(
            color: themeProvider.themeMode().tonedTextColor,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  void _showserachDialog() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            _setState = setState;
            return Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const SizedBox(width: 250),
                  Expanded(flex: 1, child: Container()),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        Container(
                            child: Dialog(
                          backgroundColor: Colors.transparent,
                          insetPadding: EdgeInsets.zero,
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [
                              Container(
                                constraints:
                                    const BoxConstraints(maxHeight: 40),
                                child: TextField(
                                  onChanged: (change) {
                                    // call text search
                                    _setState(() {
                                      _loadNewData();
                                    });
                                  },
                                  controller: serachController,
                                  autofocus: true,
                                  decoration: InputDecoration(
                                      hoverColor: Colors.transparent,
                                      contentPadding:
                                          const EdgeInsets.only(left: 15),
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10))),
                                      fillColor: themeProvider
                                          .themeData()
                                          .primaryColor,
                                      filled: true,
                                      hintText: "serach ..."),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: serachController.text.isEmpty
                                        ? themeProvider
                                            .themeMode()
                                            .tonedTextColor
                                        : Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color:
                                        themeProvider.themeData().primaryColor,
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10))),
                                padding:
                                    const EdgeInsets.fromLTRB(15, 0, 15, 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 5),
                                    _categorySerachList(),
                                    _serachResults(),
                                    Row()
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                        Expanded(child: Container())
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(flex: 2, child: Container()),
                ],
              ),
            );
          });
        });
  }

  Widget _categorySerachList() {
    // var sortedCat =
    //     SplayTreeMap<CategoryEnum, bool>.from(chosenCategories, (key1, key2) {
    //   if (chosenCategories[key2]! && !chosenCategories[key1]!) {
    //     return 1;
    //   }
    //   return -1;
    // });

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
            chosenCategories.length,
            (index) => Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      _setState(() {
                        chosenCategories.update(
                            chosenCategories.keys.elementAt(index),
                            (value) => !value);
                        _loadNewData();
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 10),
                      decoration: BoxDecoration(
                          color: chosenCategories.values.elementAt(index)
                              ? const Color(0xFF323346)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: [
                          Icon(Iconsax.document,
                              size: 12,
                              color: themeProvider.themeMode().tonedTextColor),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            chosenCategories.keys.elementAt(index).name,
                            style:
                                themeProvider.themeData().textTheme.headline4,
                          )
                        ],
                      ),
                    ),
                  ),
                )),
      ),
    );
  }

  Widget _serachResults() {
    // var trueMap =
    //     chosenCategories.entries.where((element) => element.value == true);
    return Container(
      constraints: const BoxConstraints(maxHeight: 400),
      child:
//_contents[index].getMostInformativeField(),
//map: _contents[index].toString(),
          ListView.builder(
        controller: _scrollController,
        itemCount: _contents.length,
        itemBuilder: (_, index) => Container(
          child: Container(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _contents[index].getMostInformativeField(),
                        style: themeProvider.themeData().textTheme.headline1,
                      ),
                      SizedBox(height: 15),
                      Text(
                        _contents[index].toString(),
                      )
                    ])),
          ),
        ),
      ),

      // SingleChildScrollView(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: List.generate(
      //         trueMap.length,
      //         (index) => Container(
      //               padding: const EdgeInsets.only(top: 15),
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Text(trueMap.elementAt(index).key.name,
      //                       style: themeProvider.themeData().textTheme.headline4
      //                       //?.copyWith(fontWeight: FontWeight.w200)
      //                       ),
      //                   const SizedBox(height: 15),
      //                   Container(
      //                     color: const Color(0xFF323346),
      //                     height: 20,
      //                   )
      //                 ],
      //               ),
      //             )),
      //   ),
      // ),
    );
  }
}
