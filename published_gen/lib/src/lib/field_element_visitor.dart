import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:published/published.dart';
import 'package:source_gen/source_gen.dart';

import 'field_blueprint.dart';

final _publisherTypeChecker = TypeChecker.fromRuntime(Publisher);

final stripGenericType = (String type) {
  final start = type.indexOf("<");
  return start != -1 ? type.substring(start + 1, type.length - 1) : type;
};

class FieldElementVisitor extends SimpleElementVisitor {
  final List<FieldBlueprint> fields = [];

  @override
  visitFieldElement(FieldElement element) {
    final annotation = _publisherTypeChecker.firstAnnotationOf(element);
    /*if (annotation != null) {
      final reader = ConstantReader(annotation);
      final String value = reader.read("defaultValue").literalValue.toString();
      print(value);
    }*/

    final field = FieldBlueprint(
      name: element.name,
      type: element.type.toString(),
      isPublisher: annotation != null,
    );

    fields.add(field);
  }
}
