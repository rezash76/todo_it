part of 'cat_bloc.dart';

sealed class CatEvent extends Equatable {
  const CatEvent();

  @override
  List<Object> get props => [];
}

class GetCat extends CatEvent {}

class SetCat extends CatEvent {
  final TaskCategory cat;

  const SetCat(this.cat);

  @override
  List<Object> get props => [cat];
}
