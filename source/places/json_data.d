
module places.json_data;

mixin template JsonData()
{
    import std.algorithm;
    import std.array;
    import std.traits;

    import vibe.data.json;

private:
    Json _json;

public:
    @disable this();

    this(Json json)
    {
        _json = json;
    }

    @property
    const(Json) json() const
    {
        return _json;
    }

private:
    mixin template attribute(T, string name, string attr = name)
        if(!isAggregateType!(T) && (!isArray!(T) || isSomeString!(T)))
    {
        import std.format;

        mixin(q{
            @property
            const(T) %s() const
            {
                auto ptr = attr in _json;
                return ptr ? (*ptr).to!T : T.init;
            }
        }.format(name));
    }

    mixin template attribute(T, string name, string attr = name)
        if(isAggregateType!(T))
    {
        import std.format;

        mixin(q{
            @property
            const(T) %s() const
            {
                import vibe.data.json;

                auto ptr  = attr in _json;
                auto json = ptr ? *ptr : Json.emptyObject;

                return T(json);
            }
        }.format(name));
    }

    mixin template attribute(T, string name, string attr = name)
        if(isArray!(T) && isAggregateType!(ForeachType!(T)))
    {
        import std.format;

        mixin(q{
            @property
            const(T) %s() const
            {
                import std.traits;
                import vibe.data.json;

                if(auto ptr = attr in _json)
                {
                    return (*ptr).get!(Json[]).map!(ForeachType!(T)).array;
                }

                return null;
            }
        }.format(name));
    }

    mixin template attribute(T, string name, string attr = name)
        if((isArray!(T) && !isSomeString!(T)) && !isAggregateType!(ForeachType!(T)))
    {
        import std.format;

        mixin(q{
            @property
            const(T) %s() const
            {
                import std.traits;
                import vibe.data.json;

                if(auto ptr = attr in _json)
                {
                    return (*ptr).get!(Json[]).map!(json => json.to!(ForeachType!(T))).array;
                }

                return null;
            }
        }.format(name));
    }
}
