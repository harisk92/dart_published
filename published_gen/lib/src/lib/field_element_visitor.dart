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
    if (!element.isAbstract) return;

    final annotation = _publisherTypeChecker.firstAnnotationOf(element);

    final defaultValueReader = ConstantReader(annotation).peek("defaultValue");

    if (defaultValueReader != null) {
      final checker = TypeChecker.fromStatic(element.type);
      if (!defaultValueReader.instanceOf(checker))
        throw InvalidGenerationSourceError(
          "Default value of ${element.name} is not of type ${element.type}",
          element: element,
        );
    }

    final field = FieldBlueprint(
      name:
          element.isPrivate ? element.name.replaceFirst("_", "") : element.name,
      type: element.type.toString(),
      isPublisher: annotation != null,
      defaultValue: defaultValueReader?.literalValue,
      isFinal: element.isFinal,
      isPrivate: element.isPrivate,
    );

    fields.add(field);
  }
}
