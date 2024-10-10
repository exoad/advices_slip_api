const String _kApiEndpoint = "https://api.adviceslip.com";

/// API endpoint for random advice (URI: /advice)
String getApiRandomEndpoint() => _kApiEndpoint + "/advice";

/// API endpoint for slip objects with a specific keyword in the advice (URI: /advice/search/{query})
String getApiSearchEndpoint(String query) =>
    "$_kApiSearchEndpoint$query";

/// API endpoint for a slip object with a specific ID (URI: /advice/{id})
String getApiSearchIDEndpoint(int id) => "$_kApiSearchIDEndpoint$id";

const String _kApiSearchEndpoint =
    "https://api.adviceslip.com/advice/search/";
const String _kApiSearchIDEndpoint =
    "https://api.adviceslip.com/advice/";

const String kDefaultNothingFoundErrorMessage =
    "No advice slips found matching that search term.";
