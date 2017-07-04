package reelEngine.command.game {
   import animation.config.AnimationNotification;

   import controlPanel.config.ControlPanelNotification;
   import controlPanel.model.proxy.ControlPanelProxy;

   import org.puremvc.as3.interfaces.INotification;
   import org.puremvc.as3.patterns.command.SimpleCommand;

   import reelEngine.model.proxy.response.ResponseProxy;

   public class AllReelsStopCommand extends SimpleCommand {
      override public function execute(notification:INotification):void{

         var winLinesArray:Array = [];

         for(var i:int = 0; i < responseProxy.responseDto.winLines.length; i++){
            winLinesArray.push(responseProxy.responseDto.winLines[i].lineId);
         }

         sendNotification(AnimationNotification.PLAY_WIN_LINES, winLinesArray);
         controlPanelProxy.updateUserBalance(responseProxy.responseDto.winAmount);
      }

      private function get controlPanelProxy():ControlPanelProxy {
         return facade.retrieveProxy(ControlPanelProxy.NAME) as ControlPanelProxy;
      }

      private function get responseProxy():ResponseProxy{
         return facade.retrieveProxy(ResponseProxy.NAME) as ResponseProxy;
      }
   }
}


