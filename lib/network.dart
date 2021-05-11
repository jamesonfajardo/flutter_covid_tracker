import 'package:http/http.dart' as http;

class Network {
  Network({this.url});
  final String url;

  Future<dynamic> processUrl() async {
    http.Response response = await http.get(url);
    return response;
  }
}
