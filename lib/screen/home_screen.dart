import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/provider/todo_provider.dart';
import 'package:to_do_app/model/todo.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Todo Application",
          style: TextStyle(color: Colors.black87),
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu, color: Colors.amberAccent),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          }
        ),
      ),
      body: Column(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            //  SizedBox(height: 10),

              Image(image: const AssetImage("assets/images/todoicon.png"), height: 100.0),

            ],
          ),
          SizedBox(height: 30),

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  topLeft: Radius.circular(60),
                ),
                color: Colors.amberAccent,
              ),
              child: Consumer<TodosProvider>(
                builder: (context, task, child) {
                  return ListView.builder(
                    itemCount: task.todos.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.only(
                          left: 32,
                          right: 32,
                          top: 8,
                          bottom: 8,
                        ),
                        title: Text(
                          task.todos[index].title,
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          task.todos[index].detail,
                          style: TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                _showEditTaskDialog(context, task, index);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                task.deleteTaskInList(index);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showAddTaskDialog(context);
        },
      ),
      drawer: _buildSideDrawer(context),
    );
  }

  Future<void> _showAddTaskDialog(BuildContext context) async {
    TextEditingController titleController = TextEditingController();
    TextEditingController detailController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add New Task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "Title",
                ),
              ),
              TextField(
                controller: detailController,
                decoration: InputDecoration(
                  labelText: "Detail",
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Provider.of<TodosProvider>(context, listen: false).addTaskInList(
                  titleController.text,
                  detailController.text,
                );
                Navigator.of(context).pop();
              },
              child: Text("Add"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEditTaskDialog(BuildContext context, TodosProvider task, int index) async {
    TextEditingController titleController = TextEditingController(text: task.todos[index].title);
    TextEditingController detailController = TextEditingController(text: task.todos[index].detail);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "Title",
                ),
              ),
              TextField(
                controller: detailController,
                decoration: InputDecoration(
                  labelText: "Detail",
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                task.editTaskInList(
                  index,
                  titleController.text,
                  detailController.text,
                );
                Navigator.of(context).pop();
              },
              child: Text("Save"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}
Drawer _buildSideDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.amberAccent,
          ),
          child: Text(
            'Menu',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.assignment),
          title: Text('All tasks'),
          onTap: () {

          },
        ),
        ListTile(
          leading: Icon(Icons.list),
          title: Text('Task List'),
          onTap: () {

          },
        ),
        ListTile(
          leading: Icon(Icons.check_circle),
          title: Text('Finished tasks'),
          onTap: () {

          },
        ),

      ],
    ),
  );
}
