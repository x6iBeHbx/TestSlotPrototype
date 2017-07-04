package core.command {
   import core.config.GeneralNotifications;
   import core.utils.ResourceWarehouse;

   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.net.URLRequest;

   import org.puremvc.as3.interfaces.INotification;
   import org.puremvc.as3.patterns.command.SimpleCommand;

   public class LoadResourceCommand extends SimpleCommand {
      override public function execute(notification:INotification):void {

         var url:String = notification.getBody() as String;

         var myLoader:Loader = new Loader();
         var urlRequest:URLRequest = new URLRequest(url);

         myLoader.contentLoaderInfo..addEventListener(Event.COMPLETE, loadFinished);

         myLoader.load(urlRequest);

      }

      private function loadFinished(event:Event):void {
         ResourceWarehouse.getInstance().addAsset(event.target.loader as DisplayObject);
         sendNotification(GeneralNotifications.START_GAME);
      }
   }
}


