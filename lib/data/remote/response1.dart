class Response1<T> {
  Response1._();

  factory Response1.success(T data) = Success<T>;

  factory Response1.error(String message) = Error<T>;
}

class Success<T> extends Response1<T> {
  final T value;

  Success(this.value) : super._();
}

class Error<T> extends Response1<T> {
  final String message;

  Error(this.message) : super._();
}
