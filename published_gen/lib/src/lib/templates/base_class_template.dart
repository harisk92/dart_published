import 'package:published_gen/src/lib/field_blueprint.dart';

class BaseClassTemplate {
  final String name;
  final List<FieldBlueprint> fields;

  BaseClassTemplate({
    required this.name,
    required this.fields,
  });

  String fieldDefinition(FieldBlueprint field) {
    final type = field.type;
    final name = field.name;
    return "abstract final BehaviorSubject<$type> \$$name;";
  }

  @override
  String toString() {
    return '''
    abstract class _\$${name} extends ObservableObject{
       ${fields.map(fieldDefinition).join("\n")}
    }
    ''';
  }
}
