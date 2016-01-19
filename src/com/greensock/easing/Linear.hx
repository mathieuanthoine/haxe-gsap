package com.greensock.easing;

/**
 * Linear
 */

#if (js)
@:native("Linear")
#end
extern class Linear extends Ease
{

	public function new();

	static public var	ease : Linear;

	static public var	easeIn : Linear;

	static public var	easeInOut : Linear;

	static public var	easeNone : Linear;

	static public var	easeOut : Linear;

}