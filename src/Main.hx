class Main extends hxd.App
{
    override function init()
    {
        var tf = new h2d.Text(hxd.res.DefaultFont.get(), s2d);
        tf.text = "Welcome to the first draft of Tactics Light!";
        
        var tf2 = new h2d.Text(hxd.res.DefaultFont.get(), s2d);
        tf2.text = "This actual version is just a placeholder and can not be played.";
        tf2.y = 16;

        var tf3 = new h2d.Text(hxd.res.DefaultFont.get(), s2d);
        tf3.text = "version 0.01";
        tf3.x = s2d.width -100;
        tf3.y = s2d.height -16;
    }
    static function main()
    {
        new Main();
    }
}