import 'package:flutter/material.dart';
import 'package:waultar/core/abstracts/abstract_services/i_translator_service.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_widget.dart';
import 'package:waultar/startup.dart';

class TranslatorWidget extends StatefulWidget {
  const TranslatorWidget({Key? key}) : super(key: key);

  @override
  State<TranslatorWidget> createState() => _TranslatorWidgetState();
}

class _TranslatorWidgetState extends State<TranslatorWidget> {
  @override
  Widget build(BuildContext context) {
    return _mainBody();
  }

  final _translateService = locator.get<ITranslatorService>(instanceName: 'translator');
  final _inputTextController = TextEditingController();
  var _translatedText = "";

  _onTextChange(String change) async {
    var translated = "";
    if (change.isNotEmpty) {
      translated = await _translateService.translate(
        input: change,
        inputLanguage: 'da',
        outputLanguage: 'en',
      );
    }

    setState(() {
      _translatedText = translated;
    });
  }

  Widget _mainBody() {
    return DefaultWidget(
      constraints: const BoxConstraints(maxWidth: 500),
      title: "Translator",
      child: Column(
        children: [
          const Text("Try to write some danish text"),
          TextFormField(
            decoration: const InputDecoration(
              hintText: "Try to write something",
            ),
            controller: _inputTextController,
            onChanged: (var change) async => await _onTextChange(change),
          ),
          const Divider(),
          const Text("Translated Text"),
          Text(_translatedText),
        ],
      ),
    );
  }
}
