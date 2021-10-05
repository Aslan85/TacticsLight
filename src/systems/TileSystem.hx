package systems;
import dig.ecs.*;
import h2d.Bitmap;
using Lambda;

class TileSystem extends dig.ecs.System
{
    var oldEntities:List<Entity> = new List<Entity>();
    var tileEntities:List<Entity> = new List<Entity>();

    public override function refreshEntities(entities:List<Entity>):Void
    {
        tileEntities = Game.allEntities.filter(function(e) return e.hasComponent("TileComponent"));
        updateTile();
        oldEntities.clear();
        for(ent in tileEntities)
        {
            oldEntities.add(ent);
        }
    }

    private function updateTile():Void
    {
        var removedTileEntities = new List<Entity>();
        for(e in oldEntities)
        {
            if(!tileEntities.exists(function(d) return d==e))
            {
                removedTileEntities.add(e);
            }
        }

        var addedTileEntities = new List<Entity>();
        for(e in tileEntities)
        {
            if(!oldEntities.exists(function(d) return d==e))
            {
                addedTileEntities.add(e);
            }
        }

        addTile(addedTileEntities);
        removeTile(removedTileEntities);
    }

    private function addTile(entities:List<Entity>):Void
    {        
        for(entity in entities)
        {
            var t = cast(entity.getComponent("TileComponent"), components.TileComponent);
            entity.bmp = new Bitmap(t.tile, entity.obj);
        }
    }

    private function removeTile(entities:List<Entity>):Void
    {     
        for(entity in entities)
        {
            entity.bmp.remove();
        }
    }
}