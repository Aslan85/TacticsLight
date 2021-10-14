import assets.Assets;
import dig.utils.*;
import dig.ecs.*;
import components.*;

class InitGame
{
    public function new()
    {
    }

    public function loadLevel(s2d:h2d.Scene)
    {
        // load grid
        Game.inst.grid = new Grid(Const.boardWith, Const.boardHeight, Const.cellSize, Game.inst.gridOriginVector, function(g:Grid<Entity>, x:Int, y:Int)
        {
            var cell = new Entity(s2d, "cell_" +x +"_" +y);
            cell.addComponent(new PositionComponent(x *Const.cellSize +Game.inst.gridOriginVector.x, y*Const.cellSize +Game.inst.gridOriginVector.y), false);
            cell.addComponent(new TileComponent(Assets.t_squareWhite, Const.TileLayers.Board), false);

            var colorWhite:h3d.Vector = new h3d.Vector(0.9, 0.9, 0.9, 1);
            var colorBlack:h3d.Vector = new h3d.Vector(0.2, 0.2, 0.2, 1); 
            if((x%2 == 0 && y%2 == 0) || (x%2 != 0 && y%2 != 0))
            {
                cell.addComponent(new ColorComponent(colorWhite), false);
            }
            else
            {
                cell.addComponent(new ColorComponent(colorBlack), false);
            }
            
            return cell;
        });

        // load pawns Team 1
        for(i in 0...5)
        {
            var pawn = new Entity(s2d, "pawn_team1_" +i);
            var cellPos = cast(Game.inst.grid.GetGridObject(0, i).getComponent("PositionComponent"), PositionComponent);
            pawn.addComponent(new PositionComponent(cellPos.x, cellPos.y), false);
            pawn.addComponent(new TileComponent(Assets.c_bowman, Const.TileLayers.Unit), false);
            pawn.addComponent(new ColorComponent(new h3d.Vector(0.9, 0.2, 0.2, 1)), false);
            pawn.addComponent(new TeamComponent(Const.Team.Team1), false);
            var attribute = new AttributesComponent(10, 10, 10, Const.Elements.Fire, 2, new Vector2(3, 4));
            pawn.addComponent(attribute, false);
            pawn.addComponent(new HealthComponent(attribute.health), false);
            pawn.addComponent(new ActComponent(), false);
        }

        // load pawns Team 2
        for(i in 0...5)
        {
            var pawn = new Entity(s2d, "pawn_team2_" +i);
            var cellPos = cast(Game.inst.grid.GetGridObject(Game.inst.grid.GetWidth()-1, i).getComponent("PositionComponent"), PositionComponent);
            pawn.addComponent(new PositionComponent(cellPos.x, cellPos.y), false);
            pawn.addComponent(new TileComponent(Assets.c_pikeman, Const.TileLayers.Unit), false);
            pawn.addComponent(new ColorComponent(new h3d.Vector(0.2, 0.2, 0.9, 1)), false);
            pawn.addComponent(new TeamComponent(Const.Team.Team2), false);
            var attribute = new AttributesComponent(10, 10, 10, Const.Elements.Water, 2, new Vector2(3, 4));
            pawn.addComponent(attribute, false);
            pawn.addComponent(new HealthComponent(attribute.health), false);
        }

        // load select cursor
        var selectCursor = new Entity(s2d, "select_cursor");
        var cellPos = cast(Game.inst.grid.GetGridObject(0, 0).getComponent("PositionComponent"), PositionComponent);
        selectCursor.addComponent(new PositionComponent(cellPos.x, cellPos.y), false);
        selectCursor.addComponent(new TileComponent(Assets.t_squareSelect, Const.TileLayers.Cursor), false);
        selectCursor.addComponent(new ColorComponent(new h3d.Vector(0.3, 0.3, 0.8, 1)), false);
        selectCursor.addComponent(new CursorSelectComponent());
    }
}