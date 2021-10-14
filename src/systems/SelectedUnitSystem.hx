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
        }
        if(addedTileEntities.length > 0)
        {  
            showSelectedTiles(addedTileEntities);
        }
    }

    private function showSelectedTiles(entities:List<Entity>):Void
    {        
        for(entity in entities)
        {
            var entPos = cast(entity.getComponent("PositionComponent"), PositionComponent);
            var gridPosition = Game.inst.grid.GetGridPositionFromWorldPosition(new Vector2(entPos.x, entPos.y));
            var attribute = cast(entity.getComponent("AttributesComponent"), AttributesComponent);
            var allUnits = Game.allEntities.filter(function(e) return e.hasComponent("TeamComponent"));
            
            // moving tiles
            //var movingtilesInRange = Game.inst.grid.GetCellsInRange(new Vector2(gridPosition.x, gridPosition.y), 1, attribute.moveRange);
            var obstaclesList:List<Vector2> = new List<Vector2>();
            for(aU in allUnits)
            {
                var pos = cast(aU.getComponent("PositionComponent"), PositionComponent);
                obstaclesList.add(Game.inst.grid.GetGridPositionFromWorldPosition(new Vector2(pos.x, pos.y)));
            }
            var movingtilesInRange = Game.inst.grid.GetCellsInRangeWithConstraints(new Vector2(gridPosition.x, gridPosition.y), obstaclesList, 1, attribute.moveRange);
            for(mTiles in movingtilesInRange)
            {
                // do not create movable tiles if entity are in range
                var createMovable = true;
                for(aU in allUnits)
                {
                    if( cast(aU.getComponent("PositionComponent"),PositionComponent).x == cast(mTiles.getComponent("PositionComponent"),PositionComponent).x &&
                        cast(aU.getComponent("PositionComponent"),PositionComponent).y == cast(mTiles.getComponent("PositionComponent"),PositionComponent).y)
                    {
                        createMovable = false;
                    }
                }
                if(!createMovable)
                {
                    continue;
                }

                // create movable tiles
                var movableTiles = new Entity(Game.inst.scene, "movableTiles_" +mTiles.name);
                var cellPos = cast(mTiles.getComponent("PositionComponent"), PositionComponent);
                movableTiles.addComponent(new PositionComponent(cellPos.x, cellPos.y), false);
                movableTiles.addComponent(new MovableTileComponent(), false);
                createdMovableTiles = true;
            }

            /*
            // attackable tiles
            var attackabletilesInRange = Game.inst.grid.GetCellsInRange(new Vector2(gridPosition.x, gridPosition.y), Math.floor(attribute.attackRange.x), Math.floor(attribute.attackRange.y));
            for(aTiles in attackabletilesInRange)
            {
                var movableTiles = new Entity(Game.inst.scene, "attackableTiles_" +aTiles.name);
                var cellPos = cast(aTiles.getComponent("PositionComponent"), PositionComponent);
                movableTiles.addComponent(new PositionComponent(cellPos.x, cellPos.y), false);
                movableTiles.addComponent(new AttackableTileComponent(), false);
                createdMovableTiles = true;
            }
            */
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