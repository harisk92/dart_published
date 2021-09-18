import '../field_blueprint.dart';

class ClassBuilderTemplate {
  final String parentClassName;
  final List<FieldBlueprint> fields;

  ClassBuilderTemplate({
    required this.fields,
    required this.parentClassName,
  });

  String parameterDefinition(FieldBlueprint field) {
    final name = field.name;
    final type = field.type;

    if (field.isRequired) return "required $type $name";
    if (!field.isNullable) return "$type? $name";
    return "$type $name";
  }

  @override
  String toString() {
    final className = "${parentClassName}Builder";

    return '''
     abstract class $className extends $parentClassName{
       $className();
       
       factory $className.build({${fields.map(parameterDefinition).join(",")}}) => _$parentClassName(${fields.map((field) => "${field.name}:${field.name}").join(",")});
    }
    ''';
  }
}
