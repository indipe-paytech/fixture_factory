import 'package:fixture_factory/src/factory/types.dart';

abstract class Modifier<T> {
  JSON call(JSON json);
}
