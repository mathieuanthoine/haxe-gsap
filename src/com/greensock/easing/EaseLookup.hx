package com.greensock.easing;

/**
 * EaseLookup
 */

#if (js)
@:native("EaseLookup")
#end
extern class EaseLookup 
{
	
	/**
	 * Finds the easing function associated with a particular name (String), like "easeOutStrong".
	 * @param	name The name of the easing function, with or without the period and case insensitive (i.e. "Strong.easeOut" or "easeOutStrong")  
	 * @return The easing function associated with the name
	 */
	static public function find ( name : String ) : Ease;
	
}