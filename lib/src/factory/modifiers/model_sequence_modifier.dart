import 'package:fixture_factory/src/factory/modifiers/sequence/sequence_modifier.dart';
import 'package:fixture_factory/src/factory/types.dart';

class ModelSequenceModifier<M, T extends ValueUpdater<M>>
    extends SequenceModifier<M, T> {
  JSON Function(M model) toJson;

  M Function(JSON json) fromJson;

  ModelSequenceModifier(
    super.sequence, {
    required this.toJson,
    required this.fromJson,
  });

  @override
  JSON call(JSON json) {
    var model = fromJson(json);

    var modelModifier = sequence.get();
    model = modelModifier(model);

    return toJson(model);
  }
}
