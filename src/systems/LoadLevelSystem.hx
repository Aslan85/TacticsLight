package systems;
import dig.utils.Vector2;
import dig.utils.Grid;
import dig.ecs.*;
import components.*;

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
            cell.addComponent(new PositionComponent(x *CS, y*CS));
            cell.addComponent(new TileComponent(hxd.Res.White_Square.toTile()));
            cell.addComponent(new ColorComponent(new h3d.Vector(randomNumber(0.1, 1), randomNumber(0.1, 1), randomNumber(0.1, 1), 1)));
            //cell.addComponent(new VelocityComponent(randomNumber(10, 30), randomNumber(10, 30)));
            //cell.addComponent(new ScaleComponent(randomNumber(0.2, 1), 0.1 + randomNumber(0.2, 1)));
        });
        
        super();
    }

    private function randomNumber(from:Float, to:Float):Float
    {
        return from + Math.floor(((to - from + 1) * Math.random()));
    }
}