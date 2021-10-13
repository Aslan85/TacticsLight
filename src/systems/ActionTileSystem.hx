package systems;
import components.PositionComponent;
import dig.ecs.*;

class ActionTileSystem extends dig.ecs.System
{
    var actionToThisTileEntities:List<Entity> = new List<Entity>();

    public override function refreshEntities(entities:List<Entity>):Void
    {
        actionToThisTileEntities = Game.allEntities.filter(function(e) return e.hasComponent("ActionToThisTileComponent"));
        if(actionToThisTileEntities.length > 0)
        {
            doActionToThisTile();
        }
    }

    private function doActionToThisTile():Void
    {
        // Do Move
        var selectedUnit = Game.allEntities.filter(function(e) return e.hasComponent("SelectedUnitComponent")).first();

        for(entity in actionToThisTileEntities)
        {
            // do move
            if(entity.hasComponent("MovableTileComponent"))
            {
                cast(selectedUnit.getComponent("PositionComponent"), PositionComponent).x = cast(entity.getComponent("PositionComponent"), PositionComponent).x;
                cast(selectedUnit.getComponent("PositionComponent"), PositionComponent).y = cast(entity.getComponent("PositionComponent"), PositionComponent).y;
                
                for(eMovable in Game.allEntities.filter(function(e) return e.hasComponent("MovableTileComponent")))
                {
                    eMovable.removeComponentByName("MovableTileComponent", false);
                }
            }

            entity.removeComponentByName("ActionToThisTileComponent", false);
        }
        Game.inst.refreshSystems();
    }
}