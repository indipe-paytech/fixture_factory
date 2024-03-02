import 'package:fixture_factory/src/factory/factory_json_serializable.dart';
import 'package:fixture_factory/src/factory/factory_relations.dart';
import 'package:fixture_factory/src/factory/modifiers/json_modifier.dart';
import 'package:fixture_factory/src/factory/modifiers/json_sequence_modifier.dart';
import 'package:fixture_factory/src/factory/modifiers/model_modifier.dart';
import 'package:fixture_factory/src/factory/modifiers/model_sequence_modifier.dart';
import 'package:fixture_factory/src/factory/modifiers/modifier.dart';
import 'package:fixture_factory/src/factory/modifiers/sequence/json_sequence.dart';
import 'package:fixture_factory/src/factory/modifiers/sequence/model_sequence.dart';
import 'package:fixture_factory/src/factory/modifiers/sequence/sequence.dart';
import 'package:fixture_factory/src/factory/modifiers/sequence/sequence_modifier.dart';
import 'package:fixture_factory/src/factory/types.dart';

abstract class FixtureFactory<T extends FixtureFactory<T, M>, M>
    with FactoryRelations<M>, FactoryJsonSerializable<M> {
  final List<Modifier<M>> _modifiers = [];

  // Constructor
  FixtureFactory(JSON? attributes) {
    if (attributes != null) {
      _modifiers.add(JsonModifier<M>(attributes));
    }
  }

  // Factory methods
  M definition();

  // Fixture modifiers
  T apply(ValueUpdater<M> modelModifier) {
    _modifiers.add(
      ModelModifier<M>(
        modelModifier,
        fromJson: fromJson,
        toJson: toJson,
      ),
    );

    return this as T;
  }

  T withAttribute(String key, value) {
    _modifiers.add(JsonModifier<M>({key: value}));

    return this as T;
  }

  T withAttributes(JSON attributes) {
    _modifiers.add(JsonModifier<M>(attributes));

    return this as T;
  }

  T sequence(Sequence sequence) {
    if (sequence is ModelSequence<M, ValueUpdater<M>>) {
      _modifiers.add(
        ModelSequenceModifier<M, ValueUpdater<M>>(
          sequence,
          fromJson: fromJson,
          toJson: toJson,
        ),
      );
    } else if (sequence is JsonSequence) {
      _modifiers.add(JsonSequenceModifier<M>(sequence));
    }
    return this as T;
  }

  // Relationship methods
  T withOne(FixtureFactory factory, {String? relation}) {
    return withAttribute(
      relation ?? factory.getSingleRelationshipName(),
      factory.makeJson(),
    );
  }

  T withMany(FixtureFactory factory, int count, {String? relation}) {
    return withAttribute(
      relation ?? factory.getPluralRelationshipName(),
      factory.makeManyJson(count),
    );
  }

  JSON makeJson() => _makeJson(index: 0, count: 1);

  // Make methods
  JSON _makeJson({
    required int index,
    required int count,
  }) {
    var initialAttributes = toJson(definition());

    return _modifiers.fold(
      initialAttributes,
      (json, modifier) {
        if (modifier is SequenceModifier) {
          var sequenceModifier = modifier as SequenceModifier;
          sequenceModifier.sequence.index = index;
          sequenceModifier.sequence.totalCount = count;
        }
        return modifier(json);
      },
    );
  }

  M make() => _make(index: 0, count: 1);

  M _make({required int index, required int count}) =>
      fromJson(_makeJson(index: index, count: count));

  List<JSON> makeManyJson(int count) => List.generate(
        count,
        (index) => _makeJson(index: index, count: count),
      );

  List<M> makeMany(int count) => List.generate(
        count,
        (index) => _make(index: index, count: count),
      );
}
