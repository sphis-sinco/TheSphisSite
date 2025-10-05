import flixel.FlxG;
import flixel.util.FlxColor;
import sphis.site.Preferences;
import sphis.site.modding.modules.Module;
import sphis.site.states.site.Index;
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

	public var backdrop:PageEvent;
	public var helloworld:PageEvent;
	public var version:PageEvent;

	public function reload()
	{
		backdrop = new PageEvent(new PageEventID(PageEventID.image, {
			general_position: new Position(0, 0),
			img_makeGraphic: true,
			img_graphicColor: (Preferences.darkMode) ? FlxColor.BLACK : FlxColor.WHITE,
			img_graphicDimensions: [FlxG.width, FlxG.height],
		}), 'backdrop');

		helloworld = new PageEvent(new PageEventID(PageEventID.text, {
			general_position: new Position(10, 10),
			text_content: "Hello world! Welcome to The Sinco Site!",
			text_size: 32,
			text_color: (Preferences.darkMode) ? FlxColor.WHITE : FlxColor.BLACK,
		}), 'hello-world');

		version = new PageEvent(new PageEventID(PageEventID.text, {general_position: new Position(0, 10),
			text_content: 'Git info:'
			+ '\nCommit: '
			+ GitUtils.getGitCommitHash()
			+ '\nBranch: '
			+ GitUtils.getGitBranch()
			+ '\nLocal Changes: '
			+ GitUtils.getGitHasLocalChanges(),
			text_size: 16,
			text_color: (Preferences.darkMode) ? FlxColor.WHITE : FlxColor.BLACK,
		}), 'version');
	}

	public function splitter(position:Position = null)
	{
		return new PageEvent(new PageEventID(PageEventID.image, {
			general_position: position ?? new Position(0, 100),
			img_makeGraphic: true,
			img_graphicColor: (Preferences.darkMode) ? FlxColor.fromString('0xA0A0A0') : FlxColor.fromString('0x808080'),
			img_graphicDimensions: [FlxG.width, 16],
		}), 'splitter');
	}

	public function back(position:Position)
	{
		return new PageEvent(new PageEventID(PageEventID.url_text, {
			general_position: position,

			text_content: "Back",
			text_size: 24,
			text_color: (Preferences.darkMode) ? FlxColor.WHITE : FlxColor.BLACK,

			url_obj_pressed_callback: () ->
			{
				FlxG.switchState(() -> new Index());
			},
			url_text_hover_color: FlxColor.LIME
		}), 'back-url');
	}
}
