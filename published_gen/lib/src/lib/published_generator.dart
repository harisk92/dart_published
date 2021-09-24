import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:published/published.dart';
import 'package:published_gen/src/lib/templates/class_builder_template.dart';
import 'package:source_gen/source_gen.dart';

import 'field_element_visitor.dart';
import 'templates/base_class_template.dart';
import 'templates/child_class_template.dart';

extension on ClassElement {
  String get genericConstraints {
    final value = thisType.toString();
    final index = value.indexOf("<");
    return index == -1 ? "" : value.substring(index, value.length);
  }
}

class PublishedGenerator extends GeneratorForAnnotation<Published> {
  @override
  Stream<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async* {
    if (element is! ClassElement)
      throw InvalidGenerationSourceError(
        "Can be only used on class",
        element: element,
      );

    if (!element.isAbstract) {
      throw InvalidGenerationSourceError(
        "Can be only used on abstract class",
        element: element,
      );
    }

    final visitor = FieldElementVisitor();

    element.visitChildren(visitor);

    final className = element.name;
    final targetClassName = "_$className";
    final fields = visitor.fields;

    final childClassTemplate = ChildClassTemplate(
      name: targetClassName,
      parentClassName: className,
      fields: fields,
      genericConstraints: element.genericConstraints,
    );

    final baseClassTemplate = BaseClassTemplate(
      name: className,
      fields: fields,
      genericConstraints: element.genericConstraints,
    );

    final classBuilderTemplate = ClassBuilderTemplate(
      fields: fields,
      parentClassName: className,
      genericConstraints: element.genericConstraints,
    );

    yield "//ignore_for_file: close_sinks";

    for (final template in [
      baseClassTemplate,
      classBuilderTemplate,
      childClassTemplate,
    ]) {
      yield "$template \n";
    }
  }
}
