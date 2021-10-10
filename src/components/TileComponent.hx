package components;
import h2d.Bitmap;

class TileComponent extends dig.ecs.Component
{
    public var tile:h2d.Tile;

    public override function new(tile:h2d.Tile)
    {
        this.tile = tile;
        super(Type.getClassName(Type.getClass(this)));
    }
}