import 'package:waultar/core/ai/i_ml_model.dart';

class AIException implements Exception {
  final String message;
  final IMLModel aiModel;
  final dynamic object;

  AIException(this.message, this.aiModel, this.object);
}