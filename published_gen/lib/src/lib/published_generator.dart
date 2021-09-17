import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:published/published.dart';
import 'package:source_gen/source_gen.dart';

import 'field_element_visitor.dart';
import 'templates/class_template.dart';
import 'templates/extension_template.dart';

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

    final classTemplate = ClassTemplate(
      name: targetClassName,
      parentClassName: className,
      fields: fields,
      constructor: element.getNamedConstructor("make"),
    );

    final extensionTemplate = ExtensionTemplate(
        name: className,
        getters: fields.map((field) => field.getterTemplate).toList(),
        setters: fields.map((field) => field.setterTemplate).toList());

    for (final template in [extensionTemplate, classTemplate]) {
      yield "$template \n";
    }
  }
}
