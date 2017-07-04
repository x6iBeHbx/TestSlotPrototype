package core.view.vl
{
   import core.utils.ResourceWarehouse;

   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.events.EventDispatcher;

   public class ViewLogic extends EventDispatcher
   {
      protected var _content:DisplayObjectContainer;

      public function ViewLogic(className:String)
      {
         _content = ResourceWarehouse.getInstance().getAsset(className) as DisplayObjectContainer;
      }

      public function addContent(insContent:DisplayObject):void
      {
         (_content as DisplayObjectContainer).addChild(insContent);
      }

      public function get content():DisplayObject
      {
         return _content as DisplayObject;
      }
   }
}


