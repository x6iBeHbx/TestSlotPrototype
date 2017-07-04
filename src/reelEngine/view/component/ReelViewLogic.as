package reelEngine.view.component {
   import flash.display.Bitmap;
   import flash.display.MovieClip;

   import reelEngine.model.dto.ReelDto;

   public class ReelViewLogic {

      private var _reel:MovieClip;
      private var _visibleReelIcons:Vector.<Bitmap> = new <Bitmap>[];
      private var _topReelIcons:Vector.<Bitmap> = new <Bitmap>[];

      private var test:*;
      public function ReelViewLogic(reel:MovieClip) {
         _reel = reel;
      }

      public function createIconsView(iconsCount:int):void{

         for(var i:int = 0; i < iconsCount; i++){
            _reel.getChildByName("icon_" + i).visible = false;
         }
      }

      public function addIconsOnReel(reelDto:ReelDto):void{

         for(var i:int = 0; i < reelDto.icons.length; i++){
            var iconId:int = reelDto.icons[i].id;
            reelDto.icons[i].icon.y = reelDto.icons[i].postionY;
            _reel.addChild(reelDto.icons[i].icon);

            _visibleReelIcons.push(reelDto.icons[i].icon);
         }
      }

      public function addIconsOnTopReel(reelDto:ReelDto):void{

         test = reelDto;
         for(var i:int = 0; i < reelDto.topIcons.length; i++){
            var iconId:int = reelDto.topIcons[i].id;
            reelDto.topIcons[i].icon.y = reelDto.topIcons[i].postionY;
            _reel.addChild(reelDto.topIcons[i].icon);

            _topReelIcons.push(reelDto.topIcons[i].icon);
         }
      }
   }
}


