package cheats.view.mediator {
   import cheats.config.CheatNotification;
   import cheats.config.CheatsEvents;
   import cheats.view.component.CheatPanelViewLogic;
   import core.model.event.EventWithData;
   import core.view.mediator.UIMediator;

   public class CheatMediator extends UIMediator {

      public static const NAME:String = "CheatMediator";
      public function CheatMediator(viewComponent:CheatPanelViewLogic) {
         super(NAME, viewComponent);
      }

      override public function onRegister():void {
         super.onRegister();

         (viewComponent as CheatPanelViewLogic).addEventListener(CheatsEvents.TURN_ON, cheatTurnOn);
         (viewComponent as CheatPanelViewLogic).addEventListener(CheatsEvents.TURN_OFF, cheatTurnOff);
      }

      private function cheatTurnOn(event:EventWithData):void {

         sendNotification(CheatNotification.TURN_ON_CHEATS, event.data);
      }

      private function cheatTurnOff(event:EventWithData):void {

         sendNotification(CheatNotification.TURN_OFF_CHEATS);
      }
   }
}


