import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:published/published.dart';
import 'package:source_gen/source_gen.dart';

import 'field_blueprint.dart';

final _publisherTypeChecker = TypeChecker.fromRuntime(Publisher);

class FieldElementVisitor extends SimpleElementVisitor {
  final List<FieldBlueprint> fields = [];

  @override
  visitFieldElement(FieldElement element) {
    if (!element.isAbstract) return;

    final annotation = _publisherTypeChecker.firstAnnotationOf(element);

    final defaultValueReader = ConstantReader(annotation).peek("defaultValue");

    final isGenericType = element.type is TypeParameterType;

    if (defaultValueReader != null && !isGenericType) {
      final checker = TypeChecker.fromStatic(element.type);
      if (!defaultValueReader.instanceOf(checker))
        throw InvalidGenerationSourceError(
          "Default value of ${element.name} is not of type ${element.type}",
          element: element,
        );
    }

    final field = FieldBlueprint(
      name: element.name.replaceFirst("_", ""),
      type: element.type.toString(),
      isPublisher: annotation != null,
      defaultValue: !isGenericType ? defaultValueReader?.literalValue : null,
      isFinal: element.isFinal,
      isPrivate: element.isPrivate,
    );

    fields.add(field);
  }
}
