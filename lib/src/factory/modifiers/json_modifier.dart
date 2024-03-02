import 'package:fixture_factory/src/factory/modifiers/modifier.dart';
import 'package:fixture_factory/src/factory/types.dart';

class JsonModifier<T> extends Modifier<T> {
  final JSON attributes;

  JsonModifier(this.attributes);

  @override
  JSON call(JSON json) {
    return json..addAll(attributes);
  }
}
