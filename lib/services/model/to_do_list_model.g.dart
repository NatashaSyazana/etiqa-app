// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'to_do_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoListModel _$TodoListModelFromJson(Map<String, dynamic> json) =>
    TodoListModel(
      id: json['id'] as String?,
      title: json['title'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      timeLeft: json['timeLeft'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$TodoListModelToJson(TodoListModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'timeLeft': instance.timeLeft,
      'status': instance.status,
    };
