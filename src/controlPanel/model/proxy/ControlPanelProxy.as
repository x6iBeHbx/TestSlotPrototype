package controlPanel.model.proxy {
   import controlPanel.config.ControlPanelNotification;

   import org.puremvc.as3.patterns.proxy.Proxy;

   public class ControlPanelProxy extends Proxy {
      public static const NAME:String = "ControlPanelProxy";

      private var _userBalance:Number;
      private var _spinBet:Number;
      public function ControlPanelProxy(data:Object = null) {
         super(NAME, data);
      }

      public function updateUserBalance(value:Number):void{
         _userBalance += value;
         sendNotification(ControlPanelNotification.UPDATE_USER_BALANCE, _userBalance);
      }

      public function set userBalance(value:Number):void{
         _userBalance = value;
      }

      public function set userBet(value:Number):void{
         _spinBet = value;
      }

      public function get userBalance():Number {
         return _userBalance;
      }

      public function get userBet():Number {
         return _spinBet;
      }
   }
}


