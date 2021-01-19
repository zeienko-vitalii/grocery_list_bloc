part of 'base_bloc.dart';

@immutable
abstract class BaseBlocState {
  const BaseBlocState();
}

class InitialBaseState extends BaseBlocState {
  const InitialBaseState() : super();
}

abstract class BaseProcessState extends BaseBlocState {
  const BaseProcessState({this.data});

  final dynamic data;
}

@immutable
class ErrorState extends BaseProcessState {
  const ErrorState([dynamic data]) : super(data: data);
}

@immutable
class SuccessState extends BaseProcessState {
  const SuccessState([dynamic data]) : super(data: data);
}

@immutable
class LoadingState extends BaseProcessState {
  const LoadingState([dynamic data]) : super(data: data);
}
