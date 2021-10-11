package dig.utils;

class Grid<TGridObject>
{
    private var width:Int;
    private var height:Int;
    private var cellSize:Float;
    private var originPosition:Vector2;
    private var gridArray:Array<Array<TGridObject>>;

    public function new(width:Int = 0, height:Int = 0, cellSize:Float, originPosition:Vector2, gridObject:Dynamic)
    {
        this.width = width;
        this.height = height;
        this.cellSize = cellSize;
        this.originPosition = originPosition;

        this.gridArray = Array2D.create(width, height);

        for(x in 0...width)
        {
            for(y in 0...height)
            {
                gridArray[x][y] = gridObject(this, x, y);
            }
        }
    }

    public function GetWidth():Int
    {
        return width;
    }

    public function GetHeight():Int
    {
        return height;
    }

    public function GetCellSize():Float
    {
        return cellSize;
    }

    public function GetWorldPosition(x:Int, y:Int):Vector2
    {
        return new Vector2(x * cellSize + originPosition.x, y * cellSize + originPosition.y);
    }

    public function GetXY(worldPosition:Vector2):Vector2
    {
        return new Vector2( Math.floor((worldPosition.x - originPosition.x) / cellSize),
                            Math.floor((worldPosition.y - originPosition.y) / cellSize));
    }

    public function SetGridObject(x:Int, y:Int, value:TGridObject):Void
    {
        if(IsOnGrid(x, y))
        {
            gridArray[x][y] = value;
        }
    }

    public function SetGridObjectFromWorldPosition(worldPosition:Vector2, value:TGridObject):Void
    {
        var getXY:Vector2 = GetXY(worldPosition);
        SetGridObject(Math.floor(getXY.x), Math.floor(getXY.y), value);
    }

    public function GetGridObject(x:Int, y:Int):TGridObject
    {
        if(IsOnGrid(x, y))
        {
            return gridArray[x][y];
        }
        return null;
    }

    public function GetGridObjectFromWorldPosition(worldPosition:Vector2):TGridObject
    {
        var xyPos:Vector2 = GetXY(worldPosition);
        return GetGridObject(Math.floor(xyPos.x), Math.floor(xyPos.y));
    }

    public function GetGridPositionFromWorldPosition(worldPosition:Vector2):Vector2
    {
        var xyPos:Vector2 = GetXY(worldPosition);
        var x = Math.floor(xyPos.x);
        var y = Math.floor(xyPos.y);
        if(IsOnGrid(x, y))
        {
            return new Vector2(x, y);
        }
        return null;
    }

    public function GetListAllCells():List<TGridObject>
    {
        var allCells:List<TGridObject> = new List<TGridObject>();
        for(x in 0...width)
        {
            for(y in 0...height)
            {
                allCells.add(gridArray[x][y]);
            }
        }
        return allCells;
    }

    public function GetNeighbourList(gridPosition:Vector2):List<TGridObject>
    {
        var neighbourList:List<TGridObject> = new List<TGridObject>();
        var gridPositionX = Math.floor(gridPosition.x);
        var gridPositionY = Math.floor(gridPosition.y);

        // Left
        if(GetGridObject(gridPositionX - 1, gridPositionY) != null)
        {
            neighbourList.add(GetGridObject(gridPositionX - 1, gridPositionY));
        }
        // Right
        if(GetGridObject(gridPositionX + 1, gridPositionY) != null)
        {
            neighbourList.add(GetGridObject(gridPositionX + 1, gridPositionY));
        }
        // Down
        if(GetGridObject(gridPositionX, gridPositionY - 1) != null)
        {
            neighbourList.add(GetGridObject(gridPositionX, gridPositionY - 1));
        }
        // Up
        if(GetGridObject(gridPositionX, gridPositionY + 1) != null)
        {
            neighbourList.add(GetGridObject(gridPositionX, gridPositionY + 1));
        }

        return neighbourList;
    }

    public function IsOnGrid(x:Int, y:Int):Bool
    {
        if(x >= 0 && y >= 0 && x < width && y < height)
            return true;
        return false;
    }
}