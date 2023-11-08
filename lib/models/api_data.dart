typedef ApiData<T> = T Function(dynamic data);
typedef ApiDataList<T> = T Function(dynamic data, ApiData<T> fromDynamic);
