
module places.client;

import places.details;
import places.search;
import places.util;

import vibe.http.client;

struct Client
{
private:
    string _key;

    enum detailsUrl = "https://maps.googleapis.com/maps/api/place/details/json";
    enum searchUrl  = "https://maps.googleapis.com/maps/api/place/nearbysearch/json";

public:
    this(string key)
    {
        _key = key;
    }

    @property
    string key() const
    {
        return _key;
    }

    const(Details) details(string placeID)
    {
        return details(["place_id": placeID]);
    }

    const(Details) details(string[string] options)
    {
        auto response = requestHTTP(buildUrl(detailsUrl, addKeyToOptions(options)));
        return Details(response.readJson);
    }

    void details(string[string] options, scope void delegate(const(Details)) callback)
    {
        requestHTTP(
            buildUrl(detailsUrl, addKeyToOptions(options)),
            (scope request)  { /+ Nothing +/ },
            (scope response) { callback(Details(response.readJson)); }
        );
    }

    const(Search) search(string[string] options)
    {
        auto response = requestHTTP(buildUrl(searchUrl, addKeyToOptions(options)));
        return Search(response.readJson);
    }

    void search(string[string] options, scope void delegate(const(Search)) callback)
    {
        requestHTTP(
            buildUrl(searchUrl, addKeyToOptions(options)),
            (scope request)  { /+ Nothing +/ },
            (scope response) { callback(Search(response.readJson)); }
        );
    }

    private string[string] addKeyToOptions(string[string] options)
    {
        if(options !is null && "key" !in options)
        {
            options["key"] = key;
        }

        return options;
    }
}
