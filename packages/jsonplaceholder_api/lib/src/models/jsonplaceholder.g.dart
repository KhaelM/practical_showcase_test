// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jsonplaceholder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Jsonplaceholder _$JsonplaceholderFromJson(Map<String, dynamic> json) =>
    Jsonplaceholder(
      id: json['id'] as int,
      title: json['title'] as String,
      albumId: json['albumId'] as int,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );

Map<String, dynamic> _$JsonplaceholderToJson(Jsonplaceholder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'albumId': instance.albumId,
      'url': instance.url,
      'thumbnailUrl': instance.thumbnailUrl,
    };
