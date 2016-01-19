package com.greensock.easing;

/**
 * Base class for all GreenSock easing equations. In its simplest form, an Ease is responsible for translating linear time (typically represented as a number between 0 and 1 where 0 is the beginning, 0.5 is halfway complete, and 1 is the end) into a value that has a different rate of change but still starts at 0 and ends at 1. In the GreenSock platform, eases are used to give tweens/animations the look and feel that the animator desires. For example, a ball rolling to a stop would decelerate over time (easeOut) rather than using a linear velocity. An Elastic ease could be used to make an object appear as though it is loosely attached somewhere and is snapping into place with loose (or tight) tension.
 */

#if (js)
@:native("Ease")
#end
extern class Ease
{
	/**
	 * Constructor
	 * @param	func (default = null) — Function (if any) that should be proxied. This is completely optional and is in fact rarely used except when you have your own custom ease function that follows the standard ease parameter pattern like time, start, change, duration.
	 * @param	extraParams (default = null) — If any extra parameters beyond the standard 4 (time, start, change, duration) need to be fed to the func function, define them as an array here. For example, the old Elastic.easeOut accepts 2 extra parameters in its standard equation (although the newer GreenSock version uses the more modern config() method for configuring the ease and doesn't require any extraPrams here)
	 * @param	type (default = 0) — Integer indicating the type of ease where 1 is easeOut, 2 is easeIn, 3 is easeInOut, and 0 is none of these.
	 * @param	power (default = 0) — Power of the ease where Linear is 0, Quad is 1, Cubic is 2, Quart is 3, Quint (and Strong) is 4, etc.
	 */
	public function new(?func:Void->Void, ?extraParams:Array<Dynamic>, ?type:Float, ?power:Float);
	
	/**
	 * Translates the tween's progress ratio into the corresponding ease ratio.
	 * @param	p progress ratio (a value between 0 and 1 indicating the progress of the tween/ease)  
	 * @return translated number
	 */
	public function getRatio(p:Float):Float;

	/**
	 * Allow to pass extra parameters to the Ease
	 * @param	varsX (indeterminate amount of parameters, don't know if there's a better way to do that)
	 * @return instance of Ease
	 */
	public function config (?vars0:Dynamic,?vars1:Dynamic,?vars2:Dynamic,?vars3:Dynamic,?vars4:Dynamic,?vars5:Dynamic,?vars6:Dynamic,?vars7:Dynamic,?vars8:Dynamic,?vars9:Dynamic):Ease;
}