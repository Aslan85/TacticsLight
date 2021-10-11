enum Team
{
    Team1;
    Team2;
}

enum Control
{
    Nothing;
    Up;
    Down;
    Right;
    Left;
    Check;
    Cancel;
}

enum Direction
{
    Up;
    Down;
    Right;
    Left;
}

class Const
{
    // grid
    public static inline var boardWith:Int = 8;
    public static inline var boardHeight:Int = 5;
    public static inline var tileSize:Int = 64;
    public static inline var tileMargin:Int = 2;
    public static inline var cellSize:Float = tileSize + tileMargin;
}