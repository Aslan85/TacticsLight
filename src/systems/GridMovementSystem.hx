package systems;
import dig.utils.Vector2;
import dig.ecs.*;

class GridMovementSystem extends dig.ecs.System
{
    var movingEntities:List<Entity> = new List<Entity>();

    public override function refreshEntities(entities:List<Entity>):Void
    {
        movingEntities = Game.allEntities.filter(function(e) return e.hasComponent("PositionComponent") && e.hasComponent("DirectionComponent"));
    }

    public override function update(dt:Float):Void
    {
        for(entity in movingEntities)
        {
            var p = cast(entity.getComponent("PositionComponent"), components.PositionComponent);
            var d = cast(entity.getComponent("DirectionComponent"), components.DirectionComponent);
            var g = Game.inst.grid;

            var entGridPosition = g.GetGridPositionFromWorldPosition(new Vector2(p.x, p.y));
            var nextPos:Vector2 = Vector2.zero();
            switch(d.dir)
            {
                case Up: nextPos = new Vector2(entGridPosition.x + Vector2.up().x, entGridPosition.y + Vector2.up().y);
                case Down: nextPos = new Vector2(entGridPosition.x + Vector2.down().x, entGridPosition.y + Vector2.down().y);
                case Right: nextPos = new Vector2(entGridPosition.x + Vector2.right().x, entGridPosition.y + Vector2.right().y);
                case Left: nextPos = new Vector2(entGridPosition.x + Vector2.left().x, entGridPosition.y + Vector2.left().y);
            }
            if(g.GetGridObject(Math.floor(nextPos.x), Math.floor(nextPos.y)) != null)
            {
                p.x = nextPos.x*Const.cellSize +Game.inst.gridOriginVector.x;
                p.y = nextPos.y*Const.cellSize +Game.inst.gridOriginVector.y;
            }
            entity.removeComponentByName("DirectionComponent", false);
        }
        if(movingEntities.length > 0)
        {
            Game.inst.refreshSystems();
        }
    }
}