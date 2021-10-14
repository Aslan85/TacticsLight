package systems;
import dig.utils.Vector2;
import dig.ecs.*;
import components.*;
using Lambda;

class SelectedUnitSystem extends dig.ecs.System
{
    var oldEntities:List<Entity> = new List<Entity>();
    var selectedEntities:List<Entity> = new List<Entity>();
    var createdMovableTiles:Bool = false;

    public override function refreshEntities(entities:List<Entity>):Void
    {
        selectedEntities = Game.allEntities.filter(function(e) return e.hasComponent("SelectedUnitComponent"));
        updateSelection();
        oldEntities.clear();
        for(ent in selectedEntities)
        {
            oldEntities.add(ent);
        }

        if(createdMovableTiles)
        {
            createdMovableTiles = false;
            Game.inst.refreshSystems();
        }
    }

    private function updateSelection():Void
    {
        var removedTileEntities = new List<Entity>();
        for(e in oldEntities)
        {
            if(!selectedEntities.exists(function(d) return d==e))
            {
                removedTileEntities.add(e);
            }
        }

        var addedTileEntities = new List<Entity>();
        for(e in selectedEntities)
        {
            if(!oldEntities.exists(function(d) return d==e))
            {
                addedTileEntities.add(e);
            }
        }

        if(removedTileEntities.length > 0)
        {
            removeOldTiles();
            createdMovableTiles = true;
        }
        if(addedTileEntities.length > 0)
        {  
            showSelectedTiles(addedTileEntities);
            createdMovableTiles = true;
        }
    }

    private function showSelectedTiles(entities:List<Entity>):Void
    {        
        for(entity in entities)
        {
            var entPos = cast(entity.getComponent("PositionComponent"), PositionComponent);

            var entityMoveRangeArea = new Entity(Game.inst.s2d, "show_movable_area_" +hxd.Timer.frameCount);
            entityMoveRangeArea.addComponent(new ShowMoveAreaComponent(entPos.x, entPos.y), false);

            var entityAttackRangeArea = new Entity(Game.inst.s2d, "show_attack_area_" +hxd.Timer.frameCount);
            entityAttackRangeArea.addComponent(new ShowAttackAreaComponent(entPos.x, entPos.y), false);
        }
    }

    private function removeOldTiles():Void
    {
        for(mEnt in Game.allEntities.filter(function(e) return e.hasComponent("MovableTileComponent")))
        {
            mEnt.removeComponentByName("MovableTileComponent", false);
        }
        for(aEnt in Game.allEntities.filter(function(e) return e.hasComponent("AttackableTileComponent")))
        {
            aEnt.removeComponentByName("AttackableTileComponent", false);
        }
    }
}