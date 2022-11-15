enum ResponseStatus {
  init,
  success,
  failed,
  loading,
  ;

  bool get isLoading => this == ResponseStatus.loading;
  bool get isSuccess => this == ResponseStatus.success;
  bool get isFailed => this == ResponseStatus.failed;
}
