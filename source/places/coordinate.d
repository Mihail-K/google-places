
module places.coordinate;

import places.json_data;

struct Coordinate
{
    mixin JsonData;

    mixin attribute!(double, "lat");
    mixin attribute!(double, "lng");
}
