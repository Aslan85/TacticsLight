package components;

class DirectionComponent extends dig.ecs.Component
{
    public var dir:Const.Direction;

    public override function new(dir:Const.Direction)
    {
        this.dir = dir;
        super(Type.getClassName(Type.getClass(this)));
    }
}