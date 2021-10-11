package components;

class InputComponent extends dig.ecs.Component
{
    public var input:Const.Control;

    public override function new(input:Const.Control)
    {
        this.input = input;
        super(Type.getClassName(Type.getClass(this)));
    }
}