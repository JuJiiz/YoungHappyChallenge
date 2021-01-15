abstract class Result<T> {}

class Success<T> implements Result<T> {
  final T data;

  const Success([this.data]);
}

class Failure<T> implements Result<T> {
  final String message;

  const Failure(this.message);
}
