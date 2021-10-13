package systems;
import dig.ecs.*;
import components.*;
using Lambda;

class ShowActionTileSystem extends dig.ecs.System
{
    var oldEntities:List<Entity> = new List<Entity>();
    var actiontileEntities:List<Entity> = new List<Entity>();

    public override function refreshEntities(entities:List<Entity>):Void
    {
        actiontileEntities = Game.allEntities.filter(function(e) return e.hasComponent("MovableTileComponent") || e.hasComponent("AttackableTileComponent"));
        updateTile();
        oldEntities.clear();
        for(ent in actiontileEntities)
        {
            oldEntities.add(ent);
        }
    }

    private function updateTile():Void
    {
        var removedActionTileEntities = new List<Entity>();
        for(e in oldEntities)
        {
            if(!actiontileEntities.exists(function(d) return d==e))
            {
                removedActionTileEntities.add(e);
            }
        }

        var addedActionTileEntities = new List<Entity>();
        for(e in actiontileEntities)
        {
            if(!oldEntities.exists(function(d) return d==e))
            {
                addedActionTileEntities.add(e);
            }
        }

        if(!addedActionTileEntities.isEmpty())
        {
            addActionTile(addedActionTileEntities);
        }
        if(!removedActionTileEntities.isEmpty())
        {
            removeActionTile(removedActionTileEntities);
        }
    }

    private function addActionTile(entities:List<Entity>):Void
    {        
        for(entity in entities)
        {
            // Move tiles
            if(entity.hasComponent("MovableTileComponent"))
            {
                entity.addComponent(new TileComponent(assets.Assets.t_squareMovable, Const.TileLayers.TileSelect), false);
                entity.addComponent(new ColorComponent(new h3d.Vector(0.2, 0.8, 0.2, 1)), false);
            }

            // attackable tiles
            else if(entity.hasComponent("AttackableTileComponent"))
            {
                entity.addComponent(new TileComponent(assets.Assets.t_squareMovable, Const.TileLayers.TileSelect), false); // TODO atackable sprites
                entity.addComponent(new ColorComponent(new h3d.Vector(0.8, 0.2, 0.2, 1)), false);
            }
        }
    }

    private function removeActionTile(entities:List<Entity>):Void
    {     
        for(entity in entities)
        {
            entity.removeComponentByName("TileComponent", false);
            entity.kill(false);
        }
    }
}