package systems;
import components.*;
import dig.ecs.*;

class ProcessInputSystem extends dig.ecs.System
{
    var inputEntities:List<Entity> = new List<Entity>();
    var cursorSelectEntities:List<Entity> = new List<Entity>();

    public override function refreshEntities(entities:List<Entity>):Void
    {
        inputEntities = Game.allEntities.filter(function(e) return e.hasComponent("InputComponent"));
        cursorSelectEntities = Game.allEntities.filter(function(e) return e.hasComponent("CursorSelectComponent"));
    }

    public override function update(dt:Float):Void
    {
        if(cursorSelectEntities.length <= 0)
        {
            return;
        }

        for(entity in inputEntities)
        {   
            var input:Const.Control = cast(entity.getComponent("InputComponent"), InputComponent).input;
            switch(input)
            {
                case Const.Control.Up: cursorSelectEntities.first().addComponent(new DirectionComponent(Const.Direction.Up));
                case Const.Control.Down: cursorSelectEntities.first().addComponent(new DirectionComponent(Const.Direction.Down));
                case Const.Control.Right: cursorSelectEntities.first().addComponent(new DirectionComponent(Const.Direction.Right));
                case Const.Control.Left: cursorSelectEntities.first().addComponent(new DirectionComponent(Const.Direction.Left));
                case Const.Control.Validate:
                    var newEntity = new Entity(Game.inst.s2d, "command_" +hxd.Timer.frameCount);
                    newEntity.addComponent(new components.CommandComponent(Const.Command.Validate));
                case Const.Control.Cancel:
                    var newEntity = new Entity(Game.inst.s2d, "command_" +hxd.Timer.frameCount);
                    newEntity.addComponent(new components.CommandComponent(Const.Command.Cancel));
                case _: trace("Nothing");
            }
            entity.kill();
        }
    }
}