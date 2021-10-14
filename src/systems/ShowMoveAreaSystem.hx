package systems;
import dig.utils.Vector2;
import dig.ecs.*;
import components.*;

class ShowMoveAreaSystem extends dig.ecs.System
{
    var moveAreaEntities:List<Entity> = new List<Entity>();

    public override function refreshEntities(entities:List<Entity>):Void
    {
        moveAreaEntities = Game.allEntities.filter(function(e) return e.hasComponent("ShowMoveAreaComponent"));
    }

    public override function update(dt:Float):Void
    {
        for(entity in moveAreaEntities)
        {            
            var entPos = new Vector2(cast(entity.getComponent("ShowMoveAreaComponent"), ShowMoveAreaComponent).x, cast(entity.getComponent("ShowMoveAreaComponent"), ShowMoveAreaComponent).y);
            var gridPosition = Game.inst.grid.GetGridPositionFromWorldPosition(new Vector2(entPos.x, entPos.y));
            var allUnits = Game.allEntities.filter(function(e) return e.hasComponent("TeamComponent"));
            
            // find selected unit attributes
            var attribute:AttributesComponent = null;
            for(aU in allUnits)
            {
                if( cast(aU.getComponent("PositionComponent"), PositionComponent).x == entPos.x &&
                    cast(aU.getComponent("PositionComponent"), PositionComponent).y == entPos.y)
                {
                    attribute = cast(aU.getComponent("AttributesComponent"), AttributesComponent);
                    break;
                }
            }
            if(attribute == null)
            {
                continue;
            }

            // moving tiles
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
                movableTiles.addComponent(new MovableTileComponent());
            }
            entity.kill();
        }
    }
}