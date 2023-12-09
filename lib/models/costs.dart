part of 'models.dart';

class Cost extends Equatable {
  final String? service;
  final String? description;
  final List<CostInfo>? cost;

  const Cost({this.service, this.description, this.cost});

  factory Cost.fromMap(Map<String, dynamic> data) => Cost(
        service: data['service'] as String?,
        description: data['description'] as String?,
        cost: (data['cost'] as List<dynamic>?)
            ?.map((e) => CostInfo.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'service': service,
        'description': description,
        'cost': cost?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Cost].
  factory Cost.fromJson(String data) {
    return Cost.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Cost] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [service, description, cost];
}
