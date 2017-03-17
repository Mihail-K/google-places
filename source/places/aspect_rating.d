
module places.aspect_rating;

import places.json_data;

struct AspectRating
{
    mixin JsonData;

    mixin attribute!(uint, "rating");
    mixin attribute!(string, "type");
}
