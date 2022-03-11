import 'package:flutter/material.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_post_repository.dart';
import 'package:waultar/core/models/ui_model.dart';
import 'package:waultar/presentation/widgets/snackbar_custom.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:waultar/startup.dart';

settingsBar() {
  return const Text("settings");
  // return CheckboxListTile(
  //     title: Text("Category"), // get from repo
  //     controlAffinity: ListTileControlAffinity.platform,
  //     activeColor: category.color,
  //     value: _checked,
  //     onChanged: (bool value) {
  //       setState(() {
  //         _checked = value;
  //       });
  //     });
}

class Timeline2 extends StatefulWidget {
  const Timeline2({Key? key}) : super(key: key);

  @override
  _Timeline2State createState() => _Timeline2State();
}

class _Timeline2State extends State<Timeline2> {
  late AppLocalizations localizer;
  bool _isFirstLoad = false;
  bool _isLoading = false;
  // ignore: prefer_final_fields
  var _content = <UIModel>[];
  final _scrollController = ScrollController();
  dynamic _selectedContent;
  var _offset = 0;
  final _limit = 20;
  final IPostRepository _postRepo =
      locator.get<IPostRepository>(instanceName: "postRepo");

  _firstLoad() {
    setState(() {
      _isFirstLoad = true;
    });

    _loadData();

    setState(() {
      _isFirstLoad = false;
    });
  }

  _loadData() {
    var newData = _postRepo.getAllPostsPagination(_offset, _limit);

    if (newData != null) {
      _content.addAll(newData);
      _offset += _limit;
    } else {
      SnackBarCustom.useSnackbarOfContext(context, localizer.noData);
    }
  }

  _onPageEnd() {
    if (_scrollController.position.maxScrollExtent ==
        _scrollController.position.pixels) {
      setState(() {
        _isLoading = true;
      });

      _loadData();

      setState(() {
        _isLoading = false;
      });
    }
  }

  timelineLeftSide(UIModel model, int index) {
    var time = model.getTimestamp();

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedContent = _content[index];
          });
        },
        child: SizedBox(
          height: 120,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: SizedBox(
                  width: 35,
                  child: Text("${time.year}\n${time.month}\n${time.day}"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: SizedBox(
                  width: 35,
                  height: 35,
                  child: Container(
                    decoration: BoxDecoration(
                        color: model.getAssociatedColor(),
                        shape: BoxShape.circle),
                  ),
                ),
              ),
              Expanded(
                  child: Text(
                model.getMostInformativeField(),
                textAlign: TextAlign.left,
                overflow: TextOverflow.fade,
              )),
            ],
          ),
        ),
      ),
    );
  }

  timelineRightSide(Map<String, dynamic> inputMap) {
    var keys = inputMap.keys.toList();

    return ListView.builder(
      itemCount: keys.length,
      itemBuilder: (_, index) =>
          Text("${keys[index]}: ${inputMap[keys[index]]}"),
    );
  }

  _contentList() {
    return ListView.builder(
        controller: _scrollController,
        itemCount: _content.length,
        itemBuilder: (_, index) => timelineLeftSide(_content[index], index));
  }

  @override
  void initState() {
    super.initState();
    _firstLoad();
    _scrollController.addListener(_onPageEnd);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_onPageEnd);
  }

  @override
  Widget build(BuildContext context) {
    localizer = AppLocalizations.of(context)!;

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: _isFirstLoad || _isLoading
              ? const CircularProgressIndicator()
              : Column(
                  children: [
                    Expanded(flex: 1, child: settingsBar()),
                    Expanded(
                      flex: 8,
                      child: _content.isEmpty
                          ? Text(localizer.noData)
                          : Stack(
                              children: [
                                const SizedBox(
                                  width: 125,
                                  child: VerticalDivider(
                                    thickness: 5,
                                  ),
                                ),
                                _contentList(),
                              ],
                            ),
                    ),
                  ],
                ),
        ),
        const VerticalDivider(
          thickness: 5,
        ),
        Expanded(
          flex: 1,
          child: _selectedContent == null
              ? Container(
                  child: _content.isEmpty
                      ? Text(localizer.noData)
                      : const Text("Press on some contect"),
                )
              : timelineRightSide(
                  _selectedContent.toMap(),
                ),
        )
      ],
    );
  }
}
