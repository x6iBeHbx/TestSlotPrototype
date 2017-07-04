package reelEngine.model.proxy.response {
   import org.puremvc.as3.patterns.proxy.Proxy;

   import reelEngine.model.dto.response.ResponseDto;

   public class ResponseProxy extends Proxy {

      public static const NAME:String = "ResponseProxy";
      private var _responseReady:Boolean;
      public function ResponseProxy(data:ResponseDto) {
         super(NAME, data);
      }

      public function set isResponseReady(value:Boolean):void{
         _responseReady = value;
      }

      public function get isResponseReady():Boolean{
         return _responseReady;
      }

      public function get responseDto():ResponseDto{
         return data as ResponseDto;
      }
   }
}


