package animation.view.component {
   import core.view.vl.ViewLogic;
   import flash.display.MovieClip;
   import reelEngine.configs.SlotConfiguration;

   public class WinLineAnimViewLogic extends ViewLogic {
      private var winLineContainer:MovieClip;
      private var winLines:Vector.<MovieClip>;
      private var slotConfig:SlotConfiguration;
      public function WinLineAnimViewLogic(className:String) {
         super(className);
         slotConfig = new SlotConfiguration();
         initArt();
      }

      private function initArt(){
         winLineContainer = content["win_line_container"];
         winLines = new <MovieClip>[];
         for(var i:int = 0; i < slotConfig.linesCount; i++){
            winLines.push(winLineContainer["win_line_" + i]);
         }

         stopWinLinesAnim();
      }

      public function playWinLines(winLinesId:Array){

         for(var i:int = 0; i < winLinesId.length; i++){
            winLines[winLinesId[i]].gotoAndPlay(1);
         }
      }

      public function stopWinLinesAnim():void{
         for(var i:int = 0; i < slotConfig.linesCount; i++){
            winLines[i].gotoAndStop(1);
         }
      }
   }
}


