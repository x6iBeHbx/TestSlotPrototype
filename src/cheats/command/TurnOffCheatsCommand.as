package cheats.command {
   import cheats.model.proxy.CheatProxy;
   import org.puremvc.as3.interfaces.INotification;
   import org.puremvc.as3.patterns.command.SimpleCommand;

   public class TurnOffCheatsCommand extends SimpleCommand {
      override public function execute(notification:INotification):void{

         cheatProxy.isCheatActive = false;
      }

      private function get cheatProxy():CheatProxy{
         return facade.retrieveProxy(CheatProxy.NAME) as CheatProxy;
      }
   }
}


