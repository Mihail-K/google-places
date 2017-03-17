
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
                const auto ptr = attr in _json;
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

                const auto ptr  = attr in _json;
                const auto json = ptr ? *ptr : Json.emptyObject;

                return T(json);
            }
        }.format(name));
    }

    mixin template attribute(T, string name, string attr = name)
        if(isArray!(T) && isAggregateType!(ForeachType!(T)))
    {
        import std.algorithm;
        import std.array;
        import std.format;

        mixin(q{
            @property
            const(T) %s() const
            {
                import std.traits;
                import vibe.data.json;

                if(const auto ptr = attr in _json)
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
        import std.algorithm;
        import std.array;
        import std.format;

        mixin(q{
            @property
            const(T) %s() const
            {
                import std.traits;
                import vibe.data.json;

                if(const auto ptr = attr in _json)
                {
                    return (*ptr).get!(Json[]).map!(json => json.to!(ForeachType!(T))).array;
                }

                return null;
            }
        }.format(name));
    }
}

version(unittest)
{
    import vibe.data.json;

    struct TestType
    {
        mixin JsonData;

        mixin attribute!(string, "name");
        mixin attribute!(string, "userName", "user_name");
        mixin attribute!(string[], "types");
        mixin attribute!(TestType, "testType", "test_type");
    }
}

unittest
{
    auto t = TestType(Json([
        "name":      Json("test-01"),
        "user_name": Json("test-02"),
        "types":     Json([
            Json("test-03"),
            Json("test-04"),
            Json("test-05")
        ]),
        "test_type": Json([
            "name":      Json("test-06"),
            "user_name": Json("test-07")
        ])
    ]));

    assert(t.name == "test-01");
    assert(t.userName == "test-02");
    assert(t.types == [
        "test-03", "test-04", "test-05"
    ]);
    assert(t.testType.name == "test-06");
    assert(t.testType.userName == "test-07");
    assert(t.testType.types == null);
}
