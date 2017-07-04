package animation.view.mediator {
   import animation.config.AnimationNotification;
   import animation.view.component.WinLineAnimViewLogic;
   import core.view.mediator.UIMediator;
   import org.puremvc.as3.interfaces.INotification;

   public class WinLineAnimMediator extends UIMediator {

      public static const NAME:String = "WinLineAnimMediator";
      public function WinLineAnimMediator(viewComponent:WinLineAnimViewLogic) {
         super(NAME, viewComponent);
      }

      override public function listNotificationInterests():Array {
         return [
            AnimationNotification.PLAY_WIN_LINES,
            AnimationNotification.STOP_WIN_LINES
            ];
      }

      override public function handleNotification(notification:INotification):void {
         switch (notification.getName()){
            case AnimationNotification.PLAY_WIN_LINES:
               (viewComponent as WinLineAnimViewLogic).playWinLines(notification.getBody() as Array);
               break;
            case AnimationNotification.STOP_WIN_LINES:
               (viewComponent as WinLineAnimViewLogic).stopWinLinesAnim();
               break;
         }
      }
   }
}


