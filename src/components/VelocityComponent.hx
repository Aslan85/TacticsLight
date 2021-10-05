package components;

class VelocityComponent extends dig.ecs.Component
{
    public var dx:Float;
    public var dy:Float;

    public override function new(entity:dig.ecs.Entity, dx:Float, dy:Float)
    {
        this.dx = dx;
        this.dy = dy;
        super(entity, "VelocityComponent");
    }
}