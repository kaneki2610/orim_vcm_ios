// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) {
  return Notification(
      action: json['action'] as String ?? '',
      title: json['title'] as String ?? '',
      content: json['content'] as String ?? '',
      time: json['time'] as String ?? '',
      url: json['url'] as String ?? '',
      idIssue: json['idIssue'] as String ?? '');
}

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'action': instance.action,
      'title': instance.title,
      'content': instance.content,
      'time': instance.time ?? '',
      'url': instance.url ?? '',
      'idIssue': instance.idIssue ?? '',
    };
