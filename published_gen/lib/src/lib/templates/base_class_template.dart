import 'package:published_gen/src/lib/field_blueprint.dart';

class BaseClassTemplate {
  final String name;
  final List<FieldBlueprint> fields;
  final String genericConstraints;

  BaseClassTemplate({
    required this.name,
    required this.fields,
    required this.genericConstraints,
  });

  String fieldDefinition(FieldBlueprint field) {
    final type = field.type;
    final name = field.name;
    return "abstract final BehaviorSubject<$type> \$$name;";
  }

  @override
  String toString() {
    return '''
    abstract class _\$${name}$genericConstraints extends ObservableObject{
       ${fields.where((field) => field.isPublisher).map(fieldDefinition).join("\n")}
       
       abstract final Stream didChange;
       
       bool get enableLogging => false;
       
       void onBind(){}
    }
    ''';
  }
}

class ClassField {
  final String name;
  final String type;
  final bool isAbstract;
  final bool isFinal;
  final bool isPrivate;
  final bool isNullable;

  ClassField({
    required this.name,
    required this.type,
    this.isAbstract = false,
    this.isFinal = false,
    this.isPrivate = false,
    this.isNullable = false,
  });

  String get fieldName => isPrivate ? "_$name" : name;
}
