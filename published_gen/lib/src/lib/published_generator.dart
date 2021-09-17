import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:published/published.dart';
import 'package:source_gen/source_gen.dart';

import 'field_element_visitor.dart';
import 'templates/base_class_template.dart';
import 'templates/child_class_template.dart';

class PublishedGenerator extends GeneratorForAnnotation<PublishedAnnotation> {
  @override
  Stream<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async* {
    if (element is! ClassElement)
      throw UnsupportedError("Can be only used on Class");

    final visitor = FieldElementVisitor();

    element.visitChildren(visitor);

    final className = element.name;
    final targetClassName = "_$className";
    final fields = visitor.fields;

    final childClassTemplate = ChildClassTemplate(
      name: targetClassName,
      parentClassName: className,
      fields: fields,
    );

    final baseClassTemplate = BaseClassTemplate(
      name: className,
      fields: fields,
    );

    for (final template in [baseClassTemplate, childClassTemplate]) {
      yield "$template \n";
    }
  }
}
