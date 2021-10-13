package components;
import h2d.Bitmap;

class TileComponent extends dig.ecs.Component
{
    public var tile:h2d.Tile;
    public var layer:Int;

    public override function new(tile:h2d.Tile, layer:Int)
    {
        this.tile = tile;
        this.layer = layer;
        super(Type.getClassName(Type.getClass(this)));
    }
}