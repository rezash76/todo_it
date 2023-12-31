abstract base class Entity {
  final String id;

  const Entity({required this.id});

  @override
  bool operator ==(Object other) {
    if (other is! Entity) {
      return false;
    }

    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
