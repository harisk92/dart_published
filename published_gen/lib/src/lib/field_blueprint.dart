import 'package:published_gen/src/lib/templates/getter_template.dart';

import 'templates/setter_template.dart';

class FieldBlueprint {
  final String name;
  final String type;

  FieldBlueprint({
    required this.name,
    required this.type,
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
}
