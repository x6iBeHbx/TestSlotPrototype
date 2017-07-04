package cheats.model.proxy {
   import org.puremvc.as3.patterns.proxy.Proxy;

   public class CheatProxy extends Proxy {

      public static const NAME:String = "CheatProxy";

      private var _isCheat:Boolean;
      private var _cheatSet:Array;
      public function CheatProxy(data:Object = null) {
         super(NAME, data);
         _cheatSet = [];
          _isCheat = false;
      }

      public function set cheatSet(array:Array):void{
         _cheatSet = array;
      }

      public function get cheatSet():Array {
         return _cheatSet;
      }

      public function set isCheatActive(value:Boolean):void{
         _isCheat = value;
      }

      public function get isCheatActive():Boolean{
         return _isCheat;
      }
   }
}


