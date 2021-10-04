/**
 * VERSION: 1.0
 * DATE: 2010-06-16
 * AS3
 * UPDATES AND DOCS AT: http://www.greensock.com/loadermax/
 **/
package com.greensock.loading;

/**
 * Defines status values for loaders. 
 * 
 * <p><strong>Copyright 2010-2014, GreenSock. All rights reserved.</strong> This work is subject to the terms in <a href="http://www.greensock.com/terms_of_use.html">http://www.greensock.com/terms_of_use.html</a> or for <a href="http://www.greensock.com/club/">Club GreenSock</a> members, the software agreement that was issued with the membership.</p>
 * 
 * @author Jack Doyle, jack@greensock.com
 */
#if (js)
@:native("LoaderStatus")
#end
extern class LoaderStatus {
	
	/** The loader is ready to load and has not completed yet. **/
	public static inline var READY:Int = 0;
	/** The loader is actively in the process of loading. **/
	public static inline var LOADING:Int = 1;
	/** The loader has completed. **/
	public static inline var COMPLETED:Int = 2;
	/** The loader is paused. **/
	public static inline var PAUSED:Int = 3;
	/** The loader failed and did not load properly. **/
	public static inline var FAILED:Int = 4;
	/** The loader has been disposed. **/
	public static inline var DISPOSED:Int = 5;

	public function new();
}

