import 'dart:async';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:dope_flutter/models/todo.dart';

final supabase = Supabase.instance.client;

class TodoService extends ChangeNotifier {
  List<Todo> _todos = [];
  late final StreamSubscription<List<Map<String, dynamic>>> _todoSubscription;

  List<Todo> get todos => _todos;

  TodoService() {
    // 서비스가 생성될 때 데이터 로딩 및 실시간 리스너 시작
    _listenToTodos();
  }

  void _listenToTodos() {
    // 실시간으로 todos 테이블의 변화를 감지합니다.
    _todoSubscription = supabase.from('todos').stream(primaryKey: ['id']).listen(
      (maps) {
        debugPrint('★★★★★ Realtime event received! Processing ${maps.length} records. ★★★★★');
        _todos = maps.map((map) => Todo.fromJson(map)).toList();
        _todos.sort((a, b) => b.createdAt.compareTo(a.createdAt)); // 최신순으로 정렬
        notifyListeners(); // UI에 변경사항 알림
      },
      onError: (e) {
        debugPrint('Error listening to todos: $e');
      },
    );
  }

  Future<void> addTodo(String task) async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return;
    await supabase.from('todos').insert({'task': task, 'user_id': userId});
    // 실시간 리스너가 자동으로 UI를 갱신하므로 여기서 notifyListeners()를 호출할 필요가 없습니다.
  }

  Future<void> updateTodo(Todo todo, bool isCompleted) async {
    await supabase
        .from('todos')
        .update({'is_completed': isCompleted})
        .match({'id': todo.id});
  }

  Future<void> deleteTodo(Todo todo) async {
    await supabase.from('todos').delete().match({'id': todo.id});
  }

  @override
  void dispose() {
    _todoSubscription.cancel(); // 서비스가 소멸될 때 리스너를 꼭 닫아줍니다.
    super.dispose();
  }
}
