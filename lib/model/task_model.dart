import 'dart:convert';

class TaskModel {
  final String id;
  final String title;
  final String category;
  final String date;
  final String time;
  final String notes;
  final bool isComplete;
  TaskModel({
    required this.id,
    required this.title,
    required this.category,
    required this.date,
    required this.time,
    required this.notes,
    required this.isComplete,
  });

  TaskModel copyWith({
    String? id,
    String? title,
    String? category,
    String? date,
    String? time,
    String? notes,
    bool? isComplete,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      date: date ?? this.date,
      time: time ?? this.time,
      notes: notes ?? this.notes,
      isComplete: isComplete ?? this.isComplete,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'category': category,
      'date': date,
      'time': time,
      'notes': notes,
      'isComplete': isComplete,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as String,
      title: map['title'] as String,
      category: map['category'] as String,
      date: map['date'] as String,
      time: map['time'] as String,
      notes: map['notes'] as String,
      isComplete: map['isComplete'] as bool,
    );
  }

  @override
  String toString() {
    return 'TaskModel(id: $id, title: $title, category: $category, date: $date, time: $time, notes: $notes, isComplete: $isComplete)';
  }

  @override
  bool operator ==(covariant TaskModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.category == category &&
        other.date == date &&
        other.time == time &&
        other.notes == notes &&
        other.isComplete == isComplete;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        category.hashCode ^
        date.hashCode ^
        time.hashCode ^
        notes.hashCode ^
        isComplete.hashCode;
  }
}
