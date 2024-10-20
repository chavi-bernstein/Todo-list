import 'package:dartz/dartz.dart' hide Task;
import 'package:todo_list/core/errors/failure.dart';

/// An abstract class that represents a use case.
///
/// This class defines a contract for use cases, which encapsulate business logic
/// and interact with repositories. It returns a result wrapped in an Either type,
/// allowing for error handling using the [Failure] class.
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call({required Params params});
}

/// A class representing a parameterless use case.
class NoParams {}
