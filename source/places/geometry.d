
module places.geometry;

import places.coordinate;
import places.json_data;
import places.viewport;

struct Geometry
{
    mixin JsonData;

    mixin attribute!(Coordinate, "location");
    mixin attribute!(Viewport, "viewport");
}
