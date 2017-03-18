
module places.client;

import places.details;
import places.search;
import places.util;

import vibe.http.client;

struct Client
{
private:
    string _key;

    enum detailsUrl      = "https://maps.googleapis.com/maps/api/place/details/json";
    enum nearbySearchUrl = "https://maps.googleapis.com/maps/api/place/nearbysearch/json";
    enum radarSearchUrl  = "https://maps.googleapis.com/maps/api/place/radarsearch/json";
    enum textSearchUrl   = "https://maps.googleapis.com/maps/api/place/textsearch/json";

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

    const(Details) details(string placeID) const
    {
        return details(["place_id": placeID]);
    }

    const(Details) details(string[string] options) const
    {
        auto response = requestHTTP(buildUrl(detailsUrl, addKeyToOptions(options)));
        return Details(response.readJson);
    }

    void details(string[string] options, scope void delegate(const(Details)) callback) const
    {
        requestHTTP(
            buildUrl(detailsUrl, addKeyToOptions(options)),
            (scope request)  { /+ Nothing +/ },
            (scope response) { callback(Details(response.readJson)); }
        );
    }

    const(Search) nearbySearch(string[string] options) const
    {
        return search(nearbySearchUrl, options);
    }

    void nearbySearch(string[string] options, scope void delegate(const(Search)) callback) const
    {
        return search(nearbySearchUrl, options, callback);
    }

    const(Search) radarSearch(string[string] options) const
    {
        return search(radarSearchUrl, options);
    }

    void radarSearch(string[string] options, scope void delegate(const(Search)) callback) const
    {
        return search(radarSearchUrl, options, callback);
    }

    const(Search) textSearch(string[string] options) const
    {
        return search(textSearchUrl, options);
    }

    void textSearch(string[string] options, scope void delegate(const(Search)) callback) const
    {
        return search(textSearchUrl, options, callback);
    }

    private string[string] addKeyToOptions(string[string] options) const
    {
        if(options !is null && "key" !in options)
        {
            options["key"] = key;
        }

        return options;
    }

    private const(Search) search(string url, string[string] options) const
    {
        auto response = requestHTTP(buildUrl(url, addKeyToOptions(options)));
        return Search(response.readJson);
    }

    private void search(string url, string[string] options, scope void delegate(const(Search)) callback) const
    {
        requestHTTP(
            buildUrl(url, addKeyToOptions(options)),
            (scope request)  { /+ Nothing +/ },
            (scope response) { callback(Search(response.readJson)); }
        );
    }
}
