part of 'models.dart';

class CostResult extends Equatable {
  final String? code;
  final String? name;
  final List<Cost>? costs;

  const CostResult({this.code, this.name, this.costs});

  factory CostResult.fromMap(Map<String, dynamic> data) => CostResult(
        code: data['code'] as String?,
        name: data['name'] as String?,
        costs: (data['costs'] as List<dynamic>?)
            ?.map((e) => Cost.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'code': code,
        'name': name,
        'costs': costs?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CostResult].
  factory CostResult.fromJson(String data) {
    return CostResult.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CostResult] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [code, name, costs];
}
