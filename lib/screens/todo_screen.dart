import 'package:dope_flutter/services/todo_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dope_flutter/models/todo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  void _showAddTaskSheet(BuildContext context) {
    final taskController = TextEditingController();
    final todoService = Provider.of<TodoService>(context, listen: false);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 20,
            left: 20,
            right: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: taskController,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'New Task',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final task = taskController.text.trim();
                    if (task.isNotEmpty) {
                      Navigator.pop(context);
                      await todoService.addTodo(task);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Add Task'),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Todos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => supabase.auth.signOut(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskSheet(context),
        child: const Icon(Icons.add),
      ),
      body: Consumer<TodoService>(
        builder: (context, todoService, child) {
          if (todoService.todos.isEmpty) {
            return const Center(child: Text('No tasks yet! Tap + to add one.'));
          }

          return ListView.builder(
            itemCount: todoService.todos.length,
            itemBuilder: (context, index) {
              final todo = todoService.todos[index];
              return Dismissible(
                key: Key(todo.id.toString()),
                onDismissed: (direction) => todoService.deleteTodo(todo),
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20.0),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                child: ListTile(
                  leading: Checkbox(
                    value: todo.isCompleted,
                    onChanged: (bool? value) {
                      if (value != null) {
                        todoService.updateTodo(todo, value);
                      }
                    },
                  ),
                  title: Text(
                    todo.task,
                    style: TextStyle(
                      decoration:
                          todo.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
