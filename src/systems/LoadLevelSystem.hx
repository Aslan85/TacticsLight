package systems;
import dig.utils.Vector2;
import dig.utils.Grid;
import dig.ecs.*;
import components.*;

class LoadLevelSystem extends dig.ecs.System
{
    public override function new()
    {
        var boardWith:Int = 8;
        var boardHeight:Int = 5;
        var tileSize:Int = 64;
        var tileMargin:Int = 2;
        var cellSize:Float = tileSize + tileMargin;
        var originVector:Vector2 = new Vector2(Game.inst.s2d.width/2 - cellSize*boardWith/2, Game.inst.s2d.height/2 -cellSize*boardHeight/2);
        var grid:Grid<Entity> = new Grid(boardWith, boardHeight, cellSize, originVector, function(g:Grid<Entity>, x:Int, y:Int)
        {
            var cell = new Entity(Game.inst.getScene(), "cell_" +x +"_" +y);
            cell.addComponent(new PositionComponent(x *cellSize +originVector.x, y*cellSize +originVector.y));
            cell.addComponent(new TileComponent(hxd.Res.White_Square.toTile()));

            var colorWhite:h3d.Vector = new h3d.Vector(1, 1, 1, 0.9);
            var colorBlack:h3d.Vector = new h3d.Vector(0.2, 0.2, 0.2, 1); 
            if((x%2 == 0 && y%2 == 0) || (x%2 != 0 && y%2 != 0))
            {
                cell.addComponent(new ColorComponent(colorWhite));
            }
            else
            {
                cell.addComponent(new ColorComponent(colorBlack));
            }
        });
        
        super();
    }

    private function randomNumber(from:Float, to:Float):Float
    {
        return from + Math.floor(((to - from + 1) * Math.random()));
    }
}