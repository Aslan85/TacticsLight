package components;

class CommandComponent extends dig.ecs.Component
{
    public var command:Const.Command;

    public override function new(command:Const.Command)
    {
        this.command = command;
        super(Type.getClassName(Type.getClass(this)));
    }
}