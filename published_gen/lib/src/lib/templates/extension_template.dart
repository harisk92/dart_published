import 'package:published_gen/src/lib/templates/setter_template.dart';

import 'getter_template.dart';

class ExtensionTemplate {
  final String name;
  final List<GetterTemplate> getters;
  final List<SetterTemplate> setters;

  ExtensionTemplate({
    required this.name,
    required this.getters,
    required this.setters,
  });

  @override
  String toString() {
    return '''
    extension ${name}Extension on $name{
       ${getters.join("\n")}
       
       ${setters.join("\n")}
    }
    ''';
  }
}
