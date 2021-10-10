package dig.utils;

class Array2D
{
    public static function create(w:Int, h:Int)
    {
        var a = [];
        for (x in 0...w)
        {
            a[x] = [];
            for (y in 0...h)
            {
                a[x][y] = null;
            }
        }
        return a;
    }
}