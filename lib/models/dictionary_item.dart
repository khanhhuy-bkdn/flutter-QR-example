import 'package:json_annotation/json_annotation.dart';
//part 'dictionary_item.g.dart';

@JsonSerializable()
class DictionaryItem {
  String? key;
  String? value;
  String? displayText;
  String? code;
  String? typeGroup;

  DictionaryItem(
      {this.key, this.value, this.code, this.displayText, this.typeGroup});

  factory DictionaryItem.fromJson(Map<String, dynamic> json) =>
      _$DictionaryItemFromJson(json);
  Map<String, dynamic> toJson() => _$DictionaryItemToJson(this);

  @override
  String toString() => displayText!;
}

DictionaryItem _$DictionaryItemFromJson(Map<String, dynamic> json) {
  return DictionaryItem(
    key: json['key'] as String,
    value: json['value'] as String,
    code: json['code'] as String,
    displayText: json['displayText'] as String,
    typeGroup: json['typeGroup'] as String,
  );
}

Map<String, dynamic> _$DictionaryItemToJson(DictionaryItem instance) =>
    <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
      'displayText': instance.displayText,
      'code': instance.code,
      'typeGroup': instance.typeGroup,
    };
