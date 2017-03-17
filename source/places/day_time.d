
module places.day_time;

import places.json_data;

struct DayTime
{
    mixin JsonData;

    mixin attribute!(uint, "day");
    mixin attribute!(string, "time");
}
