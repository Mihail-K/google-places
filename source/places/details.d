
module places.details;

import places.address_component;
import places.alt_id;
import places.geometry;
import places.json_data;
import places.opening_hours;
import places.photo;
import places.review;
import places.util;

import vibe.http.client;

struct DetailsResult
{
    mixin JsonData;

    mixin attribute!(AddressComponent[], "addressComponents", "address_components");
    mixin attribute!(string, "adrAddress", "adr_address");
    mixin attribute!(AltID[], "altIDs", "alt_ids");
    mixin attribute!(string, "formattedAddress", "formatted_address");
    mixin attribute!(string, "formattedPhoneNumber", "formatted_phone_number");
    mixin attribute!(Geometry, "geometry");
    mixin attribute!(string, "icon");
    mixin attribute!(string, "id");
    mixin attribute!(string, "internationalPhoneNumber", "international_phone_number");
    mixin attribute!(string, "name");
    mixin attribute!(OpeningHours, "openingHours", "opening_hours");
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

struct Details
{
    enum detailUrl = "https://maps.googleapis.com/maps/api/place/details/json";

    mixin JsonData;

    static const(Details) get(string[string] parameters)
    {
        return Details(requestHTTP(buildUrl(detailUrl, parameters)).readJson);
    }

    mixin attribute!(string, "errorMessage", "error_message");
    mixin attribute!(string[], "htmlAttributes", "html_attributes");
    mixin attribute!(DetailsResult, "result");
    mixin attribute!(string, "status");
}
