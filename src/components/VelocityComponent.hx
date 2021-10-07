package components;

class VelocityComponent extends dig.ecs.Component
{
    public var dx:Float;
    public var dy:Float;

    public override function new(dx:Float, dy:Float)
    {
        this.dx = dx;
        this.dy = dy;
        super(Type.getClassName(Type.getClass(this)));
    }
}