package com.greensock.easing;

/**
 * Elastic
 */
@:native("Elastic")
extern class Elastic extends Ease
{

	public function new(); 
	
	/**
	 * 
	 * @return
	 */
	static public function	easeIn () : Elastic;

	/**
	 * 
	 * @return
	 */
	static public function	easeInOut () : Elastic;
	
	/**
	 * 
	 * @return
	 */
	static public function	easeOut () : Elastic;
	
}