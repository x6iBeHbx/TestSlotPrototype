package core.view.mediator
{

   import core.config.GeneralNotifications;
   import core.view.vl.ViewLogic;

   import org.puremvc.as3.patterns.mediator.Mediator;

   public class UIMediator extends Mediator
   {
      private var _viewComponent:ViewLogic;
      public function UIMediator(NAME:String, viewComponent:ViewLogic)
      {
         super(NAME,viewComponent);
         _viewComponent=viewComponent;
      }
      protected function get viewLogic():ViewLogic
      {
         return viewComponent as ViewLogic;
      }
      override public function onRegister():void
      {
         super.onRegister();
         sendNotification(GeneralNotifications.ADD_CHILD_TO_ROOT, _viewComponent.content);
      }
      override public function onRemove():void
      {
         super.onRemove();
         sendNotification(GeneralNotifications.REMOVE_CHILD_TO_ROOT, _viewComponent.content);
      }
   }
}


