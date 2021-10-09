@:uiComp("view")
class ViewComp extends h2d.Flow implements h2d.domkit.Object
{
	static var SRC =
	<view class="mybox" min-width="200" content-halign={align}>
		<text text={"Tactics Light"}/>
		for( i in icons )
			<bitmap src={i} id="icons[]"/>
	</view>;

	public function new(align:h2d.Flow.FlowAlign,icons:Array<h2d.Tile>,?parent)
	{
		super(parent);
		initComponent();
	}
}

@:uiComp("label")
class LabelComp extends h2d.Flow implements h2d.domkit.Object
{
	static var SRC =
	<label>
		<text public id="labelTxt"/>
	</label>;

	public var label(get, set): String;
	function get_label() return labelTxt.text;
	function set_label(s)
	{
		labelTxt.text = s;
		return s;
	}

	public function new(?parent)
	{
		super(parent);
		initComponent();
	}
}

@:uiComp("container")
class ContainerComp extends h2d.Flow implements h2d.domkit.Object
{
	static var SRC =
	<container>
		<view(align,[]) id="view"/>
		<label public id="fpscount"/>
	</container>;

	public function new(align:h2d.Flow.FlowAlign, ?parent)
	{
		super(parent);
		initComponent();
	}
}

class Hud
{
	var center : h2d.Flow;
	var style = null;
	var root:ContainerComp;

	public function new(s2d:h2d.Scene)
    {
		center = new h2d.Flow(s2d);
		center.horizontalAlign = center.verticalAlign = Top;
		onResize(s2d);

		root = new ContainerComp(Middle, center);
		
		style = new h2d.domkit.Style();
		style.load(hxd.Res.style);
		style.addObject(root);
	}

	public function update(dt:Float)
    {
		root.fpscount.label = "fps : " +hxd.Timer.fps();

		style.sync();
	}

	private function onResize(s2d:h2d.Scene)
	{
		center.minWidth = center.maxWidth = s2d.width;
		center.minHeight = center.maxHeight = s2d.height;
	}
}
