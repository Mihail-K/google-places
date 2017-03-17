
module places.search;

import places.alt_id;
import places.geometry;
import places.json_data;
import places.opening_hours;
import places.photo;
import places.util;

import vibe.http.client;

struct SearchResult
{
    mixin JsonData;

    mixin attribute!(AltID[], "altIDs", "alt_ids");
    mixin attribute!(string, "formattedAddress", "formatted_address");
    mixin attribute!(Geometry, "geometry");
    mixin attribute!(string, "icon");
    mixin attribute!(string, "id");
    mixin attribute!(string, "name");
    mixin attribute!(OpeningHours, "openingHours", "opening_hours");
    mixin attribute!(Photo[], "photos");
    mixin attribute!(string, "placeID", "place_id");
    mixin attribute!(string, "scope_", "scope");
    mixin attribute!(bool, "permanentlyClosed", "pemanently_closed");
    mixin attribute!(uint, "priceLevel", "price_level");
    mixin attribute!(double, "rating");
    mixin attribute!(string, "reference");
    mixin attribute!(string[], "types");
    mixin attribute!(string, "vicinity");
}

struct Search
{
    enum searchUrl = "https://maps.googleapis.com/maps/api/place/nearbysearch/json";

    mixin JsonData;

    static const(Search) get(string[string] parameters)
    {
        return Search(requestHTTP(buildUrl(searchUrl, parameters)).readJson);
    }

    mixin attribute!(string, "errorMessage", "error_message");
    mixin attribute!(string[], "htmlAttributes", "html_attributes");
    mixin attribute!(string, "nextPageToken", "next_page_token");
    mixin attribute!(SearchResult[], "results");
    mixin attribute!(string, "status");
}
