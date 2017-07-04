package reelEngine.model.proxy.spin {
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import flash.utils.setTimeout;

   import reelEngine.configs.ReelsEngineNotification;

   import reelEngine.model.dto.ReelDto;

   import reelEngine.model.dto.ReelsDto;

   import org.puremvc.as3.patterns.proxy.Proxy;

   public class SpinProxy extends Proxy {

      public static const NAME:String = "SpinProxy";
      private var mainScene:DisplayObject;
      private var _reelsDto:ReelsDto;
      private var _speedForSpin:int;
      private var reelStop:Boolean;

      public var reelIDIterator:int = 0;//TODO:Bad idea, need catch from outside

      private var lockUpdate:Boolean;
      public function SpinProxy(data:DisplayObject) {
         super(NAME, data);
         mainScene = data;
         lockUpdate = false;
         reelStop = false;
         reelIDIterator = 0;
      }

      public function set reelsDto(dto:ReelsDto):void{
         _reelsDto = dto;
      }

      public function set speedForSpin(speed:int):void{
         _speedForSpin = speed;
      }

      public function startSpinRender():void{
         mainScene.addEventListener(Event.ENTER_FRAME, updateReelsInfo);
      }

      public function stopSpin():void{

         if(reelIDIterator < _reelsDto.reelsCount){
            _reelsDto.reels[reelIDIterator].needStop = true;
            reelIDIterator++;
            setTimeout(stopSpin, 500);
         }
      }

      public function stopReelsRender():void{
         mainScene.removeEventListener(Event.ENTER_FRAME, updateReelsInfo);
         sendNotification(ReelsEngineNotification.ALL_REELS_STOP);
         reelIDIterator = 0;
      }

      private function updateReelsInfo(e:Event):void{

         if(lockUpdate){
            return;
         }

         checkForAllReelsStop();

         lockUpdate = true;
         for(var i:int = 0; i < _reelsDto.reels.length; i++){
            var reelDto:ReelDto = _reelsDto.reels[i];

            for(var k:int = 0; k < reelDto.icons.length; k++){

               if(reelDto.isStoped){
                  continue;
               }
               reelDto.icons[k].postionY += _speedForSpin;
               reelDto.topIcons[k].postionY += _speedForSpin;
            }

            tryChangeReelMark(reelDto);

            sendNotification(ReelsEngineNotification.UPDATE_REEL, reelDto);
         }

         lockUpdate = false;
      }

      private function tryChangeReelMark(reelDto:ReelDto):void{

         if(reelDto.topIcons[0].postionY >= 0) {

            if(reelDto.hasServerResponse){
               reelDto.isStoped = true;
            }

            copyReelDto(reelDto);
            if (reelDto.needStop && !reelDto.isStoped) {
               sendNotification(ReelsEngineNotification.SET_SERVER_RESPONSE, reelDto);
               reelDto.hasServerResponse = true;
            } else {
               sendNotification(ReelsEngineNotification.GENERATE_TOP_ICONS, reelDto);
            }
         }
      }

      private function copyReelDto(reelDto:ReelDto):void{

         for(var k:int = 0; k < reelDto.icons.length; k++){
            reelDto.icons[k].icon.bitmapData = reelDto.topIcons[k].icon.bitmapData.clone();
            reelDto.icons[k].id = reelDto.topIcons[k].id
            reelDto.icons[k].type = reelDto.topIcons[k].type;
            reelDto.icons[k].postionY = reelDto.needStop ? k * reelDto.icons[k].icon.height : reelDto.topIcons[k].postionY;
            reelDto.topIcons[k].icon.bitmapData.dispose();
         }
      }

      private function checkForAllReelsStop():void{

         for(var i:int = 0; i < _reelsDto.reels.length; i++){
            if(!_reelsDto.reels[i].isStoped){
               return;
            }
         }

         stopReelsRender();
      }
   }
}


