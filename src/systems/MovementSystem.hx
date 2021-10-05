package systems;
import dig.ecs.*;

class MovementSystem extends dig.ecs.System
{
    var movingEntities:List<Entity> = new List<Entity>();

    public override function refreshEntities(entities:List<Entity>):Void
    {
        movingEntities = Game.allEntities.filter(function(e) return e.hasComponent("PositionComponent") && e.hasComponent("VelocityComponent"));
    }

    public override function update(dt:Float):Void
    {
        for(entity in movingEntities)
        {
            var p = cast(entity.getComponent("PositionComponent"), components.PositionComponent);
            var v = cast(entity.getComponent("VelocityComponent"), components.VelocityComponent);
            p.x = p.x + v.dx *dt;
            p.y = p.y + v.dy *dt;
        }
    }
}