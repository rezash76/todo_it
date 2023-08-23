import 'package:equatable/equatable.dart';

abstract base class Entity extends Equatable {
  final String id;

  const Entity(this.id);

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

  @override
  List<Object?> get props => [id];
}
