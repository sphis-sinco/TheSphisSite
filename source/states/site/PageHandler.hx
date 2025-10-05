package states.site;

class PageHandler
{
	static var pages:Array<Page> = [];

	public static function destroyPages()
	{
		if (pages.length > 0)
			for (page in pages)
			{
				page.destroy();
				pages.remove(page);
			}
	}

	public static function loadPages()
	{
		destroyPages();

		var newpages = ScriptedPage.listScriptClasses();
		trace('Found ${newpages.length} pages to load');
		for (page in newpages)
		{
			var newpage = ScriptedPage.init(page, page);
			trace('* $page');
			pages.push(newpage);
		}
	}

	public static function getPage(id:String):Page
	{
		for (page in pages)
			if (page.id == id)
				return page;

		return null;
	}

	public static function callEvent(callback:Page->Void)
	{
		if (callback == null)
			return;

		for (page in pages)
			callback(page);
	}
}
