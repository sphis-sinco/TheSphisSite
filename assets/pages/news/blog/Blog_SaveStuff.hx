import flixel.FlxG;
import sphis.site.modding.modules.Module;

class Blog_SaveStuff extends Module
{
	override public function new()
	{
		super('blog-save-stuff');
	}

	override function onInitalizePreferences(event:Dynamic)
	{
		super.onInitalizePreferences(event);

		blogsReadNullCheck();

		trace(FlxG.save.data);
	}

	public function blogsReadNullCheck()
	{
		if (FlxG.save.data.blogsRead == null)
			FlxG.save.data.blogsRead = [];
	}

	public function addBlogToBlogsRead(blog:String)
	{
		if (!blogsReadHasBlog(blog))
			FlxG.save.data.blogsRead.push(blog);
	}

	public function removeBlogFromBlogsRead(blog:String)
	{
		if (blogsReadHasBlog(blog))
			FlxG.save.data.blogsRead.remove(blog);
	}

	public function blogsReadHasBlog(blog:String)
	{
		blogsReadNullCheck();

		return FlxG.save.data.blogsRead.contains(blog);
	}
}
