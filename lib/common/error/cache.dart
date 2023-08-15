import 'package:todo_test/common/error/failure.dart';

class CacheException extends Failure {
  CacheException({String? message})
      : super(message: message ?? 'مشکل داریم، دوبار امتحان کن.');
}

class NotFound extends CacheException {
  NotFound({String? message})
      : super(message: message ?? 'اطلاعات مورد نظر پپدا نشد.');
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
