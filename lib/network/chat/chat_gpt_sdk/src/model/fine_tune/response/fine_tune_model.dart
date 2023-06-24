import 'package:creative_production_desktop/network/chat/chat_gpt_sdk/src/model/fine_tune/response/fine_tune_event.dart';
import 'package:creative_production_desktop/network/chat/chat_gpt_sdk/src/model/fine_tune/response/fine_tune_hyper_params.dart';
import 'package:creative_production_desktop/network/chat/chat_gpt_sdk/src/model/fine_tune/response/training_files.dart';

class FineTuneModel {
  /// The ID of the fine-tuning job.
  final String id;

  /// The model used for fine-tuning.
  final String model;

  /// The date the fine-tuning job was created.
  final DateTime createdAt;

  /// The events generated by the fine-tuning job.
  final List<FineTuneEvent>? events;

  /// The fine-tuned model.
  final String? fineTunedModel;

  /// The hyper parameters used for fine-tuning.
  final FineTuneHyperParams? hyperparams;

  /// The ID of the organization that owns the fine-tuning job.
  final String? organizationId;

  /// The result files generated by the fine-tuning job.
  final List<String> resultFiles;

  /// The status of the fine-tuning job.
  final String status;

  /// The validation files used for fine-tuning.
  final List<String>? validationFiles;

  /// The training files used for fine-tuning.
  final List<TrainingFiles?> trainingFiles;

  /// The date the fine-tuning job was last updated.
  final DateTime? updatedAt;

  /// {@macro openai_fine_tune_model}
  const FineTuneModel({
    required this.id,
    required this.model,
    required this.createdAt,
    required this.events,
    required this.fineTunedModel,
    required this.hyperparams,
    required this.organizationId,
    required this.resultFiles,
    required this.status,
    required this.validationFiles,
    required this.trainingFiles,
    required this.updatedAt,
  });

  factory FineTuneModel.formJson(Map<String, dynamic> json) {
    return FineTuneModel(
      id: json['id'],
      model: json['model'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        json['created_at'] == null ? 0 : json['created_at'] * 1000,
      ),
      events: (json['events'] as List?)
          ?.map((e) => FineTuneEvent.fromJson(e))
          .toList(),
      fineTunedModel: json['fine_tuned_model'],
      hyperparams: FineTuneHyperParams.fromJson(json['hyperparams']),
      organizationId: json['organization_id'],
      resultFiles:
          (json['result_files'] as List).map((e) => e.toString()).toList(),
      status: json['status'],
      validationFiles:
          (json['validation_files'] as List).map((e) => e.toString()).toList(),
      trainingFiles: (json['training_files'] as List)
          .map((e) => TrainingFiles.fromJson(e))
          .toList(),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(
        json['updated_at'] == null ? 0 : json['updated_at'] * 1000,
      ),
    );
  }
}
