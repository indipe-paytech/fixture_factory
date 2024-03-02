import 'package:fixture_factory/src/factory/modifiers/sequence/sequence_modifier.dart';
import 'package:fixture_factory/src/factory/types.dart';

class JsonSequenceModifier<M> extends SequenceModifier<M, JSON> {
  JsonSequenceModifier(super.sequence);

  @override
  JSON call(JSON json) {
    return json..addAll(sequence.get());
  }
}
