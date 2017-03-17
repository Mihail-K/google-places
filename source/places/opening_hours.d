
module places.opening_hours;

import places.json_data;
import places.period;

struct OpeningHours
{
    mixin JsonData;

    mixin attribute!(bool, "openNow", "open_now");
    mixin attribute!(Period[], "periods");
    mixin attribute!(string[], "weekdayText", "weekday_text");
}
