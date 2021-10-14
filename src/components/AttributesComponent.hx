package components;

import dig.utils.Vector2;

class AttributesComponent extends dig.ecs.Component
{
    public var strength:Int;
    public var defense:Int;
    public var health:Int;
    public var element:Const.Elements;
    public var moveRange:Int;
    public var attackRange:Vector2;

    public override function new(strength:Int, defense:Int, health:Int, element:Const.Elements, moveRange:Int, attackRange:Vector2)
    {
        this.strength = strength;
        this.defense = defense;
        this.health = health;
        this.element = element;
        this.moveRange = moveRange;
        this.attackRange = attackRange;
        super(Type.getClassName(Type.getClass(this)));
    }
}