package core.model.proxy {
   import flash.utils.setTimeout;

   import org.puremvc.as3.patterns.proxy.Proxy;

   import reelEngine.configs.ReelsEngineNotification;
   import reelEngine.model.dto.response.ResponseWinLineDto;
   import reelEngine.model.proxy.response.ResponseProxy;

   import server.ResponseProtocol;
   import server.SimpleServer;

   public class ServerCaller extends Proxy {

      public static const NAME:String = "ServerCaller";

      private var simpleServer:SimpleServer;
      public function ServerCaller(data:Object = null) {
         super(NAME, data);

         simpleServer = new SimpleServer();
         simpleServer.startSpinSignal.add(serverResponseReady)
      }

      public function startSpin(icons:Array = null):void{
         simpleServer.SpinStarted(icons);
      }

      public function startSpinWithCheats():void{

      }

      private function serverResponseReady(response:ResponseProtocol):void{
         responseProxy.responseDto.icons = response.icons;
         responseProxy.responseDto.winAmount = response.winAmount;
         responseProxy.responseDto.winLines = parseWinLineDto(response);

         responseProxy.isResponseReady = true;

         sendNotification(ReelsEngineNotification.STOP_SPIN);
      }

      private function parseWinLineDto(response:ResponseProtocol):Vector.<ResponseWinLineDto> {

         var winLines:Vector.<ResponseWinLineDto> = new <ResponseWinLineDto>[];

         for(var i:int = 0; i < response.winLines.length; i++){
            var lineDto:ResponseWinLineDto = new ResponseWinLineDto();
            lineDto.iconId = response.winLines[i].iconId;
            lineDto.iconsCount = response.winLines[i].iconsCount;
            lineDto.lineId = response.winLines[i].lineId;
            lineDto.winLineAmount = response.winLines[i].winLineAmount;

            winLines.push(lineDto)
         }

         return winLines;
      }

      private function get responseProxy():ResponseProxy{
         return facade.retrieveProxy(ResponseProxy.NAME) as ResponseProxy;
      }
   }
}


