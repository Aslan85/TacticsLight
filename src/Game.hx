import h2d.Scene;
import dig.utils.*;
import systems.*;

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
        allSystems = InitSystems();
    }

    private function InitSystems():List<dig.ecs.System>
    {
        var systems = new List<dig.ecs.System>();

        // init
        systems.add(new LoadLevelSystem());

        // update
        systems.add(new PositionSystem());
        systems.add(new MovementSystem());

        return systems;
    }

    override function update(dt:Float) 
    {
        var i = allSystems.length;

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