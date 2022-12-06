
import 'package:json_annotation/json_annotation.dart';

part 'to_do_list_model.g.dart';

@JsonSerializable()
class TodoListModel {
  //id
  String? id;
  String? title;
  String? startDate;
  String? endDate;
  String? timeLeft;
  String? status;

  TodoListModel(
      {this.id,
      this.title,
      this.startDate,
      this.endDate,
      this.timeLeft,
      this.status});

  factory TodoListModel.fromJson(Map<String, dynamic> json) =>
      _$TodoListModelFromJson(json);

  Map<String, dynamic> toJson() => _$TodoListModelToJson(this);
}