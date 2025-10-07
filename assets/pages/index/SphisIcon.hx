import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import sphis.site.modding.events.CreateEvent;
import sphis.site.modding.events.UpdateEvent;
import sphis.site.modding.modules.Module;
import sphis.site.states.site.Index;
import sphis.site.utils.PathUtils;
import sphis.site.utils.Position;

class SphisIcon extends Module
{
	public var icon:FlxSprite;

	public var poses:Array<
		{
			suffix:String,
			chance:Float,
			offsets:Position
		}> = [];

	public function addPose(suffix:String, chance:Float, ?offsets:Position)
	{
		poses.push({
			suffix: suffix,
			chance: chance,
			offsets: ((offsets != null) ? offsets : new Position(0, 0)),
		});
	}

	override public function new()
	{
		super('sphis-icon');

		poses = [];

		addPose('chill', 45);
		addPose('eye glint', 8, new Position(30, 60));
		addPose('smirk', 15, new Position(-30, -15));
		addPose(':0', 30);
		addPose(':D', 30);
		addPose('bucket', 25);
		addPose('confused', 5);
		addPose('toungeOut', 18);
	}

	override function onCreate(event:CreateEvent)
	{
		super.onCreate(event);

		if (event.state != 'index')
			return;

		icon = new FlxSprite();
		newPose('chill');

		icon.screenCenter();
		icon.x += (icon.width * 1.2);
		icon.y += (icon.height * .5);

		performedPostCreateFunctionsTick = 0;

		newPose(null);
	}

	public function newPose(desire:String)
	{
		icon.frames = FlxAtlasFrames.fromSparrow(PathUtils.getImage('pages/index/Sphis_Icon'), PathUtils.getAssetPath('pages/index/Sphis_Icon.xml'));

		for (pose in poses)
		{
			var cond = (FlxG.random.bool(pose.chance) && !icon.animation.getNameList().contains('pose')) || pose.suffix == desire;

			if (cond)
			{
				icon.animation.addByPrefix('pose', 'pose ' + pose.suffix, 24);
				icon.offset.set(pose.offsets.x, pose.offsets.y);

				trace(pose.suffix);
			}
		}

		if (icon.animation.getNameList().length < 1)
		{
			newPose(null);
			return;
		}

		icon.animation.play('pose');
		icon.antialiasing = true;
	}

	public var performedPostCreateFunctionsTick = 0;
	public var performedPostCreateFunctionsMaxTick = 1;

	override function onUpdate(event:UpdateEvent)
	{
		super.onUpdate(event);

		if (event.state != 'index')
			return;

		if (icon == null)
			return;
		icon.scale.set(1, 1);

		if (FlxG.mouse.overlaps(icon))
		{
			if (FlxG.mouse.pressed)
				icon.scale.set(.9, .9);
			if (FlxG.mouse.justReleased)
				newPose(null);
		}

		if (performedPostCreateFunctionsTick == performedPostCreateFunctionsMaxTick)
			return;

		performedPostCreateFunctionsTick++;

		if (performedPostCreateFunctionsTick < performedPostCreateFunctionsMaxTick)
			return;

		Index.instance.add(icon);
	}
}
