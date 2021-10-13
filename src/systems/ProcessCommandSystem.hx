package systems;
import dig.utils.*;
import dig.ecs.*;
import components.*;

class ProcessCommandSystem extends dig.ecs.System
{
    var commandEntities:List<Entity> = new List<Entity>();
    var cursorSelectEntities:List<Entity> = new List<Entity>();
    var gameStateEntities:List<Entity> = new List<Entity>();

    public override function refreshEntities(entities:List<Entity>):Void
    {
        commandEntities = Game.allEntities.filter(function(e) return e.hasComponent("CommandComponent"));
        cursorSelectEntities = Game.allEntities.filter(function(e) return e.hasComponent("CursorSelectComponent"));
        gameStateEntities = Game.allEntities.filter(function(e) return e.hasComponent("GameStateComponent"));
    }

    public override function update(dt:Float):Void
    {
        for(entity in commandEntities)
        {
            var c = cast(entity.getComponent("CommandComponent"), CommandComponent);
            var gameState:Const.GameState = cast(gameStateEntities.first().getComponent("GameStateComponent"), GameStateComponent).gameState;

            if(gameState == Const.GameState.Play)
            {
                switch(c.command)
                {
                    case Validate:
                        // Detect where is the cursor
                        var cursorPos = cast(cursorSelectEntities.first().getComponent("PositionComponent"), PositionComponent);
                        var g = Game.inst.grid;
                        var tileOnCursor = g.GetGridObjectFromWorldPosition(new Vector2(cursorPos.x, cursorPos.y));

                        // Check if click on unit and show moving/attack area
                        var teamEntities = Game.allEntities.filter(function(e) return e.hasComponent("TeamComponent") && e.hasComponent("ActComponent"));
                        var selectedEntity = teamEntities.filter(function(c) return
                                cast(c.getComponent("PositionComponent"), PositionComponent).x == cast(tileOnCursor.getComponent("PositionComponent"), PositionComponent).x  &&
                                cast(c.getComponent("PositionComponent"), PositionComponent).y == cast(tileOnCursor.getComponent("PositionComponent"), PositionComponent).y)
                                .first();
                        if(selectedEntity != null)
                        {
                            cleanOldSelection();
                            selectedEntity.addComponent(new SelectedUnitComponent());
                        }

                        // Check if click on movable tiles
                        else
                        {
                            var movableTiles = Game.allEntities.filter(function(e) return e.hasComponent("MovableTileComponent"));
                            var selectMovableEntity = movableTiles.filter(function(c) return
                                    cast(c.getComponent("PositionComponent"), PositionComponent).x == cast(tileOnCursor.getComponent("PositionComponent"), PositionComponent).x  &&
                                    cast(c.getComponent("PositionComponent"), PositionComponent).y == cast(tileOnCursor.getComponent("PositionComponent"), PositionComponent).y)
                                    .first();
                            if(selectMovableEntity != null)
                            {
                                selectMovableEntity.addComponent(new ActionToThisTileComponent());
                            }
                        }
                    case Cancel:
                        cleanOldSelection();
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

    private function cleanOldSelection()
    {
        var listOldSelection = Game.allEntities.filter(function(e) return e.hasComponent("SelectedUnitComponent"));
        for(oldSelection in listOldSelection)
        {
            oldSelection.removeComponentByName("SelectedUnitComponent");
        }
    }
}