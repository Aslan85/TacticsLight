package components;

class SelectedUnitComponent extends dig.ecs.Component
{
    public override function new()
    {
        super(Type.getClassName(Type.getClass(this)));
    }
}