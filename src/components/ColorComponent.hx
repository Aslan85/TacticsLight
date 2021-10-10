package components;

class ColorComponent extends dig.ecs.Component
{
    public var color:h3d.Vector;

    public override function new(color:h3d.Vector)
    {
        this.color = color;
        super(Type.getClassName(Type.getClass(this)));
    }
}