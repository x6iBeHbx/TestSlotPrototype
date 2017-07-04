package reelEngine.command.game {
   import cheats.model.proxy.CheatProxy;

   import reelEngine.model.dto.ReelDto;
   import reelEngine.model.proxy.IconsProxy;

   import org.puremvc.as3.interfaces.INotification;
   import org.puremvc.as3.patterns.command.SimpleCommand;

   import reelEngine.model.proxy.response.ResponseProxy;

   public class SetServerResponseCommand extends SimpleCommand {
      override public function execute(notification:INotification):void{

         var serverResponse:Array = responseProxy.responseDto.icons;
         var reelDto:ReelDto = notification.getBody() as ReelDto;

         setServerResponse(reelDto, serverResponse);
      }

      private function setServerResponse(reel:ReelDto, serverResponse:Array):void {

         for(var i:int = 0; i < reel.icons.length; i++){
            trace();
            reel.topIcons[i].type = serverResponse[reel.reelID][i];
            reel.topIcons[i].icon = iconsProxy.getIconById(reel.topIcons[i].type);
            reel.topIcons[i].postionY = i * reel.topIcons[i].icon.height - (reel.topIcons[i].icon.height * reel.icons.length);
         }
      }

      private function get responseProxy():ResponseProxy{
         return facade.retrieveProxy(ResponseProxy.NAME) as ResponseProxy;
      }

      private function get iconsProxy():IconsProxy{
         return facade.retrieveProxy(IconsProxy.NAME) as IconsProxy;
      }
   }
}


