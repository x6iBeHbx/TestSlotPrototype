package server {
   import flash.utils.setTimeout;

   import org.osflash.signals.Signal;

   import reelEngine.util.RandomIconGenerator;

   public class SimpleServer {

      public var startSpinSignal:Signal;
      private var serverProtocol:ResponseProtocol;
      private var serverSlotConfiguration:ServerSlotConfiguration;
      public function SimpleServer() {
         startSpinSignal = new Signal(ResponseProtocol);
         serverProtocol = new ResponseProtocol();
         serverSlotConfiguration = new ServerSlotConfiguration();
      }

      public function SpinStarted(icons:Array = null):void{
         serverProtocol.icons = (icons != null) ?  icons : generateResponseIcons();//[[1,2],[1,3],[1,4],[1,2],[1,3]];
         serverProtocol.winLines = analyzeResponse();
         serverProtocol.winAmount = calculateWinAmount(serverProtocol.winLines);
         setTimeout(sendResponse, 2000);
      }

      private function generateResponseIcons():Array {

         var reelsIcons:Array = [];

         for(var i:int = 0; i < serverSlotConfiguration.slotMatrix.length; i++){
            var iconsCount:int = (serverSlotConfiguration.slotMatrix[i] as Array).length;
            reelsIcons.push(new Array())
            for(var k:int = 0; k < iconsCount; k++){
               reelsIcons[i].push(RandomIconGenerator.generateRandomIconId(serverSlotConfiguration.iconsSet));
            }
         }

         return reelsIcons;
      }

      private function analyzeResponse():Vector.<WinLineDto>{

         var winIconsCount:int;
         var winLinesVector:Vector.<WinLineDto> = new <WinLineDto>[];

         for(var i:int = 0; i < serverSlotConfiguration.winLinesMatrix.length; i++){

            var reelLength:int = (serverSlotConfiguration.winLinesMatrix[i] as Array).length;
            var winLineDto:WinLineDto = new WinLineDto();

            analyzeReelLine(i, reelLength, winLineDto);

            if(winLineDto.iconsCount >= serverSlotConfiguration.minIconsForWinPerLine){
               winLineDto.lineId = i;
               calculateLineWinAmount(winLineDto);
               winLinesVector.push(winLineDto);
            }
         }

         return winLinesVector;
      }

      private function analyzeReelLine(reelId:int, reelLength:int, winLineDto:WinLineDto):void{

         var tempIconId:int = -1;
         var winIconsCount:int = 1;
         var winIconId:int = -1;
         var iconsCount:int = 1;

         for(var k:int = 0; k < reelLength; k++){
            var iconId:int = serverProtocol.icons[k][serverSlotConfiguration.winLinesMatrix[reelId][k]];
            if(tempIconId != iconId){
               iconsCount = 1;
               tempIconId = iconId;
            }else {
               iconsCount++;

               if(iconsCount >= serverSlotConfiguration.minIconsForWinPerLine){
                  winIconId = tempIconId;
                  winIconsCount = iconsCount;
               }
            }
         }
         winLineDto.iconsCount = winIconsCount;
         winLineDto.iconId = winIconId;
      }

      private function calculateWinAmount(winLines:Vector.<WinLineDto>):Number{

         var winAmount:Number = 0;
         for(var i:int = 0; i < winLines.length; i++){
            winAmount += winLines[i].winLineAmount;
         }
         return winAmount;
      }

      private function calculateLineWinAmount(winLineDto:WinLineDto):void{

         var index:int = serverSlotConfiguration.iconsSet.indexOf(winLineDto.iconId);
         var winSum:Number = serverSlotConfiguration.iconsWinSum[index] *
            (serverSlotConfiguration.multipliers[winLineDto.iconsCount - serverSlotConfiguration.minIconsForWinPerLine]);

         winLineDto.winLineAmount = winSum;
      }


      private function sendResponse():void{
         startSpinSignal.dispatch(serverProtocol);
      }
   }
}


