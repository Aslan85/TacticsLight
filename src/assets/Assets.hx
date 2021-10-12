package assets;

class Assets
{
	// Fonts
	public static var fontPixel : h2d.Font;
	public static var fontTiny : h2d.Font;
	public static var fontSmall : h2d.Font;
	public static var fontMedium : h2d.Font;
	public static var fontLarge : h2d.Font;

	// Chara Tiles
	public static var c_bowman : h2d.Tile;
	public static var c_pikeman : h2d.Tile;
	public static var c_swordman : h2d.Tile;

    // Board Tiles
	public static var t_squareSelect : h2d.Tile;
	public static var t_squareWhite : h2d.Tile;
	public static var t_squareMovable : h2d.Tile;

    public static function init()
    {
		// Fonts
		fontPixel = hxd.Res.fonts.minecraftiaOutline.toFont();
		fontTiny = hxd.Res.fonts.barlow_condensed_medium_regular_9.toFont();
		fontSmall = hxd.Res.fonts.barlow_condensed_medium_regular_11.toFont();
		fontMedium = hxd.Res.fonts.barlow_condensed_medium_regular_17.toFont();
		fontLarge = hxd.Res.fonts.barlow_condensed_medium_regular_32.toFont();

        // Chara Tiles
        c_bowman = hxd.Res.chara.c_bowman.toTile();
        c_pikeman = hxd.Res.chara.c_pikeman.toTile();
        c_swordman = hxd.Res.chara.c_swordman.toTile();

        // Board Tiles
        t_squareSelect = hxd.Res.tiles.square_select.toTile();
        t_squareWhite = hxd.Res.tiles.square_white.toTile();
		t_squareMovable = hxd.Res.tiles.square_movable.toTile();
    }
}