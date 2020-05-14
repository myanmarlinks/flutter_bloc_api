import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_two/bloc/task/bloc.dart';
import 'package:test_two/network/model/task_model.dart';

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BLoC TWO"),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  if(state is InitialTaskState) {
                    return Center(
                      child: Text("NO DATA YET!")
                    );
                  }
                  if(state is LoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if(state is LoadedState) {
                    return _listTasks(state.taskModels);
                  }
                  if(state is FailedState) {
                    return Center(
                      child: Text("${state.error}"),
                    );
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            FlatButton(
              padding: EdgeInsets.only(top: 15.0, right:40.0, bottom: 15.0, left: 40.0),
              color: Colors.green,
              onPressed: () {
                BlocProvider.of<TaskBloc>(context)..add(TaskGetEvent());
              },
              child: Text(
                  "LOAD DATA!",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      )

    );
  }

  ListView _listTasks(List<TaskModel> tasks) {
    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) {
          final image = tasks[index].thumbnailUrl;
          return Card(
            child: ListTile(
              leading: image == null ? Image.network("https://megamyanmarlink.com/apple-icon-60x60.png"): Image.network(image),
              title: Text("${tasks[index].title}"),
              subtitle: Text("${tasks[index].id.toString()}"),
            ),
          );
        }
    );
  }
}
