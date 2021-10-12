package systems;
import dig.ecs.*;

class ColorSystem extends dig.ecs.System
{
    var colorEntities:List<Entity> = new List<Entity>();

    public override function refreshEntities(entities:List<Entity>):Void
    {
        colorEntities = Game.allEntities.filter(function(e) return e.hasComponent("ColorComponent") && e.hasComponent("TileComponent"));
        if(colorEntities.length > 0)
        {
            colorize();
        }
    }

    private function colorize():Void
    {
        for(entity in colorEntities)
        {
            var c = cast(entity.getComponent("ColorComponent"), components.ColorComponent);
            entity.bmp.color = c.color;
            entity.removeComponentByName("ColorComponent", false);
        }
        Game.inst.refreshSystems();
    }
}