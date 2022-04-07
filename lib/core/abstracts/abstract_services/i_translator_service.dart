abstract class ITranslatorService {
  Future<String> translate({
    required String input,
    String? inputLanguage,
    required String outputLanguage,
  });
}
