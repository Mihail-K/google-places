
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
import std.meta;

import vibe.data.json;
import vibe.http.client;

struct DetailParameters
{
    alias attributes = AliasSeq!("apiKey", "placeID", "extensions", "language");

private:
    string _apiKey;
    string _placeID;
    string _extensions;
    string _language;

public:
    this(string apiKey, string placeID, string extensions = null, string language = null)
    {
        _apiKey     = apiKey;
        _placeID    = placeID;
        _extensions = extensions;
        _language   = language;
    }

    this(string[string] options)
    {
        foreach(name; attributes)
        {
            if(auto ptr = name in options)
            {
                __traits(getMember, this, "_" ~ name) = *ptr;
            }
        }
    }

    @property
    string apiKey() const
    {
        return _apiKey;
    }

    @property
    string placeID() const
    {
        return _placeID;
    }

    @property
    string extensions() const
    {
        return _extensions;
    }

    @property
    string language() const
    {
        return _language;
    }

    @property
    string[string] options() const
    {
        string[string] result = ["key": apiKey, "place_id": placeID];

        if(extensions !is null) {
            result["extensions"] = extensions;
        }
        if(language !is null) {
            result["language"] = language;
        }

        return result;
    }
}

struct Detail
{
    mixin JsonData;

    enum baseUrl = "https://maps.googleapis.com/maps/api/place/details/json";

    static const(Detail) get(string apiKey, string placeID)
    {
        return get(DetailParameters(apiKey, placeID));
    }

    static const(Detail) get(DetailParameters parameters)
    {
        return Detail(requestHTTP(buildUrl(baseUrl, parameters.options)).readJson["result"]);
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
