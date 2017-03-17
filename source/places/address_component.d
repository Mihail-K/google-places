
module places.address_component;

import places.json_data;

struct AddressComponent
{
    mixin JsonData;

    mixin attribute!(string, "longName", "long_name");
    mixin attribute!(string, "shortName", "short_name");
    mixin attribute!(string[], "types");
}
