abstract class INoParamUseCase<T> {
  Future<T> invoke();
}

abstract class IUseCase<T, P> {
  Future<T> invoke(P params);
}
