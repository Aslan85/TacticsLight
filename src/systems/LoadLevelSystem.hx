package systems;
import components.ScaleComponent;
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
            cell.addComponent(new components.PositionComponent(x *CS, y*CS));
            cell.addComponent(new components.TileComponent(hxd.Res.White_Square.toTile()));
            //cell.addComponent(new components.VelocityComponent(10 + Math.floor(((30 - 10 + 1) * Math.random())), 10 + Math.floor(((30 - 10 + 1) * Math.random()))));
            //cell.addComponent(new components.ScaleComponent(0.1 + Math.floor(((1.2 - 0.1 + 1) * Math.random())), 0.1 + Math.floor(((1.2 - 0.1 + 1) * Math.random()))));
        });
        
        super();
    }
}