package systems;
import dig.ecs.*;

class LoadLevelSystem extends dig.ecs.System
{
    public override function new()
    {
        var firstEntity = new Entity(Game.inst.getScene(), "first");
        new components.PositionComponent(firstEntity, 100, 100);
        new components.ScaleComponent(firstEntity, 0.3, 0.6);
        new components.VelocityComponent(firstEntity, 60, 0);
        new components.TileComponent(firstEntity, hxd.Res.White_Square.toTile());

        super();
    }
}