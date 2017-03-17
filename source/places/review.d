
module places.review;

import places.aspect_rating;
import places.json_data;

struct Review
{
    mixin JsonData;

    mixin attribute!(AspectRating[], "aspects");
    mixin attribute!(string, "authorName", "author_name");
    mixin attribute!(string, "authorURL", "author_url");
    mixin attribute!(string, "language");
    mixin attribute!(double, "rating");
    mixin attribute!(string, "text");
    mixin attribute!(ulong, "time");
}
