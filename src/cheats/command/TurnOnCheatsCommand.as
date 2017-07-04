package cheats.command {
   import cheats.model.proxy.CheatProxy;
   import org.puremvc.as3.interfaces.INotification;
   import org.puremvc.as3.patterns.command.SimpleCommand;

   public class TurnOnCheatsCommand extends SimpleCommand {
      override public function execute(notification:INotification):void{

         var cheatIconsArray:Array = notification.getBody() as Array;
         cheatProxy.cheatSet = cheatIconsArray;
         cheatProxy.isCheatActive = true;
      }

      private function get cheatProxy():CheatProxy{
         return facade.retrieveProxy(CheatProxy.NAME) as CheatProxy;
      }
   }
}


