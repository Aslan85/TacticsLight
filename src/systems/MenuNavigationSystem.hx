package systems;
import dig.utils.Vector2;
import dig.ecs.*;

class MenuNavigationSystem extends dig.ecs.System
{
    var commandEntities:List<Entity> = new List<Entity>();

    public override function refreshEntities(entities:List<Entity>):Void
    {
        commandEntities = Game.allEntities.filter(function(e) return e.hasComponent("CommandComponent"));
    }

    public override function update(dt:Float):Void
    {
        for(entity in commandEntities)
        {
            var c = cast(entity.getComponent("CommandComponent"), components.CommandComponent);
            switch(c.command)
            {
                case Validate: trace("validate");
                case Cancel: trace("cancel");
            }
            entity.kill();
        }
    }
}