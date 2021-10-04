package components;

class PositionComponent extends dig.ecs.Component
{
    public var x:Float;
    public var y:Float;

    public override function new(entity:dig.ecs.Entity, x:Float, y:Float)
    {
        super(entity, "PositionComponent");
        this.x = x;
        this.y = y;
    }
}