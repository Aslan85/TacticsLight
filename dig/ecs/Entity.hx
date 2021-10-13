package dig.ecs;

class Entity
{
    public var components = new List<Component>();
    public var scene:h2d.Scene;
    public var obj:h2d.Object;
    public var bmp:h2d.Bitmap;
    public var name:String;

    public function new(scene:h2d.Scene, name:String = "Entity")
    {
        trace("Create new Entity : " +name);
        this.scene = scene;
        this.name = name;

        obj = new h2d.Object(scene);

        Game.allEntities.add(this);
    }

    public function addComponent(c:Component, refresh=true)
    {
        trace("add component " +c.name +" to " +this.name);
        components.add(c);

        if(refresh)
        {
            Game.inst.refreshSystems();
        }
    }

    public function removeComponent(c:Component, refresh=true)
    {
        trace("remove component " +c.name +" to " +this.name);
        components.remove(c);

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
        var component = components.filter(function(c) return c.name == name);
        if(component.length > 0)
        {
            return component.first();
        }
        return null;
    }

    public function hasComponent(name:String):Bool
    {
        var component = components.filter(function(c) return c.name == name);
        if(component.length > 0)
        {
            return true;
        }
        return false;
    }

    public function howManyComponents():Int
    {
        return components.length;
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