package reelEngine.model.proxy {
   import reelEngine.model.dto.ReelsDto;

   import org.puremvc.as3.patterns.proxy.Proxy;

   public class ReelsProxy extends Proxy {

      public static const NAME:String = "ReelsProxy";
      public function ReelsProxy(data:Object = null) {
         super(NAME, data);
      }

      public function get reelsDto():ReelsDto{
         return this.data as ReelsDto;
      }
   }
}


