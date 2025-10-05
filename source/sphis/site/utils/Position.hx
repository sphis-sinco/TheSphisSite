package sphis.site.utils;

class Position
{
	public var x:Float;
	public var y:Float;

	public function new(x:Float, y:Float)
	{
		this.x = x;
		this.y = y;
	}

	public function clone()
	{
		return new Position(x, y);
	}
}
