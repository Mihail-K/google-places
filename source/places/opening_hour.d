
module places.opening_hour;

import places.json_data;
import places.period;

import std.algorithm;
import std.array;

import vibe.data.json;

struct OpeningHour
{
    mixin JsonData;

    mixin attribute!(bool, "openNow", "open_now");
    mixin attribute!(Period[], "periods");
    mixin attribute!(string[], "weekdayText", "weekday_text");
}
