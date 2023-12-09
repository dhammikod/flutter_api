import 'dart:convert';

class CostInfo {
	int? value;
	String? etd;
	String? note;

	CostInfo({this.value, this.etd, this.note});

	factory CostInfo.fromMap(Map<String, dynamic> data) => CostInfo(
				value: data['value'] as int?,
				etd: data['etd'] as String?,
				note: data['note'] as String?,
			);

	Map<String, dynamic> toMap() => {
				'value': value,
				'etd': etd,
				'note': note,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CostInfo].
	factory CostInfo.fromJson(String data) {
		return CostInfo.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [CostInfo] to a JSON string.
	String toJson() => json.encode(toMap());
}
