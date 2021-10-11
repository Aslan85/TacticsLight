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
        var boardWith:Int = 8;
        var boardHeight:Int = 5;
        var tileSize:Int = 64;
        var tileMargin:Int = 2;
        var cellSize:Float = tileSize + tileMargin;
        var originVector:Vector2 = new Vector2(s2d.width/2 - cellSize*boardWith/2, s2d.height/2 -cellSize*boardHeight/2);
        var grid:Grid<Entity> = new Grid(boardWith, boardHeight, cellSize, originVector, function(g:Grid<Entity>, x:Int, y:Int)
        {
            var cell = new Entity(s2d, "cell_" +x +"_" +y);
            cell.addComponent(new PositionComponent(x *cellSize +originVector.x, y*cellSize +originVector.y));
            cell.addComponent(new TileComponent(hxd.Res.White_Square.toTile()));

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
            var cellPos = cast(grid.GetGridObject(0, i).getComponent("PositionComponent"), PositionComponent);
            pawn.addComponent(new PositionComponent(cellPos.x, cellPos.y));
            pawn.addComponent(new TileComponent(hxd.Res.bowman.toTile()));
            pawn.addComponent(new ColorComponent(new h3d.Vector(0.9, 0.2, 0.2, 1)));
            pawn.addComponent(new TeamComponent(Const.Team.Team1));
            pawn.addComponent(new ActComponent());
        }

        // load pawns Team 2
        for(i in 0...5)
        {
            var pawn = new Entity(s2d, "pawn_team1_" +i);
            var cellPos = cast(grid.GetGridObject(grid.GetWidth()-1, i).getComponent("PositionComponent"), PositionComponent);
            pawn.addComponent(new PositionComponent(cellPos.x, cellPos.y));
            pawn.addComponent(new TileComponent(hxd.Res.bowman.toTile()));
            pawn.addComponent(new ColorComponent(new h3d.Vector(0.2, 0.2, 0.9, 1)));
            pawn.addComponent(new TeamComponent(Const.Team.Team2));
        }
    }
}