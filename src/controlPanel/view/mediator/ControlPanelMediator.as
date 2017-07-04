package controlPanel.view.mediator {
   import controlPanel.view.component.ControlPanelViewLogic;
   import controlPanel.config.ControlPanelEvents;
   import controlPanel.config.ControlPanelNotification;

   import core.view.mediator.UIMediator;
   import core.view.vl.ViewLogic;

   import flash.events.Event;

   import org.puremvc.as3.interfaces.INotification;

   import reelEngine.configs.ReelsEngineNotification;

   public class ControlPanelMediator extends UIMediator {

      public static const NAME:String = "ControlPanelMediator";
      public function ControlPanelMediator(viewComponent:ControlPanelViewLogic) {
         super(NAME, viewComponent);
      }

      override public function onRegister():void{
         super.onRegister();
         registerListener();
      }

      override public function listNotificationInterests():Array {
         return [
            ReelsEngineNotification.ALL_REELS_STOP,
            ControlPanelNotification.UPDATE_SPIN_BET,
            ControlPanelNotification.UPDATE_USER_BALANCE
            ];
      }

      override public function handleNotification(notification:INotification):void {
         switch (notification.getName()){
            case ReelsEngineNotification.ALL_REELS_STOP:
               (viewComponent as ControlPanelViewLogic).enableSpinBtn();
               break;
            case ControlPanelNotification.UPDATE_SPIN_BET:
               (viewComponent as ControlPanelViewLogic).updateSpinBet(notification.getBody() as Number);
               break;
            case ControlPanelNotification.UPDATE_USER_BALANCE:
               (viewComponent as ControlPanelViewLogic).updateUserBalance(notification.getBody() as Number);
               break;
         }
      }

      private function registerListener():void{

         (viewComponent as ControlPanelViewLogic).addEventListener(ControlPanelEvents.SPIN_BTN_CLICKED, spinBtnClicked);
      }

      private function spinBtnClicked(event:Event):void {
         sendNotification(ReelsEngineNotification.START_SPIN);
      }
   }
}


