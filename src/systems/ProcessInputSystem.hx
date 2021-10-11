package systems;
import components.InputComponent;
import dig.ecs.*;

class ProcessInputSystem extends dig.ecs.System
{
    var inputEntities:List<Entity> = new List<Entity>();

    public override function refreshEntities(entities:List<Entity>):Void
    {
        inputEntities = Game.allEntities.filter(function(e) return e.hasComponent("InputComponent"));
    }

    public override function update(dt:Float):Void
    {
        for(entity in inputEntities)
        {   
            var input:Const.Control = cast(entity.getComponent("InputComponent"), InputComponent).input;
            switch(input)
            {
                case Const.Control.Up: trace("Up");
                case Const.Control.Down: trace("Down");
                case Const.Control.Right: trace("Right");
                case Const.Control.Left: trace("Left");
                case Const.Control.Check: trace("Check");
                case Const.Control.Cancel: trace("Cancel");
                case _: trace("Nothing");
            }

            entity.kill();
        }
    }
}