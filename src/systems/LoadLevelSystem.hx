package systems;
import dig.utils.Vector2;
import dig.utils.Grid;
import dig.ecs.*;

class LoadLevelSystem extends dig.ecs.System
{
    public override function new()
    {
        var BW:Int = 8;
        var BH:Int = 5;
        var CS:Float = 66;
        var OV:Vector2 = Vector2.zero();
        var grid:Grid<Entity> = new Grid(BW, BH, CS, OV, function(g:Grid<Entity>, x:Int, y:Int)
        {
            var cell = new Entity(Game.inst.getScene(), "cell_" +x +"_" +y);
            new components.PositionComponent(cell, x *CS, y*CS);
            new components.TileComponent(cell, hxd.Res.White_Square.toTile());
        });
        
        super();
    }
}