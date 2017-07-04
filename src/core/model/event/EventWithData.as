package core.model.event {
   import flash.events.Event;

   public class EventWithData extends Event {

      private var _data:*;
      public function EventWithData(type:String, data:*, bubbles:Boolean = false, cancelable:Boolean = false) {

         super(type, bubbles, cancelable);
         _data = data;
      }

      public function get data():* {
         return _data;
      }
   }
}


