package components;
import h2d.Bitmap;

class TileComponent extends dig.ecs.Component
{
    public var bmp : Bitmap;

    public override function new(entity:dig.ecs.Entity, tile:h2d.Tile)
    {
        super(entity, "TileComponent");
        this.bmp = new Bitmap(tile, entity.obj);
    }
}