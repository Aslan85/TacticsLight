package systems;
import dig.ecs.*;

class ScaleSystem extends dig.ecs.System
{
    var scaleEntities:List<Entity> = new List<Entity>();

    public override function refreshEntities(entities:List<Entity>):Void
    {
        scaleEntities = Game.allEntities.filter(function(e) return e.hasComponent("ScaleComponent"));
    }

    public override function update(dt:Float):Void
    {
        for(entity in scaleEntities)
        {
            var s = cast(entity.getComponent("ScaleComponent"), components.ScaleComponent);
            entity.obj.scaleX = s.sx;
            entity.obj.scaleY = s.sy;
        }
    }
}