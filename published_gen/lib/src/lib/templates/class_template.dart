import 'package:analyzer/dart/element/element.dart';
import 'package:published_gen/src/lib/field_blueprint.dart';

class ClassTemplate {
  final String name;
  final String parentClassName;
  final List<FieldBlueprint> fields;
  final ConstructorElement? constructor;

  ClassTemplate({
    required this.name,
    required this.fields,
    required this.parentClassName,
    this.constructor,
  });

  @override
  String toString() {
    //
    final ConstructorElement? factoryConstructor = constructor;

    if (factoryConstructor == null) return "";
    final constructorDefinition = factoryConstructor.declaration
        .toString()
        .replaceFirst("$parentClassName.make", "")
        .replaceFirst(parentClassName, "");

    final baseClassConstructor =
        "super(${factoryConstructor.parameters.map((param) => param.name).map((name) => "$name:$name").join(",")})";

    return '''
    class $name extends $parentClassName{
      $name$constructorDefinition:$baseClassConstructor;
      
      @override
      void dispose(){
        super.dispose();
        ${fields.map((field) => "${field.name}.close();").join("\n")}
      }
    }
    ''';
  }
}
