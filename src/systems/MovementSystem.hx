package systems;

class MovementSystem extends dig.ecs.System
{
    public override function update(dt:Float):Void
    {
        for(entity in Game.allEntities)
        {
            if(entity.hasComponent("PositionComponent") && entity.hasComponent("VelocityComponent"))
            {
                var p = cast(entity.getComponent("PositionComponent"), components.PositionComponent);
                var v = cast(entity.getComponent("VelocityComponent"), components.VelocityComponent);
                p.x = p.x + v.dx *dt;
                p.y = p.y + v.dy *dt;
            }
        }
    }
}