package mobile.funkin.backend.utils;

#if TOUCH_CONTROLS
import haxe.ds.Map;
import haxe.Json;
import haxe.io.Path;
import openfl.utils.Assets;
import flixel.util.FlxSave;

/**
 * ...
 * @author: Karim Akra
 */
class MobileData
{
	public static var actionModes:Map<String, TouchButtonsData> = new Map();
	public static var dpadModes:Map<String, TouchButtonsData> = new Map();

	public static var save:FlxSave;

	public static function init()
	{
		save = new FlxSave();
		save.bind('MobileControls', #if sys 'YoshiCrafter29/CodenameEngine' #else 'CodenameEngine' #end);

		for (folder in [
			'${ModsFolder.modsPath}${ModsFolder.currentModFolder}/mobile',
			Paths.getPath('mobile')
		])
			if (FileSystem.exists(folder) && FileSystem.isDirectory(folder))
			{
				setMap('$folder/DPadModes', dpadModes);
				setMap('$folder/ActionModes', actionModes);
			}
	}

	public static function clearTouchPadData()
	{
		dpadModes.clear();
		actionModes.clear();
	}

	private static function setMap(folder:String, map:Map<String, TouchButtonsData>)
	{
		for (file in FileSystem.readDirectory(folder))
		{
			if (Path.extension(file) == 'json')
			{
				file = Path.join([folder, Path.withoutDirectory(file)]);
				var str = File.getContent(file);
				var json:TouchButtonsData = cast Json.parse(str);
				var mapKey:String = Path.withoutDirectory(Path.withoutExtension(file));
				map.set(mapKey, json);
			}
		}
	}
}

typedef TouchButtonsData =
{
	buttons:Array<ButtonsData>
}

typedef ButtonsData =
{
	button:String, // what TouchButton should be used, must be a valid TouchButton var from TouchPad as a string.
	graphic:String, // the graphic of the button, usually can be located in the TouchPad xml .
	x:Float, // the button's X position on screen.
	y:Float, // the button's Y position on screen.
	color:String // the button color, default color is white.
}
#end
