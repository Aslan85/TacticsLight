import h2d.Scene;
import dig.utils.*;
import systems.*;
import hxd.Key;

class Game extends hxd.App
{
    public static var inst:Game;
    public static var allSystems = new List<dig.ecs.System>();
    public static var allEntities = new List<dig.ecs.Entity>();

    public static var timeScale:Float = 1;
    public static var fixedDeltaTime:Float = 0.005;
    public static var fixedTimer:FixedTimer;

    public var scene:Scene;

    static function main()
    {
        hxd.Res.initEmbed();
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
    }

    private function initSystems()
    {
        // update
        allSystems.add(new PositionSystem());
        allSystems.add(new MovementSystem());

        // init
        allSystems.add(new LoadLevelSystem());
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

        // create entity
        if(Key.isReleased(Key.N))
        {
            var ent = new dig.ecs.Entity(Game.inst.getScene(), "first");
            new components.PositionComponent(ent, 200, 200);
            //new components.VelocityComponent(ent, 60, 0);
            new components.TileComponent(ent, hxd.Res.White_Square.toTile());
        }
    }

    public function fixedUpdate()
    {
        for(system in allSystems)
        {
            system.fixedUpdate();
        }
    }

    public function getScene():Scene
    {
        return this.scene;   
    }
}