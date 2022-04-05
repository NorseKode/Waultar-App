import 'package:translator/translator.dart';
import 'package:waultar/core/abstracts/abstract_services/i_translator_service.dart';

class GoogleTranslatorService extends ITranslatorService {
  late GoogleTranslator _translator;

  GoogleTranslatorService({required GoogleTranslator translator}) {
    _translator = translator;
  }

  @override
  Future<String> translate(
      {required String input, String? inputLanguage, required String outputLanguage}) async {
    return (await _translator.translate(
      input,
      from: inputLanguage ?? "auto",
      to: outputLanguage,
    ))
        .text;
  }
}
