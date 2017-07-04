package reelEngine.command {
   import animation.config.AnimationNotification;

   import cheats.model.proxy.CheatProxy;

   import controlPanel.model.proxy.ControlPanelProxy;

   import core.model.proxy.ServerCaller;

   import org.puremvc.as3.interfaces.INotification;
   import org.puremvc.as3.patterns.command.SimpleCommand;

   import reelEngine.model.proxy.ReelsProxy;

   import reelEngine.model.proxy.spin.SpinProxy;

   public class StartSpinCommand extends SimpleCommand {
      override public function execute(notification:INotification):void{


         for(var i:int = 0; i < reelsProxy.reelsDto.reels.length; i++){
            reelsProxy.reelsDto.reels[i].hasServerResponse = false;
            reelsProxy.reelsDto.reels[i].isStoped = false;
            reelsProxy.reelsDto.reels[i].needStop = false;
         }

         sendNotification(AnimationNotification.STOP_WIN_LINES);

         spinProxy.startSpinRender();

         if(cheatProxy.isCheatActive){
            serverCaller.startSpin(cheatProxy.cheatSet);
         }else{
            serverCaller.startSpin();
         }

         controlPanelProxy.updateUserBalance(-controlPanelProxy.userBet);
      }

      private function get controlPanelProxy():ControlPanelProxy {
         return facade.retrieveProxy(ControlPanelProxy.NAME) as ControlPanelProxy;
      }

      private function get cheatProxy():CheatProxy{
         return facade.retrieveProxy(CheatProxy.NAME) as CheatProxy;
      }

      private function get serverCaller():ServerCaller {
         return facade.retrieveProxy(ServerCaller.NAME) as ServerCaller;
      }

      private function get reelsProxy():ReelsProxy {
         return facade.retrieveProxy(ReelsProxy.NAME) as ReelsProxy;
      }

      private function get spinProxy():SpinProxy {
         return facade.retrieveProxy(SpinProxy.NAME) as SpinProxy;
      }
   }
}


