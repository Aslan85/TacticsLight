package components;

class ScaleComponent extends dig.ecs.Component
{
    public var sx:Float;
    public var sy:Float;

    public override function new(entity:dig.ecs.Entity, sx:Float, sy:Float)
    {
        this.sx = sx;
        this.sy = sy;
        super(entity, "ScaleComponent");
    }
}