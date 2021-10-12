package systems;
import dig.ecs.*;

class EmitInputSystem extends dig.ecs.System
{
    public override function update(dt:Float):Void
    {
        var ctrl = Const.Control.Nothing;

        if (hxd.Key.isPressed(hxd.Key.UP))
        {
            ctrl = Const.Control.Up;
        }
        else if (hxd.Key.isPressed(hxd.Key.DOWN))
        {
            ctrl = Const.Control.Down;
        }
        else if (hxd.Key.isPressed(hxd.Key.RIGHT))
        {
            ctrl = Const.Control.Right;
        }
        else if (hxd.Key.isPressed(hxd.Key.LEFT))
        {
            ctrl = Const.Control.Left;
        }
        else if (hxd.Key.isPressed(hxd.Key.ENTER) || hxd.Key.isPressed(hxd.Key.SPACE))
        {
            ctrl = Const.Control.Validate;
        }
        else if (hxd.Key.isPressed(hxd.Key.BACKSPACE))
        {
            ctrl = Const.Control.Cancel;
        }

        if(ctrl != Const.Control.Nothing)
        {
            var entity = new Entity(Game.inst.s2d, "input_" +hxd.Timer.frameCount);
            entity.addComponent(new components.InputComponent(ctrl));
        }
    }
}