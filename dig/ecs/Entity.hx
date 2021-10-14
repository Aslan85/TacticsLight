package dig.ecs;

class Entity
{
    public var components:haxe.ds.Map<String, Component>;
    public var scene:h2d.Scene;
    public var obj:h2d.Object;
    public var bmp:h2d.Bitmap;
    public var name:String;

    public function new(scene:h2d.Scene, name:String = "Entity")
    {
        trace("Create new Entity : " +name);
        this.scene = scene;
        this.name = name;

        components = new haxe.ds.Map<String, Component>();
        obj = new h2d.Object(scene);
        Game.allEntities.add(this);
    }

    public function addComponent(c:Component, refresh=true)
    {
        trace("add component " +c.name +" to " +this.name);
        components[c.name] = c;

        if(refresh)
        {
            Game.inst.refreshSystems();
        }
    }

    public function removeComponent(c:Component, refresh=true)
    {
        trace("remove component " +c.name +" to " +this.name);
        components.remove(c.name);

        if(refresh)
        {
            Game.inst.refreshSystems();
        }
    }

    public function removeComponentByName(name:String, refresh=true)
    {
        removeComponent(cast(getComponent(name), Component), refresh);
    }

    public function getComponent(name:String):Component
    {
        return components[name];
    }

    public function hasComponent(name:String):Bool
    {
        return components[name] != null;
    }

    public function howManyComponents():Int
    {
        var howMany = 0;
        for (c in components) {
            howMany++;
        }
        return howMany;
    }

    public function kill(refresh=true)
    {
        this.bmp.remove();
        this.obj.remove();

        Game.allEntities.remove(this);
        if(refresh)
        {
            Game.inst.refreshSystems();
        }
        trace("Kill Entity : " +name);
    }
}