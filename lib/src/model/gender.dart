class Gender {
  final int id;
  final String name;

  String error = '';

  Gender(this.id, this.name);

  factory Gender.fromJson(dynamic json) {
    if (json == null) {
      return Gender(0, '');
    }
    return Gender( json['id'], json['name']);
  }
}