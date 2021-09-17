import 'package:published_gen/src/lib/field_blueprint.dart';

class ChildClassTemplate {
  final String name;
  final String parentClassName;
  final List<FieldBlueprint> fields;

  ChildClassTemplate({
    required this.name,
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

  String parameterAssignment(FieldBlueprint field) {
    if (!field.isPublisher) return "this.${field.name} = ${field.name}";

    if (field.defaultValue == null)
      return "this.\$${field.name} = BehaviorSubject.seeded(${field.name})";

    return "this.\$${field.name} = BehaviorSubject.seeded(${field.defaultValue})";
  }

  String fieldDefinition(FieldBlueprint field) {
    final name = field.name;
    final type = field.type;

    if (field.isPublisher) return "final BehaviorSubject<$type> \$$name;";
    if (field.isFinal) return "final $type $name;";

    return "$type $name;";
  }

  @override
  String toString() {
    return '''
    class $name extends $parentClassName{
      ${fields.where((element) => !element.isPublisher).map(fieldDefinition).join("\n")}
      
      ${fields.where((element) => element.isPublisher).map(fieldDefinition).join("\n")}
      
      
      $name({${fields.map(parameterDefinition).join(",")}}):${fields.map(parameterAssignment).join(",")};
      
      ${fields.where((element) => element.isPublisher).map((field) => field.getterTemplate).join("\n")}
      
      ${fields.where((element) => element.isPublisher).map((field) => field.setterTemplate).join("\n")}

      
      @override
      void dispose(){
        super.dispose();
        ${fields.map((field) => "\$${field.name}.close();").join("\n")}
      }
    }
    ''';
  }
}
