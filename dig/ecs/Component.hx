package dig.ecs;

class Component
{
    public var entity:Entity;
    public var name:String;
    
    public function new(entity:Entity, name:String)
    {
        this.name = name;
        this.entity = entity;
        this.entity.addComponent(this);
    }
}