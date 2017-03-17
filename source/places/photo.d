
module places.photo;

import places.json_data;

import std.algorithm;
import std.array;

import vibe.data.json;

struct Photo
{
    mixin JsonData;

    mixin attribute!(uint, "height");
    mixin attribute!(string[], "htmlAttributes", "html_attributes");
    mixin attribute!(string, "photoReference", "photo_reference");
    mixin attribute!(uint, "width");
}
