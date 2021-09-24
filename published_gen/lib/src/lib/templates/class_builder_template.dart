import '../field_blueprint.dart';

class ClassBuilderTemplate {
  final String parentClassName;
  final List<FieldBlueprint> fields;
  final String genericConstraints;

  ClassBuilderTemplate({
    required this.fields,
    required this.parentClassName,
    required this.genericConstraints,
  });

  String parameterDefinition(FieldBlueprint field) {
    final name = field.name;
    final type = field.type;

    if (field.isRequired) return "required $type $name";
    if (!field.isNullable) return "$type? $name";
    return "$type $name";
  }

  String get parametersDefinition {
    if (fields.isEmpty) return "";
    return "{${fields.map(parameterDefinition).join(",")}}";
  }

  @override
  String toString() {
    final className = "${parentClassName}Builder";

    return '''
     abstract class $className$genericConstraints extends $parentClassName$genericConstraints{
       $className();
       
       factory $className.build($parametersDefinition) => _$parentClassName(${fields.map((field) => "${field.name}:${field.name}").join(",")});
    }
    ''';
  }
}
