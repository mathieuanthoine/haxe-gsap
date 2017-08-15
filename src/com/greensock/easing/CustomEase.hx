package com.greensock.easing;

/**
* CustomEase
**/

#if (js)
@:native("CustomEase")
#end
extern class CustomEase extends Ease
{
    public function new();
    public function create(curveID:String, curveParams:String):Ease;
}