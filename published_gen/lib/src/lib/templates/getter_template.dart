class GetterTemplate {
  final String name;
  final String type;
  final String fieldName;

  GetterTemplate({
    required this.name,
    required this.type,
    required this.fieldName,
  });

  String get definition => "$type get $name";

  @override
  String toString() {
    return "$definition => this.\$$fieldName.value;";
  }
}
