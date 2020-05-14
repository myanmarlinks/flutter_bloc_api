import 'package:meta/meta.dart';

@immutable
abstract class TaskEvent {}

class TaskGetEvent extends TaskEvent {}