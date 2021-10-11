package components;

class TeamComponent extends dig.ecs.Component
{
    public var teamName:Const.Team;

    public override function new(teamName:Const.Team)
    {
        this.teamName = teamName;
        super(Type.getClassName(Type.getClass(this)));
    }
}