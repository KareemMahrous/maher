class PaginatedList<T> {
  List<T> items;
  int pageNumber;
  int totalPages;
  int totalCount;
  bool hasPreviousPage;
  bool hasNextPage;
  String? message;
  int? statusCode;
  dynamic error;

  PaginatedList({
    required this.items,
    required this.pageNumber,
    required this.totalPages,
    required this.totalCount,
    required this.hasPreviousPage,
    required this.hasNextPage,
    this.message,
    this.statusCode,
    this.error,
  });

  factory PaginatedList.fromJson(Map<String, dynamic> json,
      T Function(Object? json) fromJsonT, {
        String? message,
        int? statusCode,
        dynamic error,
      }) {
    return PaginatedList<T>(
      items:
          json["items"] == null
              ? []
              : List<T>.from(json["items"].map((x) => fromJsonT(x))),
      pageNumber: json["pageNumber"],
      totalPages: json["totalPages"],
      totalCount: json["totalCount"],
      hasPreviousPage: json["hasPreviousPage"],
      hasNextPage: json["hasNextPage"],
      message: message,
      statusCode: statusCode,
      error: error,
    );
  }

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) {
    return {
      "items": items.map((x) => toJsonT(x)).toList(),
      "pageNumber": pageNumber,
      "totalPages": totalPages,
      "totalCount": totalCount,
      "hasPreviousPage": hasPreviousPage,
      "hasNextPage": hasNextPage,
    };
  }

  PaginatedList<T> copyWith({
    List<T>? items,
    int? pageNumber,
    int? totalPages,
    int? totalCount,
    bool? hasPreviousPage,
    bool? hasNextPage,
  }) {
    return PaginatedList<T>(
      items: items ?? this.items,
      pageNumber: pageNumber ?? this.pageNumber,
      totalPages: totalPages ?? this.totalPages,
      totalCount: totalCount ?? this.totalCount,
      hasPreviousPage: hasPreviousPage ?? this.hasPreviousPage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }


  static PaginatedList<T> empty<T>() {
    return PaginatedList<T>(
      items: [],
      pageNumber: 1,
      totalPages: 1,
      totalCount: 1,
      hasPreviousPage: false,
      hasNextPage: false,
    );
  }

}
