package cheats.view.component {
   import cheats.config.CheatIconsConfiguration;
   import cheats.config.CheatsEvents;
   import core.model.event.EventWithData;
   import core.view.vl.ViewLogic;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;

   public class CheatPanelViewLogic extends ViewLogic {

      private var cheatBtn:MovieClip;
      private var cheatPanel:MovieClip;
      private var resetBtn:MovieClip;
      public function CheatPanelViewLogic(className:String) {
         super(className);

         initArt();
         registerListener();
      }

      private function initArt():void {
         cheatPanel = content["cheat_panel"];
         cheatBtn = cheatPanel["cheat_btn"];
         resetBtn = cheatPanel["reset_btn"];

         disableResetBtn();
      }

      private function registerListener():void{
         resetBtn.addEventListener(MouseEvent.CLICK, resetBtnClicked);
         cheatBtn.addEventListener(MouseEvent.CLICK, cheatBtnClicked);
      }

      private function cheatBtnClicked(e:MouseEvent):void{

         var btn:MovieClip = e.target as MovieClip;

         if(btn.currentLabel == "on"){
            enableResetBtn();
            var cheatIcons:Array = tryReadCheatInfo();
            btn.gotoAndStop("off");
            dispatchEvent(new EventWithData(CheatsEvents.TURN_ON, cheatIcons));
         }else {
            disableResetBtn();
            dispatchEvent(new EventWithData(CheatsEvents.TURN_OFF, null));
            btn.gotoAndStop("on");
         }
      }

      private function enableResetBtn():void{
         resetBtn.enabled = true;
         resetBtn.visible = true;
      }

      private function disableResetBtn():void{
         resetBtn.enabled = false;
         resetBtn.visible = false;
      }

      private function tryReadCheatInfo():Array{

         var reelsArray:Array = [[],[],[],[],[]];
         for(var i:int = 0; i < CheatIconsConfiguration.reelsCount; i++){
            for(var k:int = 0; k < CheatIconsConfiguration.iconsOnReel; k++){
               var text:String = (cheatPanel["reel_" + i + "_icon_" + k] as TextField).text;
               var id:int = getIconsIdByName(text);
               reelsArray[i].push(id);
            }
         }
         return reelsArray;
      }

      private function getIconsIdByName(name:String):int{

         var index:int = CheatIconsConfiguration.iconsName.indexOf(name);
         return (index != -1) ? CheatIconsConfiguration.iconsId[index] : 0;
      }

      private function resetBtnClicked(event:MouseEvent):void {
         dispatchEvent(new EventWithData(CheatsEvents.TURN_ON, tryReadCheatInfo()));
      }
   }
}


