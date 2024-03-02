import 'package:fixture_factory/src/factory/modifiers/modifier.dart';
import 'package:fixture_factory/src/factory/modifiers/sequence/sequence.dart';

abstract class SequenceModifier<M, S> extends Modifier<M> {
  final Sequence<S> sequence;

  SequenceModifier(this.sequence);
}