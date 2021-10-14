package components;

class HealthComponent extends dig.ecs.Component
{
    public var hp:Int;

    public override function new(hp:Int)
    {
        this.hp = hp;
        super(Type.getClassName(Type.getClass(this)));
    }
}