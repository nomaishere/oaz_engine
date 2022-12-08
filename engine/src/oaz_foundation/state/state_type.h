
struct OT2DCoordinates_64 {
    double x;
    double y;
};

//
struct OT3DCoordinates_64 {
    double x;
    double y;
    double z;
};

struct OT3DDirection_64 {
    double x;
    double y;
    double z;
};

struct OT3DPos {
    OT3DCoordinates_64 ot3DCoordinates64;
    OT3DDirection_64 ot3DDirection64;
};