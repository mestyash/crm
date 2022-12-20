class SupabaseUtils {
  static Map<String, dynamic> responseWrapper(String name, dynamic data) {
    return {
      'payload': {
        name: data,
      },
    };
  }
}
