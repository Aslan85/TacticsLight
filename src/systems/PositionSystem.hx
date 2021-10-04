package systems;

class PositionSystem extends dig.ecs.System
{
    public override function update(dt:Float):Void
    {
        for(entity in Game.allEntities)
        {
            if(entity.hasComponent("PositionComponent"))
            {
                var p = cast(entity.getComponent("PositionComponent"), components.PositionComponent);
                entity.obj.setPosition(p.x, p.y);
            }
        }
    }
}