package funkin.options.categories;

import flixel.input.keyboard.FlxKey;
import lime.system.System as LimeSystem;

class MobileOptions extends TreeMenuScreen
{
	public function new()
	{ 
		super('optionsTree.mobile-name', 'optionsTree.mobile-name', 'MobileOptions.', ['LEFT_FULL', 'A_B']);

		#if TOUCH_CONTROLS
		add(new ArrayOption(getNameID('extraHints'), getDescID('extraHints'), ['NONE', 'SINGLE', 'DOUBLE'],
			["None", "Single", "Double"], 'extraHints'));
		add(new NumOption(getNameID('hitboxAlpha'), getDescID('hitboxAlpha'), 0.0, 1.0, 0.1, "hitboxAlpha"));
		add(new Checkbox(getNameID('oldPadTexture'), getDescID('oldPadTexture'), "oldPadTexture", () ->
		{
			MusicBeatState.getState().removeTouchPad();
			MusicBeatState.getState().addTouchPad("LEFT_FULL", "A_B");
		}));
		add(new NumOption(getNameID('touchPadAlpha'), getDescID('touchPadAlpha'), 0.0, 1.0, 0.1, "touchPadAlpha", (alpha:Float) ->
		{
			MusicBeatState.getState().touchPad.alpha = alpha;
			if (funkin.backend.system.Controls.instance.touchC)
			{
				FlxG.sound.volumeUpKeys = [];
				FlxG.sound.volumeDownKeys = [];
				FlxG.sound.muteKeys = [];
			}
			else
			{
				FlxG.sound.volumeUpKeys = [FlxKey.PLUS, FlxKey.NUMPADPLUS];
				FlxG.sound.volumeDownKeys = [FlxKey.MINUS, FlxKey.NUMPADMINUS];
				FlxG.sound.muteKeys = [FlxKey.ZERO, FlxKey.NUMPADZERO];
			}
		}));
		add(new ArrayOption(getNameID('hitboxType'), getDescID('hitboxType'), ['noGradient', 'noGradientOld', 'gradient', 'hidden'],
			["No Gradient", "No Gradient (Old)", "Gradient", "Hidden"], 'hitboxType'));
		add(new Checkbox(getNameID('hitboxPos'), getDescID('hitboxPos'), "hitboxPos"));
		#end
		#if mobile
		add(new Checkbox(getNameID('screenTimeOut'), getDescID('screenTimeOut'), "screenTimeOut", () ->
		{
			LimeSystem.allowScreenTimeout = Options.screenTimeOut;
		}));
		#end
	}
}
