package components;

class ScaleComponent extends dig.ecs.Component
{
    public var sx:Float;
    public var sy:Float;

    public override function new(sx:Float, sy:Float)
    {
        this.sx = sx;
        this.sy = sy;
        super(Type.getClassName(Type.getClass(this)));
    }
}