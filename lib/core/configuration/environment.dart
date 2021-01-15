abstract class Environment {
  final String apiEndpoint;

  Environment(this.apiEndpoint);
}

class Dev extends Environment {
  Dev({
    String apiEndpoint = 'young-happy-api-go-dev.paiduayapp.com',
  }) : super(apiEndpoint);
}
