package systems;
import dig.utils.Vector2;
import dig.ecs.*;

class MenuNavigationSystem extends dig.ecs.System
{
    var commandEntities:List<Entity> = new List<Entity>();
    var gameStateEntities:List<Entity> = new List<Entity>();

    public override function refreshEntities(entities:List<Entity>):Void
    {
        commandEntities = Game.allEntities.filter(function(e) return e.hasComponent("CommandComponent"));
        gameStateEntities = Game.allEntities.filter(function(e) return e.hasComponent("GameStateComponent"));
    }

    public override function update(dt:Float):Void
    {
        for(entity in commandEntities)
        {
            var c = cast(entity.getComponent("CommandComponent"), components.CommandComponent);
            var gameState:Const.GameState = cast(gameStateEntities.first().getComponent("GameStateComponent"), components.GameStateComponent).gameState;

            if(gameState == Const.GameState.Play)
            {
                switch(c.command)
                {
                    case Validate: trace("openMenu");
                    case Cancel: trace("cancel");
                    case _: trace("do nothing");
                }
            }
            else if(gameState == Const.GameState.Menu)
            {
                switch(c.command)
                {
                    case Validate: trace("validate in menu");
                    case Cancel: trace("cancel in menu");
                    case Up: trace("up in menu");
                    case Down: trace("down in menu");
                }
            }
            entity.kill();
        }
    }
}