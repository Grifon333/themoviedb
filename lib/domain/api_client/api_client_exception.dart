enum ApiClientExceptionType {
  network,
  auth,
  other,
  sessionExpired,
}

class ApiClientException implements Exception {
  final ApiClientExceptionType type;

  ApiClientException(this.type);
}

/*
Status code:
7 - Invalid API key: You must be granted a valid key
30 - Invalid username and/or password: You did not provide a valid login.
33 - Invalid request token: The request token is either expired or invalid
34 - The resource you requested could not be found
*/
