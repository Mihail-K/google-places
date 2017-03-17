
module places.util;

import url;

string buildUrl(string base, string[string] parameters)
{
    auto url = parseURL(base);

    foreach(name, value; parameters)
    {
        url.queryParams.add(name, value);
    }

    return url.toString;
}
