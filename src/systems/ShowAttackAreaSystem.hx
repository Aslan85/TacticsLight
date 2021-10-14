package systems;
import dig.utils.Vector2;
import dig.ecs.*;
import components.*;

class ShowAttackAreaSystem extends dig.ecs.System
{
    var attackAreaEntities:List<Entity> = new List<Entity>();

    public override function refreshEntities(entities:List<Entity>):Void
    {
        attackAreaEntities = Game.allEntities.filter(function(e) return e.hasComponent("ShowAttackAreaComponent"));
    }

    public override function update(dt:Float):Void
    {
        for(entity in attackAreaEntities)
        {
            var entPos = new Vector2(cast(entity.getComponent("ShowAttackAreaComponent"), ShowAttackAreaComponent).x, cast(entity.getComponent("ShowAttackAreaComponent"), ShowAttackAreaComponent).y);
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

            // attack tiles
            var attackabletilesInRange = Game.inst.grid.GetCellsInRange(new Vector2(gridPosition.x, gridPosition.y), Math.floor(attribute.attackRange.x), Math.floor(attribute.attackRange.y));
            for(aTiles in attackabletilesInRange)
            {
                // don't show actual position
                if( cast(aTiles.getComponent("PositionComponent"), PositionComponent).x == entPos.x &&
                    cast(aTiles.getComponent("PositionComponent"), PositionComponent).y == entPos.y)
                {
                    continue;
                }
                var attackTiles = new Entity(Game.inst.scene, "attackTiles_" +aTiles.name);
                var cellPos = cast(aTiles.getComponent("PositionComponent"), PositionComponent);
                attackTiles.addComponent(new PositionComponent(cellPos.x, cellPos.y), false);
                attackTiles.addComponent(new AttackableTileComponent());
            }
            entity.kill();
        }
    }
}