import 'package:published_gen/src/lib/field_blueprint.dart';

class ChildClassTemplate {
  final String name;
  final String parentClassName;
  final List<FieldBlueprint> fields;
  final String genericConstraints;

  ChildClassTemplate(
      {required this.name,
      required this.fields,
      required this.parentClassName,
      required this.genericConstraints});

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

  String parameterAssignment(FieldBlueprint field) {
    String privateExpression = field.isPrivate ? "_" : "";

    if (!field.isPublisher) {
      return "this.$privateExpression${field.name} = ${field.name}";
    }

    if (field.defaultValue == null)
      return "this.$privateExpression\$${field.name} = BehaviorSubject.seeded(${field.name})";

    if (field.defaultValue is String) {
      return "this.$privateExpression\$${field.name} = BehaviorSubject.seeded(${field.name} ?? \"${field.defaultValue}\")";
    }

    return "this.$privateExpression\$${field.name} = BehaviorSubject.seeded(${field.name} ?? ${field.defaultValue})";
  }

  String fieldDefinition(FieldBlueprint field) {
    final name = field.name;
    final type = field.type;

    if (field.isPublisher) return "final BehaviorSubject<$type> \$$name;";
    if (field.isFinal) {
      if (field.isPrivate) return "final $type _$name;";
      return "final $type $name;";
    }

    if (field.isPrivate) return "$type _$name;";

    return "$type $name;";
  }

  @override
  String toString() {
    return '''
    class $name$genericConstraints extends ${parentClassName}Builder$genericConstraints{
      ${fields.where((element) => !element.isPublisher).map(fieldDefinition).join("\n")}
      
      ${fields.where((element) => element.isPublisher).map(fieldDefinition).join("\n")}
      
     
      $name($parametersDefinition)${fields.isEmpty ? "" : ":"}${fields.map(parameterAssignment).join(",")}{
        this.shouldEnableLogger();
      }
      
      ${fields.where((element) => element.isPublisher).map((field) => field.getterTemplate).join("\n")}
      
      ${fields.where((element) => element.isPublisher).map((field) => field.setterTemplate).join("\n")}


     Stream get didChange => MergeStream([
       ${fields.where((element) => element.isPublisher).map((field) => "\$${field.name}").join(",")}
     ]);
     
     void shouldEnableLogger(){
         if(!enableLogging) return;
         
         didChange.listen(dumpLogOnChange).addTo(disposables);
     }
     
     void dumpLogOnChange(signal){
       print("------------------");
       print("DidChange:");
       print("$parentClassName{");
       ${fields.where((element) => element.isPublisher).map((field) => 'print(" ${field.name}: \${this.${field.name}}");').join("\n")}
       print("}");
       print("------------------");
     }
      
      @override
      void dispose(){
        super.dispose();
        ${fields.where((field) => field.isPublisher).map((field) => "\$${field.name}.close();").join("\n")}
      }
    }
    ''';
  }
}
