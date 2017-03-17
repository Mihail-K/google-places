
module places.address_component;

import places.json_data;

import std.algorithm;
import std.array;

import vibe.data.json;

struct AddressComponent
{
    mixin JsonData;

    mixin attribute!(string, "longName", "long_name");
    mixin attribute!(string, "shortName", "short_name");
    mixin attribute!(string[], "types");
}
