import flixel.FlxG;
import flixel.util.FlxColor;
import sphis.site.modding.modules.Module;
import sphis.site.states.site.PageEvent;
import sphis.site.states.site.PageEventID;
import sphis.site.utils.GitUtils;
import sphis.site.utils.Position;

class BasePageShit extends Module
{
	override public function new()
	{
		super('base-page-shit');
	}

	public var backdrop:PageEvent = new PageEvent(new PageEventID(PageEventID.image, {
		general_position: new Position(0, 0),
		img_makeGraphic: true,
		img_graphicColor: FlxColor.WHITE,
		img_graphicDimensions: [FlxG.width, FlxG.height],
	}), 'backdrop');

	public var helloworld:PageEvent = new PageEvent(new PageEventID(PageEventID.text, {
		general_position: new Position(10, 10),
		text_content: "Hello world! Welcome to The Sinco Site!",
		text_size: 32,
		text_color: FlxColor.BLACK,
	}), 'hello-world');

	public var version:PageEvent = new PageEvent(new PageEventID(PageEventID.text, {general_position: new Position(0, 10),
		text_content: 'Git info:'
		+ '\nCommit: '
		+ GitUtils.getGitCommitHash()
		+ '\nBranch: '
		+ GitUtils.getGitBranch()
		+ '\nLocal Changes: '
		+ GitUtils.getGitHasLocalChanges(),
		text_size: 16,
		text_color: FlxColor.BLACK,
	}), 'version');

	public var splitter:PageEvent = new PageEvent(new PageEventID(PageEventID.image, {
		general_position: new Position(0, 100),
		img_makeGraphic: true,
		img_graphicColor: FlxColor.GRAY,
		img_graphicDimensions: [FlxG.width, 16],
	}), 'splitter');
}
