class Api {
  String getHost() {
    List<String> options = [
      'http://127.0.0.1:8000',
      'http://192.168.0.5:8000',
    ];

    return options[0];
  }
}
