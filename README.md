# google-places
A D wrapper for the Google Places API.

## Usage Examples

Your API key is managed by the `PlacesClient` which automatically adds the key to out-going requests, in addition to any other parameters.

```d
// Construct a client and fetch Place details.
auto client  = PlacesClient("your-api-key");
auto details = client.details("some-place-id");

foreach(review; details.result.reviews)
{
    // Object attributes are camelCased.
    writeln("Author: ", review.authorName);
    writeln("Rating: ", review.rating);
    writeln("Text: ", review.text);
}
```

All API functions are also overloaded to take a callback, rather than return the response. API parameters are passed via associative array, and behave exactly as described by the Google Places documentation.

```d
// Prepare a list of options for the call.
auto client  = PlacesClient("your-api-key");
auto options = [
    "location": "48.859294,2.347589",
    "radius":   "5000",
    "type":     "cafe",
    "keyword":  "vegetarian"
];

// Pass the result on to a callback.
client.radarSearch(options, (search) {
    foreach(result; search.results)
    {
        // Do something . . . 
    }
});
```

## License

MIT
