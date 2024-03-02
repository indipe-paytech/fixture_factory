import 'package:fixture_factory/src/factory/modifiers/sequence/sequence.dart';
import 'package:fixture_factory/src/factory/types.dart';

class ModelSequence<T, S extends ValueUpdater<T>> extends Sequence<S> {
  ModelSequence(super.modelModifiers) : super.values();
}
