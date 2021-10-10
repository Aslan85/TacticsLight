package components;

class PositionComponent extends dig.ecs.Component
{
    public var x:Float;
    public var y:Float;

    public override function new(x:Float, y:Float)
    {
        this.x = x;
        this.y = y;
        super(Type.getClassName(Type.getClass(this)));
    }
}