package dig.ecs;

import components.VelocityComponent;

class Entity
{
    public var components = new List<Component>();
    public var scene:h2d.Scene;
    public var obj:h2d.Object;
    public var bmp:h2d.Bitmap;
    public var name:String;

    public function new(scene:h2d.Scene, name:String = "Entity")
    {
        trace("Create new Entity");
        this.scene = scene;
        this.name = name;

        obj = new h2d.Object(scene);

        Game.allEntities.add(this);
    }

    public function addComponent(c:Component)
    {
        trace("add component " +c.name);
        components.add(c);

        Game.inst.refreshSystems();
    }

    public function removeComponent(c:Component)
    {
        trace("remove component " +c.name);
        components.remove(c);

        Game.inst.refreshSystems();
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

    public function kill()
    {
        Game.allEntities.remove(this);
    }
}