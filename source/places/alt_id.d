
module places.alt_id;

import places.json_data;

struct AltID
{
    mixin JsonData;

    mixin attribute!(string, "placeID", "place_id");
    mixin attribute!(string, "scope_", "scope");
}
