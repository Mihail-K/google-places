
module places.period;

import places.day_time;
import places.json_data;

struct Period
{
    mixin JsonData;

    mixin attribute!(DayTime, "open");
    mixin attribute!(DayTime, "closed");
}
