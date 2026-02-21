enum Gender {
  male("Male"),
  female("Female");

  final String label;
  const Gender(this.label);

  static Gender fromLabel(String label) {
    return switch (label.toLowerCase()) {
      "male" => Gender.male,
      "female" => Gender.female,
      _ => throw ArgumentError("Invalid gender label: $label"),
    };
  }
}
