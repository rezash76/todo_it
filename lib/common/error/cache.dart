import 'package:todo_it/common/error/failure.dart';

class CacheException extends Failure {
  CacheException({String? message})
      : super(message: message ?? 'مشکل داریم، دوبار امتحان کن.');
}

class NotFound extends CacheException {
  NotFound({String? message})
      : super(message: message ?? 'اطلاعات مورد نظر پپدا نشد.');
}

class NullValue extends CacheException {
  NullValue({String? message})
      : super(message: message ?? 'دیتا نباید نال باشه.');
}

class HiveException extends CacheException {
  HiveException({String? message}) : super(message: message);
}

class TypeMissmatch extends CacheException {
  TypeMissmatch({String? message})
      : super(message: message ?? 'نوع داده ها یکی نیست.');
}

class FetchData extends CacheException {
  FetchData({String? message}) : super(message: message);
}

class WrongPassword extends CacheException {
  WrongPassword({String? message})
      : super(message: message ?? 'رمز عبور رو اشتباه زدی. دوباره امتحان کن.');
}
