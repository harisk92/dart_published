class SetterTemplate {
  final String name;
  final String type;
  final String fieldName;

  SetterTemplate({
    required this.name,
    required this.type,
    required this.fieldName,
  });

  String get definition => "set $name($type value)";

  @override
  String toString() {
    return "$definition => this.\$$fieldName.add(value);";
  }
}
