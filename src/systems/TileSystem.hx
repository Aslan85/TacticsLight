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

        var didChange = false;
        if(!addedTileEntities.isEmpty())
        {
            addTile(addedTileEntities);
            didChange = true;
        }
        if(!removedTileEntities.isEmpty())
        {
            removeTile(removedTileEntities);
            didChange = true;
        }
        if(didChange)
        {
            fixZOrder();
        }
    }

    private function addTile(entities:List<Entity>):Void
    {        
        for(entity in entities)
        {
            var t = cast(entity.getComponent("TileComponent"), components.TileComponent);
            entity.bmp = new Bitmap(t.tile, entity.obj);
            //entity.bmp.tile = entity.bmp.tile.center();
        }
    }

    private function removeTile(entities:List<Entity>):Void
    {     
        for(entity in entities)
        {
            entity.bmp.remove();
        }
    }

    private function fixZOrder()
    {
        var arrayEntities = tileEntities.array();
        arrayEntities.sort(function(a:Entity, b:Entity)
        {
            if(cast(a.getComponent("TileComponent"), components.TileComponent).layer < cast(b.getComponent("TileComponent"), components.TileComponent).layer) return -1;
            else if(cast(a.getComponent("TileComponent"), components.TileComponent).layer < cast(b.getComponent("TileComponent"), components.TileComponent).layer) return 1;
            else return 0;
        });
 
        for(e in arrayEntities)
        {
            Game.inst.scene.removeChild(e.obj);
        }
         
        for(e in arrayEntities)
        {
            Game.inst.scene.addChild(e.obj);
        }
    }
}