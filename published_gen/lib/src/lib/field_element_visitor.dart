import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';

import 'field_blueprint.dart';

final stripGenericType = (String type) {
  final start = type.indexOf("<");
  return start != -1 ? type.substring(start + 1, type.length - 1) : type;
};

class FieldElementVisitor extends SimpleElementVisitor {
  final List<FieldBlueprint> fields = [];

  @override
  visitFieldElement(FieldElement element) {
    if (!element.name.startsWith("\$")) return;

    final fieldType = element.type.toString();

    if (!fieldType.startsWith("BehaviorSubject")) {
      throw Exception("Field is not of type Published");
    }

    final type = fieldType.toString().substring(
          fieldType.toString().indexOf("<") + 1,
          fieldType.toString().length - 1,
        );

    print("Processing field : ${element.name} of type $type");

    final field = FieldBlueprint(
      name: element.name,
      type: type,
    );

    fields.add(field);
  }
}
