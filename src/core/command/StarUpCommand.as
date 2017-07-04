package core.command {
   import core.config.GeneralNotifications;
   import core.view.mediator.RootMediator;

   import flash.display.Sprite;

   import org.puremvc.as3.interfaces.INotification;
   import org.puremvc.as3.patterns.command.SimpleCommand;

   public class StarUpCommand extends SimpleCommand {
      override public function execute(notifaction:INotification):void {

         var rootSprite:Sprite = notifaction.getBody() as Sprite;

         registerCommands();
         registerMediators(rootSprite);

         var resourceUrl:String = "res/swf/SlotPrototype.swf";

         sendNotification(GeneralNotifications.START_RESOURCE_LOADING, resourceUrl);
      }

      private function registerMediators(root:Sprite):void {

         facade.registerMediator(new RootMediator(root))
      }

      private function registerCommands():void {

         facade.registerCommand(GeneralNotifications.START_RESOURCE_LOADING, LoadResourceCommand);
         facade.registerCommand(GeneralNotifications.START_GAME, StartGameCommand);
      }
   }
}


