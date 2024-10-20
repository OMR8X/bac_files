class SelectEntityRequest {
  final String id;

  SelectEntityRequest({required this.id});

  Map<String, dynamic> get queryParameters {
    return {
      "id": id,
    };
  }
}
