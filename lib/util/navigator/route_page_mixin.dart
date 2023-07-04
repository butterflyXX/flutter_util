
mixin RoutePageMixin {
  static const String paramsKey = "params";
  static const String statParamsKey = "statParams";
  late final Map<String,dynamic>? params;
  Map<String, dynamic>? get argument => params?[paramsKey];
  Map<String, dynamic>? get statArgument => params?[statParamsKey];
}