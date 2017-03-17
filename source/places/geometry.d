
module places.geometry;

import places.coordinate;
import places.json_data;
import places.viewport;

import vibe.data.json;

struct Geometry
{
    mixin JsonData;

    mixin attribute!(Coordinate, "location");
    mixin attribute!(Viewport, "viewport");
}
