enum GameState
{
    Init;
    Play;
    Menu;
}

enum abstract TileLayers(Int) to Int
{
    var Background = 0;
    var Board = 1;
    var TileSelect = 2;
    var Cursor = 3;
    var Unit = 4;
}

enum Control
{
    Nothing;
    Up;
    Down;
    Right;
    Left;
    Validate;
    Cancel;
}

enum Direction
{
    Up;
    Down;
    Right;
    Left;
}

enum Command
{
    Validate;
    Cancel;
    Up;
    Down;
}

enum Team
{
    Team1;
    Team2;
}

enum Elements
{
    Fire;
    Earth;
    Water;
    Light;
    Darkness;
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