package backend;

#if mobile
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxColor;
import openfl.Lib;
import openfl.events.TouchEvent;

class MobileControls extends FlxTypedGroup<FlxSprite>
{
	public static var up:Bool = false;
	public static var down:Bool = false;
	public static var left:Bool = false;
	public static var right:Bool = false;
	public static var accept:Bool = false;
	public static var back:Bool = false;
	public static var pause:Bool = false;
	private static var initialized:Bool = false;
	private static var touches:Map<Int, String> = new Map<Int, String>();
	private static var justUp:Bool = false;
	private static var justDown:Bool = false;
	private static var justLeft:Bool = false;
	private static var justRight:Bool = false;
	private static var justAccept:Bool = false;
	private static var justBack:Bool = false;
	private static var justPause:Bool = false;

	public function new(?camera:flixel.FlxCamera)
	{
		super();
		if (camera != null) cameras = [camera];
		if (!initialized)
		{
			initialized = true;
			Lib.current.stage.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
			Lib.current.stage.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
			Lib.current.stage.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
			FlxG.signals.postUpdate.add(clearJustPressed);
		}
		build();
	}

	private function build():Void
	{
		clear();
		addButton("LEFT", 35, 535, 105, 105, 0.72);
		addButton("DOWN", 150, 595, 105, 105, 0.72);
		addButton("UP", 150, 475, 105, 105, 0.72);
		addButton("RIGHT", 265, 535, 105, 105, 0.72);
		addButton("LEFT", 825, 535, 105, 105, 0.72);
		addButton("DOWN", 940, 595, 105, 105, 0.72);
		addButton("UP", 940, 475, 105, 105, 0.72);
		addButton("RIGHT", 1055, 535, 105, 105, 0.72);
		addButton("ACCEPT", 1090, 35, 75, 60, 0.55);
		addButton("BACK", 1005, 35, 75, 60, 0.55);
		addButton("PAUSE", 920, 35, 75, 60, 0.55);
	}

	private function addButton(label:String, x:Float, y:Float, w:Float, h:Float, alpha:Float):Void
	{
		var s = new FlxSprite(x, y);
		s.makeGraphic(Std.int(w), Std.int(h), FlxColor.WHITE);
		s.alpha = alpha * 0.28;
		s.scrollFactor.set();
		add(s);
		var t = new FlxText(x, y + h * 0.28, w, label == "ACCEPT" ? "A" : label == "BACK" ? "B" : label == "PAUSE" ? "II" : label.charAt(0), 24);
		t.alignment = CENTER;
		t.alpha = alpha;
		t.scrollFactor.set();
		add(cast t);
	}

	private static function zone(x:Float, y:Float):String
	{
		if (y < 100 && x > 900)
		{
			if (x > 1080) return "ACCEPT";
			if (x > 995) return "BACK";
			return "PAUSE";
		}
		if (x >= 35 && x < 370 && y > 450) return directionFor(x, y, 35);
		if (x >= 825 && x < 1170 && y > 450) return directionFor(x, y, 825);
		return "";
	}

	private static function directionFor(x:Float, y:Float, baseX:Float):String
	{
		if (x < baseX + 115) return "LEFT";
		if (x < baseX + 230) return "DOWN";
		if (x < baseX + 345) return "RIGHT";
		return "";
	}

	private static function onTouchBegin(e:TouchEvent):Void setTouch(e.touchPointID, e.stageX, e.stageY);
	private static function onTouchMove(e:TouchEvent):Void setTouch(e.touchPointID, e.stageX, e.stageY);

	private static function onTouchEnd(e:TouchEvent):Void
	{
		var old = touches.get(e.touchPointID);
		if (old != null) setKey(old, false);
		touches.remove(e.touchPointID);
	}

	private static function setTouch(id:Int, screenX:Float, screenY:Float):Void
	{
		var w = Lib.current.stage.stageWidth;
		var h = Lib.current.stage.stageHeight;
		if (w <= 0 || h <= 0) return;
		var next = zone(screenX / w * FlxG.width, screenY / h * FlxG.height);
		var old = touches.get(id);
		if (old == next) return;
		if (old != null) setKey(old, false);
		if (next != "")
		{
			touches.set(id, next);
			setKey(next, true);
		}
	}

	private static function setKey(key:String, value:Bool):Void
	{
		switch (key)
		{
			case "UP": up = value; if (value) justUp = true;
			case "DOWN": down = value; if (value) justDown = true;
			case "LEFT": left = value; if (value) justLeft = true;
			case "RIGHT": right = value; if (value) justRight = true;
			case "ACCEPT": accept = value; if (value) justAccept = true;
			case "BACK": back = value; if (value) justBack = true;
			case "PAUSE": pause = value; if (value) justPause = true;
		}
	}

	private static function clearJustPressed():Void
	{
		justUp = justDown = justLeft = justRight = false;
		justAccept = justBack = justPause = false;
	}

	public static function justPressed(key:String):Bool
	{
		return switch (key)
		{
			case "note_up", "ui_up": justUp;
			case "note_down", "ui_down": justDown;
			case "note_left", "ui_left": justLeft;
			case "note_right", "ui_right": justRight;
			case "accept": justAccept;
			case "back": justBack;
			case "pause": justPause;
			default: false;
		};
	}

	public static function pressed(key:String):Bool
	{
		return switch (key)
		{
			case "note_up", "ui_up": up;
			case "note_down", "ui_down": down;
			case "note_left", "ui_left": left;
			case "note_right", "ui_right": right;
			case "accept": accept;
			case "back": back;
			case "pause": pause;
			default: false;
		};
	}

	public static function justReleased(key:String):Bool return false;
}
#end
