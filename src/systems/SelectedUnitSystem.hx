package systems;
import dig.utils.Vector2;
import assets.Assets;
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
            var neighborTiles = Game.inst.grid.GetNeighbourList(new Vector2(gridPosition.x, gridPosition.y));

            // Todo select tiles with range
            for(nTiles in neighborTiles)
            {
                var movableTiles = new Entity(Game.inst.scene, "movableTiles_" +nTiles.name);
                var cellPos = cast(nTiles.getComponent("PositionComponent"), PositionComponent);
                movableTiles.addComponent(new PositionComponent(cellPos.x, cellPos.y), false);
                movableTiles.addComponent(new TileComponent(Assets.t_squareMovable), false);
                movableTiles.addComponent(new ColorComponent(new h3d.Vector(0.2, 0.8, 0.2, 1)), false);
                movableTiles.addComponent(new MovableTileComponent(), false);
                createdMovableTiles = true;
            }
        }
    }

    private function removeOldTiles():Void
    {
        for(mEnt in Game.allEntities.filter(function(e) return e.hasComponent("MovableTileComponent")))
        {
            mEnt.kill();
        }
    }
}