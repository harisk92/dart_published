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

    if (field.defaultValue is String) {
      return "this.\$${field.name} = BehaviorSubject.seeded(${field.name} ?? \"${field.defaultValue}\")";
    }

    return "this.\$${field.name} = BehaviorSubject.seeded(${field.name} ?? ${field.defaultValue})";
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
    class $name extends ${parentClassName}Builder{
      ${fields.where((element) => !element.isPublisher).map(fieldDefinition).join("\n")}
      
      ${fields.where((element) => element.isPublisher).map(fieldDefinition).join("\n")}
      
     
      $name({${fields.map(parameterDefinition).join(",")}}):${fields.map(parameterAssignment).join(",")}{
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
        ${fields.map((field) => "\$${field.name}.close();").join("\n")}
      }
    }
    ''';
  }
}
