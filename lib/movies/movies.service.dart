import 'package:http/http.dart' as http;

class MovieService {
  static getMoviesPage(currentPage) async {
    var url = Uri.parse('http://api.themoviedb.org/3/search/movie?api_key=6753d9119b9627493ae129f3c3c99151&query=superman&page=${currentPage}');

    var response = await http.get(url);
    return response;
  }
}