
module places.detail;

import places.address_component;
import places.geometry;
import places.json_data;
import places.opening_hour;
import places.photo;
import places.review;
import places.util;

import std.algorithm;
import std.array;

import vibe.data.json;
import vibe.http.client;

struct Detail
{
    mixin JsonData;

    enum baseUrl = "https://maps.googleapis.com/maps/api/place/details/json";

    static Detail get(string apiKey, string placeID)
    {
        return Detail(requestHTTP(buildUrl(baseUrl, [
            "place_id": placeID,
            "key":      apiKey
        ])).readJson["result"]);
    }

    mixin attribute!(AddressComponent[], "addressComponents", "address_components");
    mixin attribute!(string, "adrAddress", "adr_address");
    mixin attribute!(string, "formattedAddress", "formatted_address");
    mixin attribute!(string, "formattedPhoneNumber", "formatted_phone_number");
    mixin attribute!(Geometry, "geometry");
    mixin attribute!(string, "icon");
    mixin attribute!(string, "id");
    mixin attribute!(string, "internationalPhoneNumber", "international_phone_number");
    mixin attribute!(string, "name");
    mixin attribute!(OpeningHour[], "openingHours", "opening_hours");
    mixin attribute!(bool, "permanentlyClosed", "permanently_closed");
    mixin attribute!(Photo[], "photos");
    mixin attribute!(string, "placeID", "place_id");
    mixin attribute!(uint, "priceLevel", "price_level");
    mixin attribute!(double, "rating");
    mixin attribute!(string, "reference");
    mixin attribute!(Review[], "reviews");
    mixin attribute!(string, "scope_", "scope");
    mixin attribute!(string[], "types");
    mixin attribute!(string, "url");
    mixin attribute!(string, "utcOffset", "utc_offset");
    mixin attribute!(string, "vicinity");
    mixin attribute!(string, "website");
}
