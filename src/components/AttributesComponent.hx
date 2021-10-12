package components;

import dig.utils.Vector2;

class AttributesComponent extends dig.ecs.Component
{
    public var strength:Int;
    public var defense:Int;
    public var rangeMin:Vector2;

    public override function new(strength:Int, defense:Int, rangeMin:(Vector2))
    {
        this.strength = strength;
        this.defense = defense;
        this.rangeMin = rangeMin;
        super(Type.getClassName(Type.getClass(this)));
    }
}