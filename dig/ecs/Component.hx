package dig.ecs;

class Component
{
    public var name:String;
    
    public function new(name:String)
    {
        this.name = name.split(".")[1];
    }
}