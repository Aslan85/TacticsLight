package systems;
import dig.ecs.*;

class PositionSystem extends dig.ecs.System
{
    var positionEntities:List<Entity> = new List<Entity>();

    public override function refreshEntities(entities:List<Entity>):Void
    {
        positionEntities = Game.allEntities.filter(function(e) return e.hasComponent("PositionComponent"));
    }

    public override function update(dt:Float):Void
    {
        for(entity in positionEntities)
        {
            var p = cast(entity.getComponent("PositionComponent"), components.PositionComponent);
            entity.obj.setPosition(p.x, p.y);
        }
    }
}