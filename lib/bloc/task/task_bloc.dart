import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:test_two/network/api_service.dart';
import './bloc.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {

  final ApiService apiService;
  TaskBloc(this.apiService);

  @override
  TaskState get initialState => InitialTaskState();

  @override
  Stream<TaskState> mapEventToState(
    TaskEvent event,
  ) async* {
    if(event is TaskGetEvent) {
      yield LoadingState();
      try {
        final response = await apiService.getTasks();
        yield LoadedState(response);
      } on SocketException catch (e) {
        yield FailedState(e.toString());
      } on Exception catch (e) {
        yield FailedState(e.toString());
      }

    }
  }
}
