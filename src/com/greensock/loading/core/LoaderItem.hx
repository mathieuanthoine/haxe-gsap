/**
 * VERSION: 1.937
 * DATE: 2014-06-26
 * AS3
 * UPDATES AND DOCS AT: http://www.greensock.com/loadermax/
 **/
package com.greensock.loading.core;

import flash.net.URLRequest;

/**
 * Serves as the base class for all individual loaders (not LoaderMax) like <code>ImageLoader, 
 * XMLLoader, SWFLoader, MP3Loader</code>, etc. There is no reason to use this class on its own. 
 * Please see the documentation for the other classes.
 * 
 * <p><strong>Copyright 2010-2014, GreenSock. All rights reserved.</strong> This work is subject to the terms in <a href="http://www.greensock.com/terms_of_use.html">http://www.greensock.com/terms_of_use.html</a> or for <a href="http://www.greensock.com/club/">Club GreenSock</a> members, the software agreement that was issued with the membership.</p>
 * 
 * @author Jack Doyle, jack@greensock.com
 */
#if (js)
@:native("LoaderItem")
#end
extern class LoaderItem extends LoaderCore
{
	public var url:String;
	public var request:URLRequest;
	public var httpStatus:Int;
	public var scriptAccessDenied:Bool;

	/**
	 * Constructor
	 * 
	 * @param urlOrRequest The url (<code>String</code>) or <code>URLRequest</code> from which the loader should get its content
	 * @param vars An object containing optional parameters like <code>estimatedBytes, name, autoDispose, onComplete, onProgress, onError</code>, etc. For example, <code>{estimatedBytes:2400, name:"myImage1", onComplete:completeHandler}</code>.
	 */
	public function new(urlOrRequest:Dynamic, vars:Dynamic = null);

	/** @inheritDoc **/
	override public function auditSize():Void;
}
