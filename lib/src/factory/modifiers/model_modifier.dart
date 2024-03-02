import 'package:fixture_factory/src/factory/modifiers/modifier.dart';
import 'package:fixture_factory/src/factory/types.dart';

class ModelModifier<T> extends Modifier<T> {
  final ValueUpdater<T> modelModifier;

  JSON Function(T model) toJson;

  T Function(JSON json) fromJson;

  ModelModifier(
    this.modelModifier, {
    required this.toJson,
    required this.fromJson,
  });

  @override
  JSON call(JSON json) {
    var model = fromJson(json);

    model = modelModifier(model);

    return toJson(model);
  }
}
