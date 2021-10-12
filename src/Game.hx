import h2d.Scene;
import dig.utils.*;
import systems.*;
import hxd.Key;
import dig.ecs.*;

class Game extends hxd.App
{
    public static var inst:Game;
    public static var debugMode:Bool;
    public static var allSystems = new List<dig.ecs.System>();
    public static var allEntities = new List<dig.ecs.Entity>();

    public static var timeScale:Float = 1;
    public static var fixedDeltaTime:Float = 0.005;
    public static var fixedTimer:FixedTimer;

    public var scene:Scene;
    public var hud:Hud;
    public var grid:Grid<Entity>;
    public var gridOriginVector:Vector2;

    static function main()
    {
		#if hl
		hxd.res.Resource.LIVE_UPDATE = true;
        hxd.Res.initLocal();
		#else
		hxd.Res.initEmbed();
		#end

        debugMode = false;
        inst = new Game();
    }

    override function init()
    {
        // fixed timer
        fixedTimer = new FixedTimer(Std.int(fixedDeltaTime * 1000));
        fixedTimer.hooks.add(this.fixedUpdate);

        // add scene
        this.scene = s2d;

        // init systems
        initSystems();

        // add UI
        hud = new Hud(s2d);

        // load testing level
        gridOriginVector = new Vector2(s2d.width/2 - Const.cellSize*Const.boardWith/2, s2d.height/2 -Const.cellSize*Const.boardHeight/2);
        var level = new InitGame();
        level.loadLevel(this.scene);
    }

    private function initSystems()
    {
        // Characters
        allSystems.add(new PositionSystem());
        allSystems.add(new TileSystem());
        allSystems.add(new ScaleSystem());
        allSystems.add(new ColorSystem());

        // Input
        allSystems.add(new EmitInputSystem());
        allSystems.add(new ProcessInputSystem());

        // Gameplay
        allSystems.add(new GridMovementSystem());
        allSystems.add(new MenuNavigationSystem());
    }

    public function refreshSystems()
    {
        // refresh all entities use in system
        for(system in allSystems)
        {
            system.refreshEntities(allEntities);
        }
    }

    override function update(dt:Float) 
    {
        // active/deactive debug info
        if(Key.isReleased(Key.D))
        {
            debugMode != debugMode;
        }

        // update
        for(system in allSystems)
        {
            system.update(dt);
        }

        // late update
        for(system in allSystems)
        {
            system.lateUpdate(dt);
        }

        // update UI
        hud.update(dt);
    }

    public function fixedUpdate()
    {
        for(system in allSystems)
        {
            system.fixedUpdate();
        }
    }
}