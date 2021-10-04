/**
 * VERSION: 1.935
 * DATE: 2013-03-18
 * AS3
 * UPDATES AND DOCS AT: http://www.greensock.com/loadermax/
 **/
package com.greensock.loading.core;

import flash.display.Sprite;

/**
 * Serves as the base class for SWFLoader and ImageLoader. There is no reason to use this class on its own. 
 * Please refer to the documentation for the other classes.
 * 
 * <p><strong>Copyright 2014, GreenSock. All rights reserved.</strong> This work is subject to the terms in <a href="http://www.greensock.com/terms_of_use.html">http://www.greensock.com/terms_of_use.html</a> or for <a href="http://www.greensock.com/club/">Club GreenSock</a> members, the software agreement that was issued with the membership.</p>
 * 
 * @author Jack Doyle, jack@greensock.com
 */
#if (js)
@:native("DisplayObjectLoader")
#end
extern class DisplayObjectLoader extends LoaderItem
{
	public var rawContent:Dynamic;

	/** By default, LoaderMax will automatically attempt to force garbage collection when a SWFLoader or ImageLoader is unloaded or cancelled but if you prefer to skip this measure, set defaultAutoForceGC to <code>false</code>. If garbage collection isn't forced, sometimes Flash doesn't completely unload swfs/images properly, particularly if there is audio embedded in the root timeline. **/
	public static var defaultAutoForceGC:Bool = true;

	/**
	 * Constructor
	 * 
	 * @param urlOrRequest The url (<code>String</code>) or <code>URLRequest</code> from which the loader should get its content
	 * @param vars An object containing optional parameters like <code>estimatedBytes, name, autoDispose, onComplete, onProgress, onError</code>, etc. For example, <code>{estimatedBytes:2400, name:"myImage1", onComplete:completeHandler}</code>.
	 */
	public function new(urlOrRequest:Dynamic, vars:Dynamic = null);
	
	/** @private Set inside ContentDisplay's or FlexContentDisplay's "loader" setter. **/
	public function setContentDisplay(contentDisplay:Sprite):Void;
	
	/** @inheritDoc **/
	override public function auditSize():Void;

	/** @private works around bug in Flash Player that prevents SWFs from properly being garbage collected after being unloaded - for certain types of objects like swfs, this needs to be run more than once (spread out over several frames) to force Flash to properly garbage collect everything. **/
	public static function forceGC(cycles:Int = 1):Void;
}
