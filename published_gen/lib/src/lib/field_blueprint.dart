import 'package:published_gen/src/lib/templates/getter_template.dart';

import 'templates/setter_template.dart';

class FieldBlueprint {
  final String name;
  final String type;
  final bool isPublisher;
  final bool isFinal;
  final Object? defaultValue;

  FieldBlueprint({
    required this.name,
    required this.type,
    this.defaultValue,
    this.isPublisher = false,
    this.isFinal = false,
  });

  GetterTemplate get getterTemplate => GetterTemplate(
        name: name.replaceFirst("\$", ""),
        type: type,
        fieldName: name,
      );

  SetterTemplate get setterTemplate => SetterTemplate(
        name: name.replaceFirst("\$", ""),
        type: type,
        fieldName: name,
      );

  bool get isRequired => !isNullable && defaultValue == null;

  bool get isNullable => type.endsWith("?");
}
