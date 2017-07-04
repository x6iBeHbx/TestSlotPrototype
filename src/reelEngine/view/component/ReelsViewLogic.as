package reelEngine.view.component {
   import core.view.vl.ViewLogic;

   import reelEngine.configs.SlotConfiguration;
   import reelEngine.model.dto.ReelDto;

   public class ReelsViewLogic extends ViewLogic {

      private var reels:Vector.<ReelViewLogic> = new <ReelViewLogic>[];
      public function ReelsViewLogic(assetName:String) {
         super(assetName);
      }

      public function createReels(slotConfig:SlotConfiguration):void{

         for(var i:int = 0; i < slotConfig.slotMatrix.length; i++){
            reels.push(new ReelViewLogic(content["reel_" + i]));
            var reel:Array = slotConfig.slotMatrix[i];
            reels[i].createIconsView(reel.length);
         }
      }

      public function addIconsOnReel(reelsData:ReelDto):void{

         reels[reelsData.reelID].addIconsOnReel(reelsData);
      }

      public function addIconsOnTopReel(reelsData:ReelDto):void{

         reels[reelsData.reelID].addIconsOnTopReel(reelsData);
      }
   }
}


