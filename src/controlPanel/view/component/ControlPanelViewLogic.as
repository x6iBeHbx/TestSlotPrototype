package controlPanel.view.component {
   import controlPanel.config.ControlPanelEvents;

   import core.view.vl.ViewLogic;

   import flash.display.DisplayObject;

   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;

   public class ControlPanelViewLogic extends ViewLogic {

      private var _controlPanel:MovieClip;
      private var _spinBtn:MovieClip;
      private var _balanceTxt:TextField;
      private var _spinBetTxt:TextField;
      public function ControlPanelViewLogic(className:String) {
         super(className);

         initArt(content);
         registerListener();
      }

      private function initArt(mainScene:DisplayObject):void {

         _controlPanel = mainScene["control_panel"];
         _spinBtn = _controlPanel["spin_btn"];
         _balanceTxt = _controlPanel["user_balance_txt"];
         _spinBetTxt = _controlPanel["spin_bet_txt"];
      }

      public function updateUserBalance(value:Number):void{
         _balanceTxt.text = value.toString();
      }

      public function updateSpinBet(value:Number):void{
         _spinBetTxt.text = value.toString();
      }

      private function registerListener():void{

         _spinBtn.addEventListener(MouseEvent.CLICK, spinBtnClicked);
      }

      private function spinBtnClicked(e:MouseEvent):void{
         _spinBtn.removeEventListener(MouseEvent.CLICK, spinBtnClicked);
         _spinBtn.enabled = false;
         _spinBtn.gotoAndStop("disable");
         dispatchEvent(new Event(ControlPanelEvents.SPIN_BTN_CLICKED));
      }

      public function enableSpinBtn():void{

         _spinBtn.addEventListener(MouseEvent.CLICK, spinBtnClicked);
         _spinBtn.enabled = true;
         _spinBtn.gotoAndStop("enable");
      }
   }
}


