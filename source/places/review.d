
module places.review;

import places.aspect_rating;
import places.json_data;

import std.algorithm;
import std.array;
import std.datetime;

import vibe.data.json;

struct Review
{
    mixin JsonData;

    mixin attribute!(AspectRating[], "aspects");
    mixin attribute!(string, "authorName", "author_name");
    mixin attribute!(string, "authorURL", "author_url");
    mixin attribute!(string, "language");
    mixin attribute!(double, "rating");
    mixin attribute!(string, "text");
    mixin attribute!(ulong, "time");
}
