package components;

class TeamComponent extends dig.ecs.Component
{
    public var teamName:String;

    public override function new(teamName:String)
    {
        this.teamName = teamName;
        super(Type.getClassName(Type.getClass(this)));
    }
}