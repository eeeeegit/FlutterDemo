import 'package:flutter/material.dart';

void main() => runApp(new TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(title: 'Todo List', home: new TodoList());
  }
}

// view
class TodoList extends StatefulWidget {
  @override
  createState() => new TodoListState();
}

// data
class TodoListState extends State<TodoList> {
  List<String> _todoItems = [];

  void _addTodoItem(String task) {
    if (task.length > 0) {
      setState(() => _todoItems.add(task));
    }
  }

  void _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  Widget _buildTodoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        if (index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index], index);
        }
      },
    );
  }

  Widget _buildTodoItem(String todoText, index) {
    return new ListTile(
        title: new Text(todoText), onTap: () => _promptRemoveTodoiTem(index));
  }

  void _pushAddTodoScene() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new Scaffold(
        appBar: new AppBar(title: new Text('Add a new task')),
        body: new TextField(
          autofocus: true,
          onSubmitted: (val) {
            _addTodoItem(val);
            Navigator.pop(context);
          },
          decoration: new InputDecoration(
              hintText: 'Enter someing to do...',
              contentPadding: const EdgeInsets.all(16.0)),
        ),
      );
    }));
  }

  void _promptRemoveTodoiTem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('Mark "${_todoItems[index]}" as done?'),
            actions: <Widget>[
              new FlatButton(
                  child: new Text('CANCEL'),
                  onPressed: () => Navigator.of(context).pop()),
              new FlatButton(
                  child: new Text('MARK AS DONE'),
                  onPressed: () {
                    _removeTodoItem(index);
                    Navigator.of(context).pop();
                  })
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Todo List',
        home: new Scaffold(
          appBar: new AppBar(title: new Text('Todo List')),
          body: _buildTodoList(),
          floatingActionButton: new FloatingActionButton(
            onPressed: _pushAddTodoScene,
            tooltip: 'Add task',
            child: new Icon(Icons.add),
          ),
        ));
  }
}
