import 'dart:math';

import 'package:fixture_factory/src/factory/modifiers/sequence/json_sequence.dart';
import 'package:fixture_factory/src/factory/modifiers/sequence/model_sequence.dart';
import 'package:fixture_factory/src/factory/types.dart';

abstract class Sequence<T> {
  Sequence.values(this.sequence);

  factory Sequence(List<T> sequence) {
    if (T == JSON) {
      return JsonSequence(sequence.cast()) as Sequence<T>;
    }

    throw ArgumentError(
      "Use Sequence<JSON>() for JSON, or Sequence.apply<Model> for Updating Models",
      T.toString(),
    );
  }

  static apply<T>(List<ValueUpdater<T>> sequence) {
    return ModelSequence<T, ValueUpdater<T>>(sequence);
  }

  final List<T> sequence;

  int index = 0;
  late int totalCount = sequence.length;

  int getSequenceIndex() {
    var sequenceLength = sequence.length;
    var sequenceCount = (totalCount / sequenceLength).floor();
    var sequenceIndex = min((index / sequenceCount).floor(), sequenceCount - 1);

    return sequenceIndex;
  }

  T get() {
    return sequence[getSequenceIndex()];
  }
}
