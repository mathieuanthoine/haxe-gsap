package com.greensock.events;

import flash.events.Event;

/**
 * Used for dispatching events from the GreenSock Animation Platform. 
 * 	  
 * <p><strong>Copyright 2008-2014, GreenSock. All rights reserved.</strong> This work is subject to the terms in <a href="http://www.greensock.com/terms_of_use.html">http://www.greensock.com/terms_of_use.html</a> or for <a href="http://www.greensock.com/club/">Club GreenSock</a> members, the software agreement that was issued with the membership.</p>
 * 
 * @author Jack Doyle, jack@greensock.com
 */
#if (js)
@:native("TweenEvent")
#end
extern class TweenEvent extends Event
{
	public static inline var VERSION:Float = 12.0;
	public static inline var START:String = "start";
	public static inline var UPDATE:String = "change";
	public static inline var COMPLETE:String = "complete";
	public static inline var REVERSE_COMPLETE:String = "reverseComplete";
	public static inline var REPEAT:String = "repeat";
	
	public function new(type:String, bubbles:Bool = false, cancelable:Bool = false);
}

