package reelEngine.command.game {
   import org.puremvc.as3.interfaces.INotification;
   import org.puremvc.as3.patterns.command.SimpleCommand;

   import reelEngine.model.proxy.spin.SpinProxy;

   public class StopSpinCommand extends SimpleCommand {
      override public function execute(notification:INotification):void{

         spinProxy.stopSpin();
      }

      private function get spinProxy():SpinProxy {
         return facade.retrieveProxy(SpinProxy.NAME) as SpinProxy;
      }
   }
}


