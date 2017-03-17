
module places.photo;

import places.json_data;

struct Photo
{
    mixin JsonData;

    mixin attribute!(uint, "height");
    mixin attribute!(string[], "htmlAttributes", "html_attributes");
    mixin attribute!(string, "photoReference", "photo_reference");
    mixin attribute!(uint, "width");
}
