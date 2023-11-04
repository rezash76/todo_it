part of 'cat_bloc.dart';

sealed class CatState extends Equatable {
  const CatState();

  @override
  List<Object> get props => [];
}

final class CatInitial extends CatState {}

class GetCatSuccess extends CatState {
  final TaskCategory cat;

  const GetCatSuccess(this.cat);

  @override
  List<Object> get props => [cat];
}

class GetCatError extends CatState {
  final String message;

  const GetCatError(this.message);
}
