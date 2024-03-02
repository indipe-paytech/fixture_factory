import 'package:fixture_factory/src/factory/case_strategy.dart';
import 'package:recase/recase.dart';

mixin FactoryRelations<T> {

  CaseStrategy get caseStrategy => CaseStrategy.snakeCase;

  String _recaseBasedOnCaseStrategy(String original) => switch (caseStrategy) {
    CaseStrategy.camelCase => original.camelCase,
    CaseStrategy.snakeCase => original.snakeCase,
    CaseStrategy.pascalCase => original.pascalCase,
    CaseStrategy.constantCase => original.constantCase,
    CaseStrategy.sentenceCase => original.sentenceCase,
    CaseStrategy.dotCase => original.dotCase,
    CaseStrategy.paramCase => original.paramCase,
    CaseStrategy.pathCase => original.pathCase,
    CaseStrategy.headerCase => original.headerCase,
    CaseStrategy.titleCase => original.titleCase,
  };

  String getSingleRelationshipName() {
    return _recaseBasedOnCaseStrategy(T.toString());
  }

  String getPluralRelationshipName() {
    return _recaseBasedOnCaseStrategy("${T}s");
  }
}