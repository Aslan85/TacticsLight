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
            cell.addComponent(new PositionComponent(x *Const.cellSize +Game.inst.gridOriginVector.x, y*Const.cellSize +Game.inst.gridOriginVector.y));
            cell.addComponent(new TileComponent(Assets.t_squareWhite, Const.TileLayers.Board));

            var colorWhite:h3d.Vector = new h3d.Vector(0.9, 0.9, 0.9, 1);
            var colorBlack:h3d.Vector = new h3d.Vector(0.2, 0.2, 0.2, 1); 
            if((x%2 == 0 && y%2 == 0) || (x%2 != 0 && y%2 != 0))
            {
                cell.addComponent(new ColorComponent(colorWhite));
            }
            else
            {
                cell.addComponent(new ColorComponent(colorBlack));
            }
            
            return cell;
        });

        // load pawns Team 1
        for(i in 0...5)
        {
            var pawn = new Entity(s2d, "pawn_team1_" +i);
            var cellPos = cast(Game.inst.grid.GetGridObject(0, i).getComponent("PositionComponent"), PositionComponent);
            pawn.addComponent(new PositionComponent(cellPos.x, cellPos.y));
            pawn.addComponent(new TileComponent(Assets.c_bowman, Const.TileLayers.Unit));
            pawn.addComponent(new ColorComponent(new h3d.Vector(0.9, 0.2, 0.2, 1)));
            pawn.addComponent(new TeamComponent(Const.Team.Team1));
            pawn.addComponent(new AttributesComponent(10, 10, 10, Const.Elements.Fire, 2, new Vector2(3, 4)));
            pawn.addComponent(new ActComponent());
        }

        // load pawns Team 2
        for(i in 0...5)
        {
            var pawn = new Entity(s2d, "pawn_team2_" +i);
            var cellPos = cast(Game.inst.grid.GetGridObject(Game.inst.grid.GetWidth()-1, i).getComponent("PositionComponent"), PositionComponent);
            pawn.addComponent(new PositionComponent(cellPos.x, cellPos.y));
            pawn.addComponent(new TileComponent(Assets.c_pikeman, Const.TileLayers.Unit));
            pawn.addComponent(new ColorComponent(new h3d.Vector(0.2, 0.2, 0.9, 1)));
            pawn.addComponent(new TeamComponent(Const.Team.Team2));
            pawn.addComponent(new AttributesComponent(10, 10, 10, Const.Elements.Water, 2, new Vector2(3, 4)));
        }

        // load select cursor
        var selectCursor = new Entity(s2d, "select_cursor");
        var cellPos = cast(Game.inst.grid.GetGridObject(0, 0).getComponent("PositionComponent"), PositionComponent);
        selectCursor.addComponent(new PositionComponent(cellPos.x, cellPos.y));
        selectCursor.addComponent(new TileComponent(Assets.t_squareSelect, Const.TileLayers.Cursor));
        selectCursor.addComponent(new ColorComponent(new h3d.Vector(0.3, 0.3, 0.8, 1)));
        selectCursor.addComponent(new CursorSelectComponent());
    }
}