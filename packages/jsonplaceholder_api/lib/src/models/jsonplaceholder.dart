import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:jsonplaceholder_api/jsonplaceholder_api.dart';
import 'package:meta/meta.dart';

part 'jsonplaceholder.g.dart';

/// {@template jsonplaceholder_item}
/// A single `jsonplaceholder` item.
///
/// Contains a [albumId], [id], [title], [url] and [thumbnailUrl]
///
/// [Jsonplaceholder]s are immutable and can be copied using [copyWith],
/// in addition to being serialized and deserialized using [toJson]
/// and [fromJson] respectively.
/// {@endtemplate}
@immutable
@JsonSerializable()
class Jsonplaceholder extends Equatable {
  /// {@macro jsonplaceholder_item}
  const Jsonplaceholder({
    required this.id,
    required this.title,
    required this.albumId,
    required this.url,
    required this.thumbnailUrl,
  });

  /// The unique identifier of the `jsonplaceholder`.
  ///
  /// Cannot be empty.
  final int id;

  /// The title of the `jsonplaceholder`.
  ///
  /// Cannot be empty.
  final String title;

  /// The identifier in which the `jsonplaceholder`'s picture belongs to.
  ///
  /// Cannot be empty.
  final int albumId;

  /// The picture's url of the `jsonplaceholder`.
  ///
  /// Cannot be empty.
  final String url;

  /// The thumbnail picture's url of the `jsonplaceholder`.
  ///
  /// Cannot be empty.
  final String thumbnailUrl;

  /// Returns a copy of this `jsonplaceholder` with the given values updated.
  ///
  /// {@macro todo_item}
  Jsonplaceholder copyWith({
    int? id,
    String? title,
    int? albumId,
    String? url,
    String? thumbnailUrl,
  }) {
    return Jsonplaceholder(
      id: id ?? this.id,
      title: title ?? this.title,
      albumId: albumId ?? this.albumId,
      url: url ?? this.url,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      title,
      albumId,
      url,
      thumbnailUrl,
    ];
  }

  /// Deserializes the given [JsonMap] into a [Jsonplaceholder].
  static Jsonplaceholder fromJson(JsonMap json) =>
      _$JsonplaceholderFromJson(json);

  /// Converts this [Jsonplaceholder] into a [JsonMap].
  JsonMap toJson() => _$JsonplaceholderToJson(this);
}
