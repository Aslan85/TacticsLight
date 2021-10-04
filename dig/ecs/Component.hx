package dig.ecs;

class Component
{
    public var entity:Entity;
    public var name:String = "Component";
    
    public function new(entity:Entity, name:String)
    {
        this.entity = entity;
        this.entity.addComponent(this);
        this.name = name;
    }
}