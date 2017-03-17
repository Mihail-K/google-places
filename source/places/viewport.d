
module places.viewport;

import places.coordinate;
import places.json_data;

struct Viewport
{
    mixin JsonData;

    mixin attribute!(Coordinate, "northeast");
    mixin attribute!(Coordinate, "southwest");
}
