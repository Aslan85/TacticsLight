package components;

class GameStateComponent extends dig.ecs.Component
{
    public var gameState:Const.GameState;

    public override function new(gameState:Const.GameState)
    {
        this.gameState = gameState;
        super(Type.getClassName(Type.getClass(this)));
    }
}