package reelEngine.view.mediator {
   import core.view.mediator.UIMediator;

   import reelEngine.configs.ReelsEngineNotification;
   import reelEngine.configs.SlotConfiguration;
   import reelEngine.model.dto.ReelDto;
   import reelEngine.view.component.ReelsViewLogic;

   import org.puremvc.as3.interfaces.INotification;

   public class ReelsMediator extends UIMediator {

      public static const NAME:String = "ReelsMediator";

      public function ReelsMediator(viewComponent:ReelsViewLogic) {
         super(NAME, viewComponent);
      }

      override public function onRegister():void {
         super.onRegister();

         var slotConfig:SlotConfiguration = new SlotConfiguration();
         reelsViewLogic.createReels(slotConfig);
      }

      override public function listNotificationInterests():Array {
         return [
            ReelsEngineNotification.INJECT_VISIBLE_REEL_ICONS,
            ReelsEngineNotification.INJECT_TOP_REEL_ICONS,
            ReelsEngineNotification.UPDATE_REEL,
            ];
      }

      override public function handleNotification(notification:INotification):void {
         var reelDto:ReelDto;
         switch (notification.getName()){
            case ReelsEngineNotification.INJECT_VISIBLE_REEL_ICONS:
               reelDto = notification.getBody() as ReelDto;
               reelsViewLogic.addIconsOnReel(reelDto);
               break;
            case ReelsEngineNotification.INJECT_TOP_REEL_ICONS:
               reelDto = notification.getBody() as ReelDto;
               reelsViewLogic.addIconsOnTopReel(reelDto);
               break;
            case ReelsEngineNotification.UPDATE_REEL:
               reelDto = notification.getBody() as ReelDto;
               reelsViewLogic.addIconsOnReel(reelDto);
               reelsViewLogic.addIconsOnTopReel(reelDto);
               break;
         }
      }

      private function registerListener():void {
      }

      private function get reelsViewLogic():ReelsViewLogic{

         return viewComponent as ReelsViewLogic;
      }
   }
}


